from nsepy import get_history
from datetime import date
from datetime import datetime, timedelta
import numpy
import datahandler

curr_date = date.today()
curr_year = int(curr_date.strftime("%Y"))
curr_month = int(curr_date.strftime("%m"))
curr_date = int(curr_date.strftime("%d"))
sym_list_query = "use wm; select symbol from dbo.symbol_list;"
df = datahandler.read_db_data(sym_list_query)

for index, row in df.iterrows():
    symbol = row['symbol']
    print(datetime.now(),' downloading: ' + symbol)
    df_downloaded_data = datahandler.read_db_data(f"select max(date) from historical_market_data where Symbol = '{symbol}'") # db check for last date of market data download
    db_latest_date = str(df_downloaded_data.to_string(index=False)).strip()
    if db_latest_date != 'None':  # For every data already present in DB, this condition avoids checking DB and downloading already downloaded data. Saves time
        db_latest_date = datetime.strptime(db_latest_date,'%Y-%m-%d').date()
        db_latest_date = db_latest_date - timedelta(1)
        start_year, start_month, start_day = int(db_latest_date.strftime("%Y")), int(db_latest_date.strftime("%m")), int(db_latest_date.strftime("%d"))
        stock_hist_price = get_history(symbol=symbol, start=date(start_year, start_month, start_day), end=date(curr_year, curr_month - 1, 1))

    else:
        stock_hist_price = get_history(symbol=symbol, start=date(curr_year - 10, curr_month - 1, 1), end=date(curr_year, curr_month - 1, 1))

    stock_hist_price = stock_hist_price.replace(numpy.nan, 'NULL', regex=True)
    for md_date, row in stock_hist_price.iterrows():
        Symbol, Series, Prev_Close, Open = row['Symbol'], row['Series'], row['Prev Close'], row['Open']
        High, Low, Last, Close, VWAP, Volume = row['High'], row['Low'], row['Last'], row['Close'], row['VWAP'], row['Volume']
        Turnover, Deliverable_Volume, percent_Deliverble, Trades = row['Turnover'], row['Deliverable Volume'], row['%Deliverble'], row['Trades']
        insert_query = f"insert into dbo.historical_market_data " \
                f"([date], [symbol], [series], [prev_close], [open], [High], [Low], [last], [close], [vwap], [volume], [turnover], [Deliverable_Volume], [percent_Deliverble], [Trades]) " \
                f"values " \
                f"('{md_date}','{Symbol}','{Series}', {Prev_Close}, {Open}, {High}, {Low}, {Last}, {Close}, {VWAP}, {Volume}, {Turnover}, {Deliverable_Volume}, {percent_Deliverble}, {Trades})"

        df_check_db_presence = datahandler.read_db_data(f"select CONCAT(Symbol,date) from historical_market_data where date = '{md_date}'")
        if (str(symbol) + str(md_date)) in df_check_db_presence.values: # makes that no duplicate data in inserted into DB
            print(symbol, 'for', md_date, "data already in database")
        else:
            print(insert_query)
            datahandler.insert_into_db_data(insert_query)
