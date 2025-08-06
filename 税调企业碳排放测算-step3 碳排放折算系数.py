# -*- coding: utf-8 -*-
"""
Created on Mon May 15 21:17:22 2023

@author: ljh93
"""

import pandas as pd

road = r"C:\Users\ljh93\Desktop\碳排放核算步骤"

ind = pd.read_excel(road+"/行业代码(07-11).xlsx",index_col=0)
c = pd.read_excel(road+"/能源折算系数.xlsx",index_col = 0)
c0 = ['原煤',
 '洗精煤',
 '其他洗煤',
 '型煤',
 '煤矸石',
 '焦炭',
 '其他焦化产品']
c1 = ['原油',
'汽油',
'煤油',
'柴油',
'燃料油',
'石脑油',
'石油焦',
'液化石油气',
'炼厂干气',
'其他石油制品']
infos = pd.DataFrame()
for year in range(2007,2012):
    print(year)
    data = pd.read_excel(road+"/碳排放因子折算.xlsx",index_col=0,sheet_name = str(year))
    for i in data.index:
        if i in ind.index.to_list():
            e0 = 0
            ef0 = 0
            e1 = 0
            ef1 = 0
            for j in c0:
                if j in data.columns:
                    if str(data[j][i]) != "nan":
                        e0 += data[j][i]
            for j in c0:
                if j in data.columns:
                    if str(data[j][i]) != "nan":
                        ef0 += c["折算算系数"][j] * data[j][i] / e0
            for j in c1:
                if j in data.columns:
                    if str(data[j][i]) != "nan":
                        e1 += data[j][i]
            for j in c1:
                if j in data.columns:
                    if str(data[j][i]) != "nan":
                        ef1 += c["折算算系数"][j] * data[j][i] / e1
            info = pd.DataFrame([[year,i,ind["行业代码"][i],ef0,ef1]])
            infos = pd.concat([infos,info])
ind = pd.read_excel(road+"/行业代码(12-16).xlsx",index_col=0)
for year in range(2012,2017):
    print(year)
    data = pd.read_excel(road+"/碳排放因子折算.xlsx",index_col=0,sheet_name = str(year))
    for i in data.index:
        if i in ind.index.to_list():
            e0 = 0
            ef0 = 0
            e1 = 0
            ef1 = 0
            for j in c0:
                if j in data.columns:
                    if str(data[j][i]) != "nan":
                        e0 += data[j][i]
            for j in c0:
                if j in data.columns:
                    if str(data[j][i]) != "nan":
                        ef0 += c["折算算系数"][j] * data[j][i] / e0
            for j in c1:
                if j in data.columns:
                    if str(data[j][i]) != "nan":
                        e1 += data[j][i]
            for j in c1:
                if j in data.columns:
                    if str(data[j][i]) != "nan":
                        ef1 += c["折算算系数"][j] * data[j][i] / e1
            info = pd.DataFrame([[year,i,ind["行业代码"][i],ef0,ef1]])
            infos = pd.concat([infos,info])
infos.columns = ["year","ind","行业代码","煤折算系数","油折算系数"]
infos.to_stata(road+"/energy.dta",version = 119)
        