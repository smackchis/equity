from yahoofinancials import YahooFinancials
import datahandler
import pandas as pd

sym_list_query = "use wm; select symbol from dbo.symbol_list;"
bal_sheet_db_table = 'dbo.ann_bal_sheet'

df = datahandler.read_db_data(sym_list_query)
for index, row in df.iterrows():
    sym = row['symbol'] + '.BO'
    print(sym)
    yahoo_financials = YahooFinancials(sym)
    AnnualBalSheetData = yahoo_financials.get_financial_stmts('annual', 'balance')
    print(AnnualBalSheetData)
    datahandler.write_fin_to_db(AnnualBalSheetData, bal_sheet_db_table)
