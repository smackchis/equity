from yahoofinancials import YahooFinancials
import datahandler
import pandas as pd

sym_list_query = "use wm; select symbol from dbo.symbol_list;"
ann_bal_sheet_symbols_query = 'use wm; select distinct symbol from dbo.ann_bal_sheet'
ann_bal_sheet_db_table = 'dbo.ann_bal_sheet'
df = datahandler.read_db_data(sym_list_query)
df_downloaded_symbol = datahandler.read_db_data(ann_bal_sheet_symbols_query)
for index, row in df.iterrows():
    sym = row['symbol'] + '.BO'
    if sym not in df_downloaded_symbol.values:
        print(sym, "downloading annual balance sheet")
        yahoo_financials = YahooFinancials(sym)
        AnnualBalSheetData = yahoo_financials.get_financial_stmts('annual', 'balance')
        print(AnnualBalSheetData)
        datahandler.write_fin_to_db(AnnualBalSheetData, ann_bal_sheet_db_table)
    else:
        print(sym,"Already present in DB")
