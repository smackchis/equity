from yahoofinancials import YahooFinancials
import datahandler
import pandas as pd

sym_list_query = "use wm; select symbol from dbo.symbol_list;"
qtr_incm_stmt_db_query = 'use wm; select distinct symbol from dbo.qtr_incm_stmt'
qtr_incm_stmt_db_table = 'dbo.qtr_incm_stmt'
df = datahandler.read_db_data(sym_list_query)
df_downloaded_symbol = datahandler.read_db_data(qtr_incm_stmt_db_query)
for index, row in df.iterrows():
    sym = row['symbol'] + '.BO'
    if sym not in df_downloaded_symbol.values:
        print(sym, "downloading quarterly income statement")
        yahoo_financials = YahooFinancials(sym)
        QuarterlyIncmStmtData = yahoo_financials.get_financial_stmts('quarterly', 'income')
        print(QuarterlyIncmStmtData)
        datahandler.write_fin_to_db(QuarterlyIncmStmtData, qtr_incm_stmt_db_table)
    else:
        print(sym,"Already present in DB")
