import datetime
import pandas
import numpy
import datahandler

symbol_query = 'select distinct symbol from historical_market_data order by symbol'
datahandler.insert_into_db_data('delete from equity_correlation_model_vales')
df_symbols = datahandler.read_db_data(symbol_query)


for index, col1 in df_symbols.iterrows():

    sym1 = col1['symbol']
    insert_query = ''
    for index, col2 in df_symbols.iterrows():
        sym2 = col2['symbol']
        query = f"select md1.symbol as sym1, md2.Symbol as sym2, md1.[date], md1.[Close] as c1, md2.[Close] as c2 " \
            f"from historical_market_data as md1 " \
            f"inner join historical_market_data as md2 " \
            f"on md1.[date] = md2.[date] " \
            f"where md1.symbol = '{sym1}' and md2.Symbol = '{sym2}' order by date"
        try:
            df_price = datahandler.read_db_data(query)
        except:
            pass
        cor_cof = numpy.corrcoef(df_price['c1'].tolist(), df_price['c2'].tolist())[0, 1]
        if str(cor_cof) == 'nan':
            cor_cof == 0
        print(datetime.datetime.now(),sym1, sym2, cor_cof)
        insert_query = f"\n insert into equity_correlation_model_vales " \
            f"([sym1], [sym2], [correlation_coefficient])" \
            f"values ('{sym1}','{sym2}','{cor_cof}');"
        try:
            datahandler.insert_into_db_data(insert_query)
        except:
            pass