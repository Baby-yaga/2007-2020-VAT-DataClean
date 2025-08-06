# -*- coding: utf-8 -*-
"""
Created on Tue Jul  2 21:01:13 2024

@author: ljh93
"""
import pandas as pd
import re
def name_clean(id_name):
    # Full Name
    # 剔除字符串中 除汉字 英文 阿拉伯数字 括号以外的字符
    full_id_name = ""
    for chr0 in id_name:
        if len(re.findall(r'[\u4e00-\u9fff]+',chr0)) != 0:
            full_id_name = full_id_name + chr0
        elif len(re.findall(r'[a-zA-Z]+',chr0)) != 0:
            full_id_name = full_id_name + str.lower(chr0)
        elif len(re.findall(r'[0-9]+',chr0)) != 0:
            if chr0 == "0":
                full_id_name = full_id_name + "零"
            if chr0 == "1":
                full_id_name = full_id_name + "一"
            if chr0 == "2":
                full_id_name = full_id_name + "二"
            if chr0 == "3":
                full_id_name = full_id_name + "三"
            if chr0 == "4":
                full_id_name = full_id_name + "四"
            if chr0 == "5":
                full_id_name = full_id_name + "五"
            if chr0 == "6":
                full_id_name = full_id_name + "六"
            if chr0 == "7":
                full_id_name = full_id_name + "七"
            if chr0 == "8":
                full_id_name = full_id_name + "八"
            if chr0 == "9":
                full_id_name = full_id_name + "九"
        elif chr0 == "（" or chr0 == "(":
            full_id_name = full_id_name + "("
        elif chr0 == "）" or chr0 == ")":
            full_id_name = full_id_name + ")"
    # Small Name
    small_id_name = full_id_name.replace("有限","")
    small_id_name = small_id_name.replace("责任","")
    small_id_name = small_id_name.replace("股份","")
    small_id_name = small_id_name.replace("集团","")
    small_id_name = small_id_name.replace("公司","")
    small_id_name = small_id_name.replace("厂","")
    small_id_name = small_id_name.replace("省","")
    small_id_name = small_id_name.replace("市","")
    small_id_name = small_id_name.replace("区","")
    small_id_name = small_id_name.replace("县","")
    small_id_name = small_id_name.replace("回族自治区","")
    small_id_name = small_id_name.replace("壮族自治区","")
    small_id_name = small_id_name.replace("维吾尔自治区","")
    small_id_name = small_id_name.replace("自治区","")
    small_id_name = small_id_name.replace("(","")
    small_id_name = small_id_name.replace(")","")
    # Key Name
    key_id_name = str.split(full_id_name, sep = "公司")[0] ## 以公司为分界进行截断
    key_id_name = key_id_name.replace("有限","")
    key_id_name = key_id_name.replace("责任","")
    key_id_name = key_id_name.replace("股份","")
    key_id_name = key_id_name.replace("集团","")
    key_id_name = key_id_name.replace("总公司","")
    key_id_name = key_id_name.replace("分公司","")
    key_id_name = key_id_name.replace("公司","")
    key_id_name = key_id_name.replace("总院","")
    key_id_name = key_id_name.replace("分院","")
    key_id_name = key_id_name.replace("总部","")
    key_id_name = key_id_name.replace("分部","")
    key_id_name = key_id_name.replace("总厂","")
    key_id_name = key_id_name.replace("厂","")
    key_id_name = key_id_name.replace("省","")
    key_id_name = key_id_name.replace("市","")
    key_id_name = key_id_name.replace("区","")
    key_id_name = key_id_name.replace("县","")
    key_id_name = key_id_name.replace("回族自治区","")
    key_id_name = key_id_name.replace("壮族自治区","")
    key_id_name = key_id_name.replace("维吾尔自治区","")
    key_id_name = key_id_name.replace("自治区","")
    key_id_name = key_id_name.replace("(","")
    key_id_name = key_id_name.replace(")","")
    return [full_id_name,small_id_name,key_id_name]


