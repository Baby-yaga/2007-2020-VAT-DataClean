cd "E:/企业数据/税调数据(团队数据)/"

**逐年匹配税调-专利数据
use "6 税调数据（团队数据-最终结果）/税调2007.dta",clear
*drop n

drop if 煤折算系数 == 0
drop if 电力消费量 == .
winsor2 电力消费量 煤炭消费量 油消费量, cut(1 99) by(year) replace
gen carbon_emission = (电力消费量 * 电折算系数 * 10 + 煤炭消费量 * 煤折算系数 * 1000 + 油消费量 * 油折算系数 * 1000) / 1000

gen yysr = sds_yysr
gen yycb = sds_yycb
gen yysjjfj = sds_yysjjfj
gen xsfy = sds_xsfy
gen glfy = sds_glfy
gen cwfy = sds_cwfy
gen zcjzss = sds_zcjzss
gen tzsy = sds_tzsy
gen yylr = sds_yylr
gen yywsr = sds_yywsr
gen yywzc = sds_yywzc
gen lrze = sds_lrze

if year != 2007 {
	replace yysr = lrb_yysr if yysr == .
	
	gen zysr = sds_zysr
	replace zysr = lrb_zysr if zysr == .
	label variable zysr "主营业务收入"
	
	replace yycb = lrb_yycb if yycb == .
	
	gen zycb = sds_zycb
	replace zycb = lrb_zycb if zycb == .
	label variable zycb "主营业务成本"
	
	replace yysjjfj = lrb_yysjfj if yysjjfj == .
	replace xsfy = lrb_xsfy if xsfy == .
	replace glfy = lrb_glfy if glfy == .
	replace cwfy = lrb_cwfy if cwfy == .
	replace zcjzss = lrb_zcjzss if zcjzss == .
	replace tzsy = lrb_tzsy if tzsy == .
	replace yylr = lrb_yylr if yylr == .
	replace yywsr = lrb_yywsr if yywsr == .
	
	gen btsr = sds_btsr
	replace btsr = lrb_btsr if btsr == .
	label variable btsr "补贴收入"
	
	replace yywzc = lrb_yywzc if yywzc == .
	replace lrze = lrb_lrze if lrze == .
}

label variable yysr "营业收入"
label variable yycb "营业成本"
label variable yysjjfj "营业税金及附加"
label variable xsfy "销售费用"
label variable glfy "管理费用"
label variable cwfy "财务费用"
label variable zcjzss "资产减值损失"
label variable tzsy "投资收益"
label variable yylr "营业利润"
label variable yywsr "营业外收入"
label variable yywzc "营业外支出"
label variable lrze "利润总额"

* yysr zysr yycb zycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr btsr yywzc lrze

keep 统一社会信用代码 qymc year region_code industry_code carbon_emission zcb_mldzc zcb_mgdzc zcb_zcnms zzs_xxse zzs_jxse sds_yjsdse zcb_fznms xjb_xjlr xjb_xjlc lrb_xcpfy yysr yycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr yywzc lrze

reorder 统一社会信用代码 qymc year region_code industry_code carbon_emission zcb_mldzc zcb_mgdzc zcb_zcnms zzs_xxse zzs_jxse sds_yjsdse zcb_fznms xjb_xjlr xjb_xjlc lrb_xcpfy yysr yycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr yywzc lrze

save "E:/企业数据/税调数据(团队数据)/Plus 税调数据+更新20年版本/税调2007-match.dta", replace

