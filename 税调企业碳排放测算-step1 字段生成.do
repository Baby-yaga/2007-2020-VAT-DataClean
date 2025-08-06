forvalues year = 2007(1)2016{
	use "E:\企业数据\税调数据(团队数据)\2 剔除关键核算变量缺失_税收调查数据\税调`year'新.dta",clear
	drop if id == ""
	gen l = length(id)
	tab l 
	drop if l!=15 & l!=18
	gen qyid = id
	replace qyid = substr(id,3,15) if l == 18
	replace qyid = substr(qyid,1,2) + substr(qyid,7,9)
	duplicates drop qyid,force
	keep year qymc qyid
	save "E:\企业数据\税调数据(团队数据)\3 税调_dta（生成qyid）\税调`year'新.dta",replace
}

forvalues year = 2017(1)2020{
	use "E:\企业数据\税调数据(团队数据)\2 剔除关键核算变量缺失_税收调查数据\税调2017-2020新.dta",clear
	drop if id == ""
	keep if year == `year'
	gen l = length(id)
	tab l 
	drop if l!=15 & l!=18
	gen qyid = id
	replace qyid = substr(id,3,15) if l == 18
	replace qyid = substr(qyid,1,2) + substr(qyid,7,9)
	duplicates drop qyid,force
	keep year qymc qyid
	save "E:\企业数据\税调数据(团队数据)\3 税调_dta（生成qyid）\税调`year'新.dta",replace
}


forvalues year = 2007(1)2016{
	use "E:\企业数据\税调数据(团队数据)\2 剔除关键核算变量缺失_税收调查数据\税调`year'新.dta",clear
	unique id
	use "E:\企业数据\税调数据(团队数据)\3 税调_dta（生成qyid）\税调`year'新.dta",clear
	unique qyid
}