# cols = ['申请人','申请号','申请日']
green_pat = pd.read_csv("E:/绿色专利（incopat）/incopat绿色专利汇总数据-v20231117.csv", sep = "|")
green_pat["year"] = green_pat["申请日"].apply(lambda x:eval(x[0:4]))
green_pat.index = range(len(green_pat))
print("Done.")

# 
for year in range(2007,2017):
    print(year)
    data_normal_ = green_pat[green_pat["year"] == year]
    data_normal_.index = range(len(data_normal_))
    print("Done.")
    
    data_normal = data_normal_[data_normal_["year"] == year]
    data_normal.index = range(len(data_normal))
    data_normal["申请人-saved"] = data_normal["申请人"]
    data_normal = data_normal.drop('申请人', axis=1).join(data_normal['申请人'].str.split(';', expand=True).stack().reset_index(level=1, drop=True).rename('id_name'))
    data_normal.index = range(len(data_normal))
    print("Done.")
    ###
    data_normal["id_name_list"] = data_normal["id_name"].apply(lambda x:name_clean(x))
    data_normal["fullname"] = data_normal["id_name_list"].apply(lambda x:x[0])
    data_normal["smallname"] = data_normal["id_name_list"].apply(lambda x:x[1])
    data_normal["nickname"] = data_normal["id_name_list"].apply(lambda x:x[2])
    data_normal = data_normal.drop(["id_name_list"],axis = 1)
    print("Done.")
    #
    df_merged = pd.DataFrame()
    output_road = "E:/企业数据/税调数据(团队数据)/8 税调企业+cleaned/"
    data = pd.read_stata(output_road + "/税调{}-cleaned.dta".format(str(year)))
    data = data[['统一社会信用代码','企业工商注册名称']]
    print(len(data),end = " ")
    data = data[data["企业工商注册名称"] != ""]
    print(len(data))
    data["id_name_list"] = data["企业工商注册名称"].apply(lambda x:name_clean(x))
    data["fullname"] = data["id_name_list"].apply(lambda x:x[0])
    data["smallname"] = data["id_name_list"].apply(lambda x:x[1])
    data["nickname"] = data["id_name_list"].apply(lambda x:x[2])
    print("Done.")
    #
    data_ = data.drop(["id_name_list","smallname","nickname"],axis = 1)
    df = pd.merge(data_, data_normal, how = "right", on = ["fullname"])
    df_ = df[~df["统一社会信用代码"].isna()]
    df_.index = range(len(df_))
    df_ = df_.drop(["fullname","smallname","nickname"],axis = 1)
    df_merged = pd.concat([df_merged,df_])
    print("Done.")
    #
    data_ = data.drop(["id_name_list","fullname","nickname"],axis = 1)
    df = pd.merge(data_, data_normal, how = "right", on = ["smallname"])
    df_ = df[~df["统一社会信用代码"].isna()]
    df_.index = range(len(df_))
    df_ = df_.drop(["fullname","smallname","nickname"],axis = 1)
    df_merged = pd.concat([df_merged,df_])
    print("Done.")

    #
    df_merged = df_merged.drop(["id_name"],axis = 1)
    df_merged = df_merged.drop_duplicates(keep='first', inplace=False, ignore_index=False)
    df_merged.to_csv("E:/企业数据/税调数据(团队数据)/Plus 税调数据+绿色创新/green-matched-{}.csv".format(str(year)),index = 0,sep = "|")
    print("Done.")
df_merged = pd.DataFrame()
for year in range(2007,2017):
    print(year)
    data = pd.read_csv("E:/企业数据/税调数据(团队数据)/Plus 税调数据+绿色创新/green-matched-{}.csv".format(str(year)),sep = "|")
    df_merged = pd.concat([df_merged,data])
df_merged.to_csv("E:/企业数据/税调数据(团队数据)/Plus 税调数据+绿色创新/green-matched.csv",index = 0,sep = "|")
