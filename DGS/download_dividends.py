from yahoofinancials import YahooFinancials
import datahandler
from datetime import date
from datetime import datetime, timedelta

curr_date = date.today()
curr_year = int(curr_date.strftime("%Y"))
curr_month = int(curr_date.strftime("%m"))
curr_day = int(curr_date.strftime("%d"))

sym_list_query = "use wm; select symbol from dbo.symbol_list;"
existing_dividends_query = 'use wm; select distinct concat([symbol],[date]) from dbo.dividends'
df = datahandler.read_db_data(sym_list_query)
df_downloaded_dividends = datahandler.read_db_data(existing_dividends_query)
for index, row in df.iterrows():
    sym = row['symbol'] + '.BO'
    print(sym, "downloading dividends")
    yahoo_financials = YahooFinancials(sym)
    start_date = (datahandler.read_db_data(f"use wm;select max([date]) from dividends where symbol = '{sym}'")).to_string(index=False).strip()
    if start_date == 'None':
        start_date = '2010-01-01'
    dividends = yahoo_financials.get_daily_dividend_data(str(start_date), str(date.today()))
    #print(dividends)
    for parsed_sym, parsed_list in dividends.items():
        #print(parsed_sym)
        if parsed_list != None:
            for parsed_elements in parsed_list:
                #print(parsed_elements)
                insert_query = f"\n insert into dividends ([symbol], [date], [amount]) values ("
                #print(parsed_sym)
                if parsed_sym != None:
                    sym_value = parsed_sym
                    insert_query = insert_query + f" '{parsed_sym}',"
                for parsed_dict, parsed_value in parsed_elements.items():
                    #print(parsed_dict, parsed_value)
                    if parsed_dict == 'formatted_date':
                        date_value = parsed_value
                        insert_query = insert_query + f" '{parsed_value}',"
                    if parsed_dict == 'amount':
                        amount_value = parsed_value
                        insert_query = insert_query + f" '{parsed_value}')"

                try:

                    if (sym_value+date_value) not in df_downloaded_dividends.values:
                        print(insert_query)
                        datahandler.insert_into_db_data(insert_query)
                    else:
                        print("Dividend for", sym_value, date_value, "already present in database")
                except:
                    pass