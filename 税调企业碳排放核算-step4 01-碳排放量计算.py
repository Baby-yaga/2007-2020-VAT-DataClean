# -*- coding: utf-8 -*-
"""
Created on Mon May 15 22:38:26 2023

@author: ljh93
"""

import pandas as pd
def ind_match(x,c,p):
    c.index = c["行业代码"]
    if x in c.index:
        return c[p][x]
    elif x[0] in c.index:
        return c[p][x[0]]
    else:
        return c[p]["其他"]
def re_match(x,c):
    c.index = c["id"]
    if x == 21 or x == 22 or x == 23:
        return c["ef"][1]
    if x == 31 or x == 32 or x == 33 or x == 34 or x == 35 or x == 36 or x == 37:
        return c["ef"][2]
    if 41 or x == 42 or x == 43:
        return c["ef"][3]
    if x == 11 or x == 12 or x == 13 or x == 14 or x == 15:
        return c["ef"][4]
    if x == 44 or x == 45 or x == 50 or x == 51 or x == 52 or x == 53:
        return c["ef"][5]
    if x == 46:
        return c["ef"][6]
    if x == 61 or x == 62 or x == 63 or x == 64 or x == 65:
        return c["ef"][7]
    return 0
    
road = r"E:\企业数据\税调数据(团队数据)\5 税调数据（团队数据-碳排放计算结果）"
r0 = r"E:\企业数据\税调数据(团队数据)\6 税调数据（团队数据-最终结果）"
c1 = pd.read_stata(road+"/electricity.dta")
c2 = pd.read_stata(road+"/energy.dta")
for year in range(2017,2021):
    c1_1 = c1[c1["year"] == 2016]
    c2_1 = c2[c2["year"] == 2016]
    data = pd.read_stata(road+"/税调{}.dta".format(str(year)))
    data["煤折算系数"] = data["ind"].apply(lambda x:ind_match(x,c2_1,"煤折算系数"))
    data["油折算系数"] = data["ind"].apply(lambda x:ind_match(x,c2_1,"油折算系数"))
    data["电折算系数"] = data["re2"].apply(lambda x:re_match(x,c1_1))
    df = data[data["电折算系数"] == 0]
    # if year > 2007 and year <= 2011:
    #     data = data.rename(columns = {"hylb":"industry"})
    if year >= 2014:
        data["co2_分行业"] = data["电力消费量"]*data["电折算系数"]*10+data["煤炭消费量"]*data["煤折算系数"]*1000+data["油消费量"]*data["油折算系数"]*1000+data["天然气消费量"]*1809
        data["co2_cui"] = data["电力消费量"]*data["电折算系数"]*10+data["煤炭消费量"]*1978+data["油消费量"]*3065+data["天然气消费量"]*1809
    else:
        data["co2_分行业"] = data["电力消费量"]*data["电折算系数"]*10+data["煤炭消费量"]*data["煤折算系数"]*1000+data["油消费量"]*data["油折算系数"]*1000
        data["co2_cui"] = data["电力消费量"]*data["电折算系数"]*10+data["煤炭消费量"]*1978+data["油消费量"]*3065

    data.to_stata(r0+"/税调{}.dta".format(str(year)),version = 119)
        
    