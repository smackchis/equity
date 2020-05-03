import statistics
import numpy as np
import statistics
import array as arr
from array import *
from statsmodels.stats.weightstats import DescrStatsW


# time_weighted_list takes a list as input and gives a list of time aggregated weighted value
# Example: if data list contains values [0.7,0.6,0.5] for year1, year2 and year3 resp
# Time weight value list is calculated [((1+ 0.7)^1/1)) - 1, ((1 + 0.6)^1/2) - 1 , ((1 + 0.5)^1/3) -1 ]
def time_weighted_list(my_list):

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

#In this method we are going to find a time weighted mean
def time_weighted_mean(data_list):

    weighted_sum = 0
    weight_list = time_weighted_list(data_list)
    for i in range(0,len(data_list)):
        weighted_sum = weighted_sum + (data_list[i] * weight_list[i])
    return weighted_sum

#In this method we are going to find a time weighted standard deviation
def time_weighted_std_dev(data_list):

    weighted_data = DescrStatsW(np.array(data_list), np.array(time_weighted_list(data_list)))
    wt_std_dev = pow(weighted_data.var, 0.5)
    return wt_std_dev


#This method takes in set of data and calculates confidence level based on time weighted mean and standard dev
def time_weighted_confidence_level(data_list):

    z_value =  1.96 # z value for 95% confidence interval
    mean = time_weighted_mean(data_list)
    std_dev =  time_weighted_std_dev(data_list)
    max_con_level = mean + z_value * (std_dev / pow(len(data_list),0.5))
    min_con_level = mean - z_value * (std_dev / pow(len(data_list),0.5))
    return max_con_level, min_con_level
