from nsetools import Nse
from nsepy import get_history
from datetime import date
import time
import datetime
from calendar import monthrange
import numpy
nse = Nse()


data_dir = 'D:/wm_data/'
db_host = '127.0.0.1'
db_user = 'wealth_manager'
db_user_password = 'Rome2017'
db_table = 'wm'

def todays_date():
  to_date = date.today()
  now_year = int(to_date.strftime("%Y"))
  now_month = int(to_date.strftime("%m"))
  now_date = int(to_date.strftime("%d"))
  return now_date,now_month,now_year

def download_market_data(current_year,current_month,stock_symbol,workbook_path,row):
  #monthly_close_price_list = []
  col = 2
  for year_count in range(0, 11):
    for month_count in range(12, 0, -1):
      last_day_of_month = monthrange(current_year-year_count, month_count)[1]
      if year_count == 0 and current_month - month_count > 0:
        stock_hist_price = get_history(symbol=stock_symbol, start=date(current_year, month_count, int('1')), end=date(current_year, month_count, int(last_day_of_month)))
        #print(str(current_year) + '-' + str(month_count),stock_symbol, stock_hist_price["Close"].mean())
        #write_to_workbook(workbook_path,row,col,stock_hist_price["Close"].mean())
        #col = col+1
        #print(list(stock_hist_price))
        print(stock_hist_price)
        '''
        Symbol = stock_hist_price['Symbol']
        Series,Prev_Close,Last = stock_hist_price['Series'][1],stock_hist_price['Prev Close'][1],stock_hist_price['Last']
        Open,High,Low,Close = stock_hist_price['Open'],stock_hist_price['High'],stock_hist_price['Low'],stock_hist_price['Close']
        VWAP,Volume,Turnover, = stock_hist_price['VWAP'],stock_hist_price['Volume'],stock_hist_price['Turnover']
        Trades,Deliverable_Volume,Percent_Deliverble= stock_hist_price['Trades'],stock_hist_price['Deliverable Volume'],stock_hist_price['Deliverble']
        
        print(Symbol,Prev_Close,Open,High,Low,Last,Close,VWAP,Volume,Turnover,Trades,Deliverable_Volume,Percent_Deliverble)
        print('break')
        '''

      elif year_count > 0:
        stock_hist_price = get_history(symbol=stock_symbol, start=date(current_year-year_count, month_count, int('1')), end=date(current_year-year_count, month_count, int(last_day_of_month)))
        #print(stock_symbol,date(current_year-year_count,month_count,current_date), stock_hist_price["Close"].mean())
        #print(stock_symbol, str(current_year-year_count)+'-'+str(month_count),stock_hist_price["Close"].mean())
        #monthly_close_price_list.append(stock_hist_price["Close"].mean())
        #print(str(current_year-year_count) + '-' + str(month_count), stock_symbol, stock_hist_price["Close"].mean())
        #write_to_workbook(workbook_path, row, col, stock_hist_price["Close"].mean())
        #col = col+1
        print(stock_hist_price)
  #print(monthly_close_price_list)
  #write_to_workbook(workbook_path,row,1,stock_symbol)

def download_ten_year_market_data(yr,mon,symbol,conn):   #,host, user, password, table):
  stock_hist_price = get_history(symbol=symbol,start=date(yr-10,mon-1,1),end=date(yr,mon-1,1))
  stock_hist_price = stock_hist_price.replace(numpy.nan,'NULL', regex=True)
  for md_date, row in stock_hist_price.iterrows():
    Symbol, Series, Prev_Close, Open = row['Symbol'], row['Series'], row['Prev Close'], row['Open']
    High, Low, Last, Close, VWAP, Volume = row['High'], row['Low'], row['Last'], row['Close'], row['VWAP'], row['Volume']
    Turnover, Deliverable_Volume, Deliverble, Trades = row['Turnover'],row['Deliverable Volume'],row['%Deliverble'],row['Trades']
    #print(md_date, Symbol, Series, Prev_Close, Open, High, Low, Last, Close, VWAP, Volume, Turnover, Deliverable_Volume,
    #      Deliverble, Trades)
    #connect_database(conn,md_date, Symbol, Series, Prev_Close, Open, High, Low, Last, Close, VWAP, Volume, Turnover, Deliverable_Volume, Deliverble, Trades)