forvalues year = 2008(1)2013{
	use "E:/企业数据/税调数据(团队数据)/6 税调数据（团队数据-最终结果）/税调`year'.dta",clear
	gen yysr = sds_yysr
	gen yycb = sds_yycb
	gen yysjjfj = sds_yysjjfj
	gen xsfy = sds_xsfy
	gen glfy = sds_glfy
	gen cwfy = sds_cwfy
	gen zcjzss = sds_zcjzss
	gen tzsy = sds_tzsy
	gen yylr = sds_yylr
	gen yywsr = sds_yywsr
	gen yywzc = sds_yywzc
	gen lrze = sds_lrze

	if year != 2007 {
		replace yysr = lrb_yysr if yysr == .
		if year == 2008 | year == 2009 | year == 2010 | year == 2011 | year == 2012 | year == 2013 {
			gen zysr = lrb_zysr
			label variable zysr "主营业务收入"
			
			gen zycb = lrb_zycb
			label variable zycb "主营业务成本"
			
			gen btsr = lrb_btsr
			label variable btsr "补贴收入"
		}
		if year != 2008 & year != 2009 & year != 2010 & year != 2011 & year != 2012 & year != 2013 {
			gen zysr = sds_zysr
			replace zysr = lrb_zysr if zysr == .
			label variable zysr "主营业务收入"
			
			gen zycb = sds_zycb
			replace zycb = lrb_zycb if zycb == .
			label variable zycb "主营业务成本"
			
			gen btsr = sds_btsr
			replace btsr = lrb_btsr if btsr == .
			label variable btsr "补贴收入"
		}
		
		replace yycb = lrb_yycb if yycb == .
		replace yysjjfj = lrb_yysjfj if yysjjfj == .
		replace xsfy = lrb_xsfy if xsfy == .
		replace glfy = lrb_glfy if glfy == .
		replace cwfy = lrb_cwfy if cwfy == .
		replace zcjzss = lrb_zcjzss if zcjzss == .
		replace tzsy = lrb_tzsy if tzsy == .
		replace yylr = lrb_yylr if yylr == .
		replace yywsr = lrb_yywsr if yywsr == .
		replace yywzc = lrb_yywzc if yywzc == .
		replace lrze = lrb_lrze if lrze == .
	}

	label variable yysr "营业收入"
	label variable yycb "营业成本"
	label variable yysjjfj "营业税金及附加"
	label variable xsfy "销售费用"
	label variable glfy "管理费用"
	label variable cwfy "财务费用"
	label variable zcjzss "资产减值损失"
	label variable tzsy "投资收益"
	label variable yylr "营业利润"
	label variable yywsr "营业外收入"
	label variable yywzc "营业外支出"
	label variable lrze "利润总额"

	drop if 煤折算系数 == 0
	drop if 电力消费量 == .
	winsor2 电力消费量 煤炭消费量 油消费量, cut(1 99) by(year) replace
	gen carbon_emission = (电力消费量 * 电折算系数 * 10 + 煤炭消费量 * 煤折算系数 * 1000 + 油消费量 * 油折算系数 * 1000) / 1000
	
	keep 统一社会信用代码 qymc year region_code industry_code carbon_emission zcb_mldzc zcb_mgdzc zcb_zcnms zzs_xxse zzs_jxse sds_yjsdse zcb_fznms xjb_xjlr xjb_xjlc lrb_xcpfy yysr yycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr yywzc lrze zysr zycb btsr

	reorder 统一社会信用代码 qymc year region_code industry_code carbon_emission zcb_mldzc zcb_mgdzc zcb_zcnms zzs_xxse zzs_jxse sds_yjsdse zcb_fznms xjb_xjlr xjb_xjlc lrb_xcpfy yysr yycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr yywzc lrze zysr zycb btsr

	save "E:/企业数据/税调数据(团队数据)/Plus 税调数据+更新20年版本/税调`year'-match.dta", replace
}

forvalues year = 2014(1)2016{
	use "E:/企业数据/税调数据(团队数据)/6 税调数据（团队数据-最终结果）/税调`year'.dta",clear
	gen yysr = sds_yysr
	gen yycb = sds_yycb
	gen yysjjfj = sds_yysjjfj
	gen xsfy = sds_xsfy
	gen glfy = sds_glfy
	gen cwfy = sds_cwfy
	gen zcjzss = sds_zcjzss
	gen tzsy = sds_tzsy
	gen yylr = sds_yylr
	gen yywsr = sds_yywsr
	gen yywzc = sds_yywzc
	gen lrze = sds_lrze

	if year == 2014 | year == 2015 | year == 2016 {
		gen zysr = lrb_zysr
		label variable zysr "主营业务收入"
		
		gen zycb = lrb_zycb
		label variable zycb "主营业务成本"
		
		gen btsr = lrb_btsr
		label variable btsr "补贴收入"
	}
	if year != 2014 & year != 2015 & year != 2016 {
		gen zysr = sds_zysr
		replace zysr = lrb_zysr if zysr == .
		label variable zysr "主营业务收入"
		
		gen zycb = sds_zycb
		replace zycb = lrb_zycb if zycb == .
		label variable zycb "主营业务成本"
		
		gen btsr = sds_btsr
		replace btsr = lrb_btsr if btsr == .
		label variable btsr "补贴收入"
	}
	replace yysr = lrb_yysr if yysr == .
	replace yycb = lrb_yycb if yycb == .
	replace yysjjfj = lrb_yysjfj if yysjjfj == .
	replace xsfy = lrb_xsfy if xsfy == .
	replace glfy = lrb_glfy if glfy == .
	replace cwfy = lrb_cwfy if cwfy == .
	replace zcjzss = lrb_zcjzss if zcjzss == .
	replace tzsy = lrb_tzsy if tzsy == .
	replace yylr = lrb_yylr if yylr == .
	replace yywsr = lrb_yywsr if yywsr == .
	replace yywzc = lrb_yywzc if yywzc == .
	replace lrze = lrb_lrze if lrze == .

	label variable yysr "营业收入"
	label variable yycb "营业成本"
	label variable yysjjfj "营业税金及附加"
	label variable xsfy "销售费用"
	label variable glfy "管理费用"
	label variable cwfy "财务费用"
	label variable zcjzss "资产减值损失"
	label variable tzsy "投资收益"
	label variable yylr "营业利润"
	label variable yywsr "营业外收入"
	label variable yywzc "营业外支出"
	label variable lrze "利润总额"
	
	drop if 煤折算系数 == 0
	drop if 电力消费量 == .
	winsor2 电力消费量 煤炭消费量 油消费量 天然气消费量 其他气体燃料消费量, cut(1 99) by(year) replace
	gen carbon_emission = (电力消费量 * 电折算系数 * 10 + 煤炭消费量 * 煤折算系数 * 1000 + 油消费量 * 油折算系数 * 1000) / 1000

	replace carbon_emission = (电力消费量 * 电折算系数 * 10 + 煤炭消费量 * 煤折算系数 * 1000 + 油消费量 * 油折算系数 * 1000 + 天然气消费量 * 18090 + 其他气体燃料消费量 * 18090) / 1000 if year >= 2014 & year != 2015

	replace carbon_emission = (电力消费量 * 电折算系数 * 10 + 煤炭消费量 * 煤折算系数 * 1000 + 油消费量 * 油折算系数 * 1000 + 天然气消费量 * 1.809 + 其他气体燃料消费量 * 18090) / 1000 if year == 2015
	
	keep 统一社会信用代码 qymc year region_code industry_code carbon_emission zcb_mldzc zcb_mgdzc zcb_zcnms zzs_xxse zzs_jxse sds_yjsdse zcb_fznms xjb_xjlr xjb_xjlc lrb_xcpfy yysr yycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr yywzc lrze zysr zycb btsr

	reorder 统一社会信用代码 qymc year region_code industry_code carbon_emission zcb_mldzc zcb_mgdzc zcb_zcnms zzs_xxse zzs_jxse sds_yjsdse zcb_fznms xjb_xjlr xjb_xjlc lrb_xcpfy yysr yycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr yywzc lrze zysr zycb btsr
	
	save "E:/企业数据/税调数据(团队数据)/Plus 税调数据+更新20年版本/税调`year'-match.dta", replace
}

