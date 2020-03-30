from yahoofinancials import YahooFinancials
import datahandler
import pandas as pd

sym_list_query = "use wm; select symbol from dbo.symbol_list;"
qtr_bal_sheet_symbols_query = 'use wm; select distinct symbol from dbo.qtr_bal_sheet'
qtr_bal_sheet_db_table = 'dbo.qtr_bal_sheet'

df_downloaded_symbol = datahandler.read_db_data(qtr_bal_sheet_symbols_query)
df = datahandler.read_db_data(sym_list_query)
for index, row in df.iterrows():
    sym = row['symbol'] + '.BO'
    if sym not in df_downloaded_symbol.values:
        print(sym, "downloading quarterly balance sheet")
        yahoo_financials = YahooFinancials(sym)
        QuarterlyBalSheetData = yahoo_financials.get_financial_stmts('quarterly', 'balance')
        print(QuarterlyBalSheetData)
        datahandler.write_fin_to_db(QuarterlyBalSheetData, qtr_bal_sheet_db_table)
    else:
        print(sym, "Already present in DB")
