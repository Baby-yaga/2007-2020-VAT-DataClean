# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 23:28:49 2023

@author: ljh93
"""
import pandas as pd
import requests
from tqdm import tqdm
import math
import os
import time
tqdm.pandas(desc='pandas bar')

## 转换函数
x_pi = 3.14159265358979324 * 3000.0 / 180.0
pi = 3.1415926535897932384626  # π
a = 6378245.0  # 长半轴
ee = 0.00669342162296594323  # 扁率

def gcj02towgs84(lng, lat):
    """
    GCJ02(火星坐标系)转GPS84
    :param lng:火星坐标系的经度
    :param lat:火星坐标系纬度
    :return:
    """
    if lng == "-" and lat == "-":
        return ["-", "-"]
    else:
        lng = eval(lng)
        lat = eval(lat)
    if out_of_china(lng, lat):
        return [lng, lat]
    dlat = transformlat(lng - 105.0, lat - 35.0)
    dlng = transformlng(lng - 105.0, lat - 35.0)
    radlat = lat / 180.0 * pi
    magic = math.sin(radlat)
    magic = 1 - ee * magic * magic
    sqrtmagic = math.sqrt(magic)
    dlat = (dlat * 180.0) / ((a * (1 - ee)) / (magic * sqrtmagic) * pi)
    dlng = (dlng * 180.0) / (a / sqrtmagic * math.cos(radlat) * pi)
    mglat = lat + dlat
    mglng = lng + dlng
    return [lng * 2 - mglng, lat * 2 - mglat]

def transformlat(lng, lat):
    ret = -100.0 + 2.0 * lng + 3.0 * lat + 0.2 * lat * lat + \
        0.1 * lng * lat + 0.2 * math.sqrt(math.fabs(lng))
    ret += (20.0 * math.sin(6.0 * lng * pi) + 20.0 *
            math.sin(2.0 * lng * pi)) * 2.0 / 3.0
    ret += (20.0 * math.sin(lat * pi) + 40.0 *
            math.sin(lat / 3.0 * pi)) * 2.0 / 3.0
    ret += (160.0 * math.sin(lat / 12.0 * pi) + 320 *
            math.sin(lat * pi / 30.0)) * 2.0 / 3.0
    return ret

def transformlng(lng, lat):
    ret = 300.0 + lng + 2.0 * lat + 0.1 * lng * lng + \
        0.1 * lng * lat + 0.1 * math.sqrt(math.fabs(lng))
    ret += (20.0 * math.sin(6.0 * lng * pi) + 20.0 *
            math.sin(2.0 * lng * pi)) * 2.0 / 3.0
    ret += (20.0 * math.sin(lng * pi) + 40.0 *
            math.sin(lng / 3.0 * pi)) * 2.0 / 3.0
    ret += (150.0 * math.sin(lng / 12.0 * pi) + 300.0 *
            math.sin(lng / 30.0 * pi)) * 2.0 / 3.0
    return ret

def out_of_china(lng, lat):
    """
    判断是否在国内，不在国内不做偏移
    :param lng:
    :param lat:
    :return:
    """
    if lng < 72.004 or lng > 137.8347:
        return True
    if lat < 0.8293 or lat > 55.8271:
        return True
    return False


def find_loc(x,city_x):
    # time.sleep(0.05)
    key = "a0068637cfd2ac500c66fb0c3f8a691b" # key1 200万额度 (1 4 5 10 11 12)
    # key = "d024ac887013921526afd95b8be25f5a" # key2 50万额度 (6 8)
    # key = "14e40e5745f69e9240a40f6e47a4d461" # key3 50万额度 (2 3 7 9)
    url = "https://restapi.amap.com/v3/geocode/geo?parameters"
    params = {"key":key,
              "address":x,
              "city":city_x}
    # infos = requests.get(url,params).json()
    try:
        infos = requests.get(url,params,timeout = 10).json()  
    except:
        time.sleep(5)
        print("----Re Try-----")
        try:
            infos = requests.get(url,params,timeout = 10).json()
        except:
            time.sleep(5)
            print("----Re Try-----")
            try:
                infos = requests.get(url,params,timeout = 10).json()
            except:
                time.sleep(5)
                print("----Re Try-----")
                params = {"key":key,
                          "address":x}
                try:
                    infos = requests.get(url,params,timeout = 10).json()
                except:
                    time.sleep(5)
                    print("----Re Try-----")
                    infos = requests.get(url,params,timeout = 10).json()
    
    try:
        if infos["status"] == "1":
            if infos["geocodes"][0]["location"] != []:
                return [infos["geocodes"][0]['province'],infos["geocodes"][0]['city'],infos["geocodes"][0]['district'],infos["geocodes"][0]['location']]
            else:
                return ["-","-","-","-,-"]
        else:
            return ["-","-","-","-,-"]
    except:
        return ["-","-","-","-,-"]
road = r"E:\企业数据\税调数据(团队数据)\Plus 税调数据+更新20年版本\地址解析"
max_num = 147
for num_ in range(9,10):
    num = str(num_)
    data = pd.read_stata(road+"/税调企业-个体信息-Plus-part{}.dta".format(num))
    
    data["geo_info"] = data.progress_apply(lambda x:find_loc(x["注册地址_工商"], x["city_工商"]), axis = 1)
    data[['province', 'city', 'district', 'location']] = data['geo_info'].apply(pd.Series)
    data["location_84"] = data.progress_apply(lambda x:gcj02towgs84(str.split(x["location"],sep = ",")[0], str.split(x["location"],sep = ",")[1]), axis = 1)
    data[["lon84","lat84"]] = data["location_84"].apply(pd.Series)
    data["lon84"] = data["lon84"].progress_apply(lambda x:str(x))
    data["lat84"] = data["lat84"].progress_apply(lambda x:str(x))
    
    data = data[['统一社会信用代码', '企业工商注册名称', '所属行业_工商', '成立时间_工商', '地区代码_工商', '注册地址_工商',
                 '城市代码_工商', 'city_工商', 'province', 'city', 'district','lon84', 'lat84']]
    data.to_csv(road+"/税调企业-个体信息-Plus-{}(地址信息解析).csv".format(num), index = 0, sep = "|")
    print("Done.")
