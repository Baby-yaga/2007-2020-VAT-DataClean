library(tidyverse)
library(terra)
library(sf)
library(foreign)
library(haven)
# 导入数据
for (i in 1:200){
  file <- paste("E:/企业数据/税调数据(团队数据)/6 税调数据（团队数据-最终结果）/Temp-v2/税调企业-个体信息",as.character(i),"(地址信息解析).dta",sep = "")
  read_dta(file) %>%
    select(统一社会信用代码 , contains("度")) %>%
    st_as_sf(coords = c("经度", "纬度"), crs = 4326) -> df
  distance <- c(1,2,3,4,5)
  infos <- data.frame()
  for (dis in distance){
    # 生成dis km的圆心
    df %>% 
      st_buffer(dist = units::set_units(dis, km)) -> df_km
    for (year in 2007:2016){
      print(paste(as.character(i),as.character(dis),as.character(year),sep = " "))
      file <- paste("E:/地理数据/栅格数据/2000年～2019年中国各省市区县CO2排放量/",as.character(year),".tif",sep="")
      rast(file) -> rst
      terra::extract(rst, vect(df_km), fun = "sum", na.rm = T, exact = T) %>% 
        as_tibble() -> co2
      df$year <- year
      df$dis <- dis
      df$co2 <- co2$sum
      infos <- rbind(infos,df)
    }
  }
  infos %>%
    st_drop_geometry() -> infos
  file0 <- paste("E:/企业数据/税调数据(团队数据)/6 税调数据（团队数据-最终结果）/Temp-CO2/税调企业地址-",as.character(i),".dta",sep="")
  write.dta(infos,file0)
}
