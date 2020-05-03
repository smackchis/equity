import datahandler
import pandas
import stats

liquidity_symbols_query = 'select distinct symbol from dbo.liquidity_ratios'
df = datahandler.read_db_data(liquidity_symbols_query)
datahandler.insert_into_db_data('delete from liquidity_risk_model_values')
for index, row in df.iterrows():
    sym = row['symbol']
    credit_ratios_query = f"select symbol, acidTestRatioOrQuickRatio, cashRatio, currentRatio from liquidity_ratios where symbol = '{sym}'"
    df_credit_ratios = datahandler.read_db_data(credit_ratios_query)


    wt_mean_acidTestRatioOrQuickRatio = stats.time_weighted_mean(df_credit_ratios['acidTestRatioOrQuickRatio'].tolist())
    wt_std_dev_acidTestRatioOrQuickRatio = stats.time_weighted_std_dev(df_credit_ratios['acidTestRatioOrQuickRatio'].tolist())
    max_wt_conf_level_acidTestRatioOrQuickRatio, min_wt_conf_level_acidTestRatioOrQuickRatio = stats.time_weighted_confidence_level(df_credit_ratios['acidTestRatioOrQuickRatio'].tolist())

    if min_wt_conf_level_acidTestRatioOrQuickRatio < 0.8:
        grade_acidTestRatioOrQuickRatio = 'E'
    elif (min_wt_conf_level_acidTestRatioOrQuickRatio >= 0.8) and (min_wt_conf_level_acidTestRatioOrQuickRatio < 1.2):
        grade_acidTestRatioOrQuickRatio = 'D'
    elif (min_wt_conf_level_acidTestRatioOrQuickRatio >= 1.2) and (min_wt_conf_level_acidTestRatioOrQuickRatio < 2):
        grade_acidTestRatioOrQuickRatio = 'C'
    elif (min_wt_conf_level_acidTestRatioOrQuickRatio >= 2) and (min_wt_conf_level_acidTestRatioOrQuickRatio < 5):
        grade_acidTestRatioOrQuickRatio = 'B'
    elif (min_wt_conf_level_acidTestRatioOrQuickRatio >= 5):
        grade_acidTestRatioOrQuickRatio = 'A'


    wt_mean_cashRatio = stats.time_weighted_mean(df_credit_ratios['cashRatio'].tolist())
    wt_std_dev_cashRatio = stats.time_weighted_std_dev(df_credit_ratios['cashRatio'].tolist())
    max_wt_conf_level_cashRatio, min_wt_conf_level_cashRatio = stats.time_weighted_confidence_level(df_credit_ratios['cashRatio'].tolist())
    if min_wt_conf_level_cashRatio < 0.8:
        grade_cashRatio = 'E'
    elif (min_wt_conf_level_cashRatio >= 0.8) and (min_wt_conf_level_cashRatio < 1.2):
        grade_cashRatio = 'D'
    elif (min_wt_conf_level_cashRatio >= 1.2) and (min_wt_conf_level_cashRatio < 2):
        grade_cashRatio = 'C'
    elif (min_wt_conf_level_cashRatio >= 2) and (min_wt_conf_level_cashRatio < 5):
        grade_cashRatio = 'B'
    elif (min_wt_conf_level_cashRatio >= 5):
        grade_cashRatio = 'A'


    wt_mean_currentRatio = stats.time_weighted_mean(df_credit_ratios['currentRatio'].tolist())
    wt_std_dev_currentRatio = stats.time_weighted_std_dev(df_credit_ratios['currentRatio'].tolist())
    max_wt_conf_level_currentRatio, min_wt_conf_level_currentRatio = stats.time_weighted_confidence_level(df_credit_ratios['currentRatio'].tolist())
    if min_wt_conf_level_currentRatio < 0.8:
        grade_currentRatio = 'E'
    elif (min_wt_conf_level_currentRatio >= 0.8) and (min_wt_conf_level_currentRatio < 1.2):
        grade_currentRatio = 'D'
    elif (min_wt_conf_level_currentRatio >= 1.2) and (min_wt_conf_level_currentRatio < 2):
        grade_currentRatio = 'C'
    elif (min_wt_conf_level_currentRatio >= 2) and (min_wt_conf_level_currentRatio < 5):
        grade_currentRatio = 'B'
    elif (min_wt_conf_level_currentRatio >= 5):
        grade_currentRatio = 'A'

    #print(sym, wt_mean_acidTestRatioOrQuickRatio, wt_std_dev_acidTestRatioOrQuickRatio, max_wt_conf_level_acidTestRatioOrQuickRatio, min_wt_conf_level_acidTestRatioOrQuickRatio, grade_acidTestRatioOrQuickRatio, \
    #     wt_mean_cashRatio, wt_std_dev_cashRatio, max_wt_conf_level_cashRatio, min_wt_conf_level_cashRatio, grade_cashRatio, \
    #     wt_mean_currentRatio, wt_std_dev_currentRatio, max_wt_conf_level_currentRatio, min_wt_conf_level_currentRatio, grade_currentRatio)

    insert_query = f"insert into liquidity_risk_model_values([symbol]," \
        f"[wt_mean_acidTestRatioOrQuickRatio],[wt_std_dev_acidTestRatioOrQuickRatio],[max_wt_conf_level_acidTestRatioOrQuickRatio],[min_wt_conf_level_acidTestRatioOrQuickRatio],[grade_acidTestRatioOrQuickRatio]," \
        f"[wt_mean_cashRatio],[wt_std_dev_cashRatio],[max_wt_conf_level_cashRatio],[min_wt_conf_level_cashRatio],[grade_cashRatio]," \
        f"[wt_mean_currentRatio],[wt_std_dev_currentRatio],[max_wt_conf_level_currentRatio],[min_wt_conf_level_currentRatio],[grade_currentRatio]) " \
        f"values (" \
        f"'{sym}', '{wt_mean_acidTestRatioOrQuickRatio}','{wt_std_dev_acidTestRatioOrQuickRatio}','{max_wt_conf_level_acidTestRatioOrQuickRatio}','{min_wt_conf_level_acidTestRatioOrQuickRatio}', '{grade_acidTestRatioOrQuickRatio}'," \
        f"'{wt_mean_cashRatio}','{wt_std_dev_cashRatio}','{max_wt_conf_level_cashRatio}','{min_wt_conf_level_cashRatio}','{grade_cashRatio}', " \
        f"'{wt_mean_currentRatio}','{wt_std_dev_currentRatio}','{max_wt_conf_level_currentRatio}','{min_wt_conf_level_currentRatio}','{grade_currentRatio}')"

    insert_query = insert_query.replace('nan','')
    print(insert_query)
    datahandler.insert_into_db_data(insert_query)