forvalues year = 2017(1)2020{
	use "E:/企业数据/税调数据(团队数据)/6 税调数据（团队数据-最终结果）/税调`year'.dta",clear

	gen btsr = lrb_btsr
	label variable btsr "补贴收入"

	label variable yysr "营业收入"
	label variable yycb "营业成本"
	label variable yysjjfj "营业税金及附加"
	label variable xsfy "销售费用"
	label variable glfy "管理费用"
	label variable cwfy "财务费用"
	label variable zcjzss "资产减值损失"
	label variable tzsy "投资收益"
	label variable yylr "营业利润"
	label variable yywsr "营业外收入"
	label variable yywzc "营业外支出"
	label variable lrze "利润总额"
	
	drop if 煤折算系数 == 0
	drop if 电力消费量 == .
	winsor2 电力消费量 煤炭消费量 油消费量 天然气消费量 , cut(1 99) by(year) replace
	gen carbon_emission = (电力消费量 * 电折算系数 * 10 + 煤炭消费量 * 煤折算系数 * 1000 + 油消费量 * 油折算系数 * 1000) / 1000

	replace carbon_emission = (电力消费量 * 电折算系数 * 10 + 煤炭消费量 * 煤折算系数 * 1000 + 油消费量 * 油折算系数 * 1000 + 天然气消费量 * 18090) / 1000

	keep 统一社会信用代码 qymc year region_code industry_code carbon_emission zcb_mldzc zcb_mgdzc zcb_zcnms zzs_xxse zzs_jxse zcb_fznms xjb_xjlr xjb_xjlc lrb_xcpfy yysr yycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr yywzc lrze zysr zycb btsr

	reorder 统一社会信用代码 qymc year region_code industry_code carbon_emission zcb_mldzc zcb_mgdzc zcb_zcnms zzs_xxse zzs_jxse zcb_fznms xjb_xjlr xjb_xjlc lrb_xcpfy yysr yycb yysjjfj xsfy glfy cwfy zcjzss tzsy yylr yywsr yywzc lrze zysr zycb btsr
	
	save "E:/企业数据/税调数据(团队数据)/Plus 税调数据+更新20年版本/税调`year'-match.dta", replace
}

**合并 2007～2020 年的税调-专利数据
use "E:/企业数据/税调数据(团队数据)/Plus 税调数据+更新20年版本/税调2007-match.dta", clear 
forvalues year = 2008(1)2020 {
	append using "E:/企业数据/税调数据(团队数据)/Plus 税调数据+更新20年版本/税调`year'-match.dta", force
}

label variable qymc "企业名称"
label variable region_code "行政区划代码"
label variable industry_code "行业代码"
label variable carbon_emission "二氧化碳排放量"
label variable zcb_mldzc "流动资产年末数"
label variable zcb_mgdzc "固定资产年末数"
label variable zcb_zcnms "总资产年末数"
label variable zzs_xxse "销项税额"
label variable zzs_jxse "进项税额"
label variable sds_yjsdse "应缴所得税"
label variable zcb_fznms "负债年末数"
label variable xjb_xjlr "现金流入"
label variable xjb_xjlc "现金流出"
label variable lrb_xcpfy "新产品研发费用"

save "E:/企业数据/税调数据(团队数据)/Plus 税调数据+更新20年版本/2007-2020面板数据.dta",replace
//得到2007-2020面板数据