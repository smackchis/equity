from yahoofinancials import YahooFinancials
import datahandler
from datetime import date

sym_list_query = "use wm; select symbol from dbo.symbol_list;"
existing_key_statistics_query = 'use wm; select distinct concat([symbol],[date]) from dbo.key_statistics'
df = datahandler.read_db_data(sym_list_query)
df_downloaded_key_statistics = datahandler.read_db_data(existing_key_statistics_query)
for index, row in df.iterrows():
    sym = row['symbol'] + '.BO'
    print(sym, "downloading Key financials")
    if (sym + str(date.today())) not in df_downloaded_key_statistics.values:
        yahoo_financials = YahooFinancials(sym)
        key_stats = yahoo_financials.get_key_statistics_data()
        for parsed_sym, parsed_dict in key_stats.items():

            if parsed_dict != None:
                db_col, db_values,insert_query = "","",""
                for key, data in parsed_dict.items():
                    #print(key, data)
                    db_col = db_col + f" ,[{key}]"
                    if data != None and data != '-':
                        db_values = db_values + f", '{data}'"
                    else:
                        db_values = db_values + ", NULL"
                insert_query = "insert into key_statistics ( [symbol], [date] " + db_col + f") values ( '{parsed_sym}' ,'{str(date.today())}' " + db_values + ")"

                print(insert_query)
                datahandler.insert_into_db_data(insert_query)
    else:
        print("key_statistics for", sym, str(date.today()),  "already present in database")
