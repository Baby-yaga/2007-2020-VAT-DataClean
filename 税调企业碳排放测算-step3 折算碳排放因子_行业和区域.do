* 识别企业所属行业和地区
forvalues i = 2007(1)2007{
	use "E:\企业数据\税调数据(团队数据)\4 税调数据（含工商连接信息）\税调`i'新.dta", clear
	dis `i'
	if `i' == 2007 {
		ren industry industry_code
		ren region re2
	}
	if `i' == 2008|`i' == 2009|`i' == 2010|`i' == 2011 {
		ren hylb industry_code
		rename dqdm region
		gen re2 = substr(region,1,2)
		destring re2, replace force
	}
	if `i' == 2012|`i' == 2013|`i' == 2014|`i' == 2015|`i' == 2016 {
	    ren industry industry_code
		rename 区划代码 region
		tostring region, replace force
		gen re2 = substr(region,1,2)
		destring re2, replace force
	}
	gen region_code = substr(统一社会信用代码,3,6)
	* do "E:\企业数据\税调数据(团队数据)\匹配程序—20231007\2011版统一为2002版stata代码do文件.do"
	gen ind = substr(industry_code,1,3)
	drop if ind == ""
	replace 电力消费量 = 0 if 电力消费量 == . | 电力消费量 < 0
	replace 煤炭消费量 = 0 if 煤炭消费量 == . | 煤炭消费量 < 0
	replace 油消费量 = 0 if 油消费量 == . | 油消费量 < 0
	if `i' >= 2014{
		replace 天然气消费量 = 0 if 天然气消费量 == . | 天然气消费量 < 0
		replace 其他气体燃料消费量 = 0 if 其他气体燃料消费量 == . | 其他气体燃料消费量 < 0
	}
	save "E:\企业数据\税调数据(团队数据)\5 税调数据（团队数据-碳排放计算结果）\税调`i'.dta",replace
}

forvalues i = 2017(1)2020{
	use "E:\企业数据\税调数据(团队数据)\4 税调数据（含工商连接信息）\税调`i'新.dta", clear
	dis `i'

	ren industry industry_code
	rename 区划代码 region
	tostring region, replace force
	gen re2 = substr(region,1,2)
	destring re2, replace force
		
	gen region_code = substr(统一社会信用代码,3,6)
	* do "E:\企业数据\税调数据(团队数据)\匹配程序—20231007\2011版统一为2002版stata代码do文件.do"
	gen ind = substr(industry_code,1,3)
	drop if ind == ""
	replace 电力消费量 = 0 if 电力消费量 == . | 电力消费量 < 0
	replace 煤炭消费量 = 0 if 煤炭消费量 == . | 煤炭消费量 < 0
	replace 油消费量 = 0 if 油消费量 == . | 油消费量 < 0
	if `i' >= 2014{
		replace 天然气消费量 = 0 if 天然气消费量 == . | 天然气消费量 < 0
	}
	save "E:\企业数据\税调数据(团队数据)\5 税调数据（团队数据-碳排放计算结果）\税调`i'.dta",replace
}
