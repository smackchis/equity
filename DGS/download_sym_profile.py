from yahoofinancials import YahooFinancials
import datahandler
from pandas_finance import Equity


def write_profile_to_db(data):
    for sym, profile in data.items():
        columns_string = 'insert into sym_profile (sym '
        values_string = 'values ('
        values_string = values_string + "'" + str(sym) + "'"

        if profile != None:
            for col, val in profile.items():
                columns_string = columns_string + ', ' + str(col)
                if val == None:
                    val = 'NULL'
                values_string = values_string + ", '" + str(val) + "'"
        columns_string = columns_string + ')'
        values_string = values_string + ')'
        insert_query = columns_string + ' ' + values_string
        print(insert_query)
        datahandler.insert_into_db_data(insert_query)

sym_profile_query = 'use wm; select distinct sym from dbo.sym_profile'
sym_list_query = "use wm; select symbol from dbo.symbol_list;"
df = datahandler.read_db_data(sym_list_query)
df_downloaded_symbol = datahandler .read_db_data(sym_profile_query)
for index, row in df.iterrows():
    sym = row['symbol'] + '.BO'
    if sym not in df_downloaded_symbol.values:
        yahoo_financials = YahooFinancials(sym)
        equity_sym_data = yahoo_financials.get_stock_quote_type_data()
        equity_profile_data = equity_sym_data[sym]

        if equity_profile_data != None:

            try:
                get_profile = Equity(sym)
                equity_profile_data['sector'] = get_profile.sector
                equity_profile_data['industry'] = get_profile.industry
                print(equity_sym_data)
            except:
                equity_profile_data['sector'] = 'NULL'
                equity_profile_data['industry'] = 'NULL'
                print(equity_sym_data)
        print(equity_sym_data)
        write_profile_to_db(equity_sym_data)

    else:
        print(sym, "Already present in DB")