def connect_database(conn,md_date,Symbol, Series, Prev_Close, Open, High, Low, Last, Close, VWAP, Volume, Turnover, Deliverable_Volume, Deliverble, Trades):
  #md_date, Symbol, Series, Prev_Close, Open, High, Low, Last, Close, VWAP, Volume, Turnover, Deliverable_Volume, Deliverble, Trades = '2019-2-2','AJEET','EQ',37.05,37.9,38.9,36.75,38.0,38.0,37.99,21920,57412625000.0,8527,0.5664,282.0
  #print(md_date, Symbol, Series, Prev_Close, Open, High, Low, Last, Close, VWAP, Volume, Turnover, Deliverable_Volume, Deliverble, Trades)
  #conn = pymssql.connect(host, user, password, table)
  #cursor.execute(f"select * from dbo.wm_market_data where md_symbol = '{Symbol}' and md_date = '{md_date}'")
  #db_entry = cursor.rowcount
  #print('db_entry = ', db_entry)
  #if db_entry == 0:
  insert_query =  f"use wm " \
                      f"insert into dbo.wm_market_data " \
                      f"(md_date,md_symbol,md_series,md_prev_close,md_open,md_High,md_Low,md_last,md_close,md_vwap,md_volume,md_turnover,md_Deliverable_Volume, md_Deliverble,md_Trades) " \
                      f"values " \
                      f"('{md_date}','{Symbol}','{Series}', {Prev_Close}, {Open}, {High}, {Low}, {Last}, {Close}, {VWAP}, {Volume}, {Turnover}, {Deliverable_Volume}, {Deliverble}, {Trades})"
  #print(insert_query)
  cursor = conn.cursor()
  cursor.execute(insert_query)
  conn.commit()
  #print(md_date, Symbol, Series, Prev_Close, Open, High, Low, Last, Close, VWAP, Volume, Turnover, Deliverable_Volume,Deliverble, Trades)
  #for row in cursor:
  #print(row)
  #conn.close()

current_date,current_month,current_year = todays_date()
sym_list_query = "use wm; select symbol from dbo.symbol_list;"
#row = 2
df = datahandler.read_db_data(sym_list_query)
symbol_download_count = 0
for stock_symbol, stock_name in nse_listed_stock.items():
  #stock_downloaded = check_for_symbol_data(workbook_path, row, stock_symbol)
  #print(stock_symbol,' exists in sheet = ' , stock_downloaded)
  #if stock_downloaded == False:
  print(datetime.datetime.now(),' downloading: ' + stock_symbol)
  check_symbol_list_in_db = f"select symbol from symbol_list where symbol = '{stock_symbol}'"
  cursor = conn.cursor()
  cursor.execute(check_symbol_list_in_db)
  symbol_downloaded = cursor.rowcount
  if symbol_downloaded == 0:
    symbol_download_count = symbol_download_count +1
    if symbol_download_count == 1:
      delete_existing_db_entries = f"delete from dbo.wm_market_data where md_symbol = '{stock_symbol}'"
      cursor.execute(delete_existing_db_entries)
      conn.commit()
      #download_market_data(current_year,current_month, stock_symbol, workbook_path, row)
    download_ten_year_market_data(current_year,current_month, stock_symbol,conn)     #,db_host, db_user, db_user_password, db_table)
    stock_name = stock_name.replace("'","")
    insert_symbol = f"use wm insert into dbo.symbol_list (symbol,name) values ('{stock_symbol}','{stock_name}')"
    #print(insert_symbol)
    cursor =conn.cursor()
    cursor.execute(insert_symbol)
    conn.commit()
  else:
    print(datetime.datetime.now(), stock_symbol + ' already in db ' )
conn.close()