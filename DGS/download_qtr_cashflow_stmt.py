from yahoofinancials import YahooFinancials
import datahandler
import pandas as pd

sym_list_query = "use wm; select symbol from dbo.symbol_list;"
qtr_cflow_stmt_symbols_query = 'use wm; select distinct symbol from dbo.qtr_cflow_stmt'
qtr_cflow_stmt_db_table = 'dbo.qtr_cflow_stmt'
df = datahandler.read_db_data(sym_list_query)
df_downloaded_symbol = datahandler.read_db_data(qtr_cflow_stmt_symbols_query)
for index, row in df.iterrows():
    sym = row['symbol'] + '.BO'
    if sym not in df_downloaded_symbol.values:
        print(sym, "downloading quarterly cashflow statement")
        yahoo_financials = YahooFinancials(sym)
        AnnualCflowSheetData = yahoo_financials.get_financial_stmts('quarterly', 'cash')
        print(AnnualCflowSheetData)
        datahandler.write_fin_to_db(AnnualCflowSheetData, qtr_cflow_stmt_db_table)
    else:
        print(sym,"Already present in DB")
