import statistics
import numpy as np
import statistics
import array as arr
from array import *
from statsmodels.stats.weightstats import DescrStatsW


    def time_weighted_list(my_list):

        '''
            time_weighted_list takes a list as input and gives a list of time aggregated weighted value
            Example: if liquity ratio list contains values [0.7,0.6,0.5] for year1, year2 and year3 resp
            Time weight value list is calculated [((1+ 0.7)^1/1)) - 1, ((1 + 0.6)^1/2) - 1 , ((1 + 0.5)^1/3) -1 ]
        '''

        tot_agg_value = 0
        power = 0
        time_value_powered_list = []
        weight_list = []
        neg_ratio = False                               # Added to handle negative ratio
        for ratio in my_list:
            if ratio < 0:                               # Added to handle negative ratio
                neg_ratio = True                        # Added to handle negative ratio
                ratio = ratio * -1                      # Added to handle negative ratio
            power = power + 1
            temp = pow(ratio+1,1/power)
            temp = temp - 1
            if (neg_ratio):                             # Added to handle negative ratio
                temp = temp * -1                        # Added to handle negative ratio
            time_value_powered_list.append(temp)
            tot_agg_value = tot_agg_value + temp
        neg_ratio = False                               # Added to handle negative ratio
        if tot_agg_value != 0:
            [weight_list.append(wg/tot_agg_value) for wg in time_value_powered_list]
        else:
            [weight_list.append(0) for wg in time_value_powered_list]
        #print('weighted list is', weight_list)
        return weight_list


    def time_weighted_mean(*args):

        '''
            yearly_aggregated_liq_ratio takes in a list of ratios weights them by their time_weighted_list resp
            then calculates weighted mean of the ratios
            example:
            if ratios(R1 and R2) passed in are ([0.635506753, 0.625169023, 0.596464017, 0.580231788], [1.056253329, 1.00889652, 0.912097017, 0.864069359])
            It calculates  time_weighted_list  ( [0.5294718960410701, 0.22896702014074774, 0.14058962716117895, 0.10097145665700316], [0.560864721680152, 0.22161346283750558, 0.12806809807976313, 0.08945371740257926])
            then multiplies corresposding elements and averages them out
            Basically above formula gives a sense of liquidity credibility of the company taking historical liquidity ratio
        '''

        weighted_sum_list = []
        #print('args are ',args)
        for items in args:
            #print('time_weighted_mean item is',items)
            weighted_sum = 0
            weight_list = fin_stats.time_weighted_list(items)
            for i in range(0, len(items)):
                weighted_sum = weighted_sum + (items[i] * weight_list[i])
                #print(items[i], weight_list[i], weighted_sum)
            weighted_sum_list.append(weighted_sum)

        #print('Time weighted average value list', weighted_sum_list)
        return weighted_sum_list



    def time_weighted_std_dev(*args):

        '''
            In this method we are going to find a customized standard deviation for historical liquidity ratio
            So SD of liquidity ratio in near past will have more weight comapred to SD of liquiduty ratio in far past
            It is going to give us a sense of liquidity credibility reliability with respect to time.
        '''
        time_wg_std_dev_list = []
        for items in args:
            #print(items)
            np_format_list = np.array(items)
            #print(np_format_list)
            weight_list = fin_stats.time_weighted_list(items)

            np_format_weight_list = np.array(weight_list)
            #print(type(np_format_list), np_format_list ,'\n' , type(np_format_weight_list), np_format_weight_list)
            weighted_data = DescrStatsW(np_format_list, np_format_weight_list)
            non_wg_sd = DescrStatsW(np_format_list)
            #print('Weighted variance', weighted_data.var)
            std_dev = pow(weighted_data.var, 0.5)
            #print('Weighted standard deviation ',std_dev)
            time_wg_std_dev_list.append(std_dev)
        return time_wg_std_dev_list


    def time_weighted_confidence_level(*args):
        '''
            This method takes in liquidity ratios and calculates confidence level of the ratio
            It takes the mean from time_weighted_mean method and standard deviation from time_weighted_std_dev
            then calculates the confidence level as per z confidence interval
        '''
        max_con_level_list = []
        min_con_level_list = []

        for items in args:
            #print('Items for confidence level',items)
            z_value =  1.96 # z value for 95% confidence interval
            mean = fin_stats.time_weighted_mean(items)[0]
            std_dev =  fin_stats.time_weighted_std_dev(items)[0]
            #print('mean', mean,'std dev', std_dev)
            max_con_level = mean + z_value * (std_dev / pow(len(args),0.5))
            min_con_level = mean - z_value * (std_dev / pow(len(args),0.5))
            #print('Max confidence level is', max_con_level)
            #print('Min confidence level is', min_con_level)
            max_con_level_list.append(float(max_con_level))
            min_con_level_list.append(float(min_con_level))
        #print('Max confidence level is',max_con_level_list)
        #print('Min confidence level is', min_con_level_list)
        return max_con_level_list, min_con_level_list



