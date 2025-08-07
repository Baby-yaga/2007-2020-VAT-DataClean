use "E:/企业数据/2016-2020税调数据/16-20年税调数据.dta", clear
drop if year == 2016

keep year firmid firmname 所在地行政区划代码 行业代码 增值税_一般税率_销售额 增值税_简易办法_销售额 增值税_免税_销售额 增值税_即征即退_销售额 增值税_总销项税额 增值税_销项税额_百分之十七 增值税_销项税额_百分之十三 增值税_总进项税额 增值税_进项税额_百分之十七 增值税_进项税额_百分之十三 增值税_进项税额_百分之十三_农产品 增值税_期初留抵 增值税_应抵扣税额 增值税_期末留抵税额抵顶欠税 增值税_实际抵扣税额 增值税_应纳税额_简易办法 增值税_应纳税额_减征额 增值税_应纳税额_合计 增值税_年初未交 增值税_本年已纳 增值税_年末未交 增值税_查补抵顶留抵 增值税_留抵进项税 本年已纳资源税 本年已纳城市维护建设税 本年已纳个人所得税 本年已纳印花税 本年已纳烟叶税 本年已纳车辆购置税 本年已纳各种行政事业性收费、政府性基金 本年已纳各类社会保障性基金 本年已纳其他收费 本年已纳各种税费滞纳金及罚款 营业收入 主营业务收入 其他业务收入 营业成本 主营业务成本 其他业务成本 营业税金及附加 销售费用 管理费用 研发费用 财务费用 资产减值损失 投资收益 营业利润 营业外收入 补贴收入 营业外支出 公益救济性捐赠 利润总额 所得税费用 净利润 可供分配利润 可供股东分配利润 未分配利润 年初总资产数 年初流动资产数 年初货币资金数 年初应收账款净额 年初存货数 年初非流动资产数 年初固定资产数 年末总资产数 年末流动资产数 年末货币资金数 年末应收账款数 年末存货数 年末非流动资产数 年末固定资产数 年末固定资产原值 年末固定资产累计折旧 年末固定资产净值 年初负债数 年初流动负债数 年初应付账款数 年初非流动负债数 年初长期借款数 年末负债数 年末流动负债数 年末应付账款数 年末非流动负债数 年末长期借款数 年初所有者权益数 年末所有者权益数 年末实收资本 年末资本公积 经营现金流入 销售现金流入 受到税收返还 经营现金流出 购买现金支出 支付员工薪水 支付税费 经营现金流净额 投资现金净额 筹资现金净额 汇率对现金影响 现金净增加额 外购设备 融资租赁设备 外购不动产 融资租赁不动产 本年增加固定资产 本年增加生产固定资产 本年增加生产建筑 本年增加生产进口设备 年末生产固定资产净值 年末生产建筑净值 年末生产进口设备净值 本年在建工程购入 本年计提折旧 本年设备折旧 本年房屋折旧 本年外购加工费 本年外购修理费 本年外购货运费 本年外购研发费 本年外购信息费 本年外购文创费 本年广告费 本年外购职工培训费 利息总支出 计提工资 年初职工数 年末职工数 企业总产值 企业增加值 煤炭消费量 油消费量 天然气消费量 电力消费量 水消费量

ren firmid id
ren firmname qymc
ren 所在地行政区划代码 区划代码
ren 行业代码 industry
ren 增值税_一般税率_销售额 zzs_xse
ren 增值税_简易办法_销售额 zzs_jyxse
ren 增值税_免税_销售额 zzs_mzxse
ren 增值税_即征即退_销售额 zzs_jzjtxse
ren 增值税_总销项税额 zzs_xxse
ren 增值税_销项税额_百分之十七 zzs_xxse17
ren 增值税_销项税额_百分之十三 zzs_xxse13
ren 增值税_总进项税额 zzs_jxse
ren 增值税_进项税额_百分之十七 zzs_jxse17
ren 增值税_进项税额_百分之十三 zzs_jxse13
ren 增值税_进项税额_百分之十三_农产品 zzs_jxse13ncpdk
ren 增值税_期初留抵 zzs_qcld
ren 增值税_应抵扣税额 zzs_ydkhj
ren 增值税_期末留抵税额抵顶欠税 zzs_qmlddqse
ren 增值税_实际抵扣税额 zzs_sjdk
ren 增值税_应纳税额_简易办法 zzs_jyyns
ren 增值税_应纳税额_减征额 zzs_mzyns
ren 增值税_应纳税额_合计 zzs_yns
ren 增值税_年初未交 zzs_ncwj
ren 增值税_本年已纳 zzs_yn
ren 增值税_年末未交 zzs_nmwj
ren 增值税_查补抵顶留抵 zzs_cbdldse
ren 增值税_留抵进项税 zzs_ldjxse
ren 本年已纳资源税 dfs_ynzys
ren 本年已纳城市维护建设税 dfs_yncsjss
ren 本年已纳个人所得税 dfs_yngrsds
ren 本年已纳印花税 dfs_ynyhs
ren 本年已纳烟叶税 dfs_ynyys
ren 本年已纳车辆购置税 dfs_ynclgzs
ren 本年已纳各种行政事业性收费、政府性基金 dfs_yjxzsf
ren 本年已纳各类社会保障性基金 dfs_ynshbx
ren 本年已纳其他收费 dfs_ynqt
ren 本年已纳各种税费滞纳金及罚款 dfs_ynfk
ren 营业收入 yysr // sds_yysr lrb_yysr 合并
ren 主营业务收入 zysr // sds_zysr lrb_zysr 合并
ren 其他业务收入 lrb_qtsr
ren 营业成本 yycb // sds_yycb lrb_yycb 合并
ren 主营业务成本 zycb // sds_zycb lrb_zycb 合并
ren 其他业务成本 lrb_qtcb
ren 营业税金及附加 yysjjfj // sds_yysjjfj lrb_yysjfj 合并
ren 销售费用 xsfy // sds_xsfy lrb_xsfy 合并
ren 管理费用 glfy // sds_glfy lrb_glfy 合并
ren 研发费用 lrb_xcpfy
ren 财务费用 cwfy // sds_cwfy lrb_cwfy 合并
ren 资产减值损失 zcjzss // sds_zcjzss lrb_zcjzss 合并
ren 投资收益 tzsy // sds_tzsy lrb_tzsy 合并
ren 营业利润 yylr // sds_yylr lrb_yylr 合并
ren 营业外收入 yywsr // sds_yywsr lrb_yywsr 合并
ren 补贴收入 lrb_btsr
ren 营业外支出 yywzc // sds_yywzc lrb_yywzc 合并
ren 公益救济性捐赠 lrb_gyjzzc
ren 利润总额 lrze // sds_lrze lrb_lrze 合并
ren 所得税费用 lrb_sdsfy
ren 净利润 lrb_jlr
ren 可供分配利润 lrb_kfplr
ren 可供股东分配利润 lrb_gdfplr
ren 未分配利润 lrb_wfplr
ren 年初总资产数 zcb_zcncs
ren 年初流动资产数 zcb_cldzc
ren 年初货币资金数 zcb_chbzj
ren 年初应收账款净额 zcb_cyszk
ren 年初存货数 zcb_cch
ren 年初非流动资产数 zcb_cfldzc
ren 年初固定资产数 zcb_cgdzc
ren 年末总资产数 zcb_zcnms
ren 年末流动资产数 zcb_mldzc
ren 年末货币资金数 zcb_mhbzj
ren 年末应收账款数 zcb_myszk
ren 年末存货数 zcb_mch
ren 年末非流动资产数 zcb_mfldzc
ren 年末固定资产数 zcb_mgdzc
ren 年末固定资产原值 zcb_mgdzcyz
ren 年末固定资产累计折旧 zcb_mljzj
ren 年末固定资产净值 zcb_mgdzcjz
ren 年初负债数 zcb_fzncs
ren 年初流动负债数 zcb_cldfz
ren 年初应付账款数 zcb_cyfzk
ren 年初非流动负债数 zcb_cfldfz
ren 年初长期借款数 zcb_ccqjk
ren 年末负债数 zcb_fznms
ren 年末流动负债数 zcb_mldfz
ren 年末应付账款数 zcb_myfzk
ren 年末非流动负债数 zcb_mfldfz
ren 年末长期借款数 zcb_mcqjk
ren 年初所有者权益数 zcb_qyncs
ren 年末所有者权益数 zcb_qynms
ren 年末实收资本 zcb_sszbnms
ren 年末资本公积 zcb_zbgjnms
ren 经营现金流入 xjb_xjlr
ren 销售现金流入 xjb_xsxj
ren 受到税收返还 xjb_sffh
ren 经营现金流出 xjb_xjlc
ren 购买现金支出 xjb_gmsp
ren 支付员工薪水 xjb_zfzg
ren 支付税费 xjb_zfgzsf
ren 经营现金流净额 xjb_jyxj
ren 投资现金净额 xjb_tzxj
ren 筹资现金净额 xjb_czxj
ren 汇率对现金影响 xjb_hlbd
ren 现金净增加额 xjb_xjzje
ren 外购设备 qt_wgsb
ren 融资租赁设备 qt_rzzlsb
ren 外购不动产 qt_wgbdc
ren 融资租赁不动产 qt_rzzlbdc
ren 本年增加固定资产 qt_zjgdzc
ren 本年增加生产固定资产 qt_zjjygdzc
ren 本年增加生产建筑 qt_zjjyfw
ren 本年增加生产进口设备 qt_zjjksb
ren 年末生产固定资产净值 qt_nmjygdzcjz
ren 年末生产建筑净值 qt_jyfwjz
ren 年末生产进口设备净值 qt_jyjksbjz
ren 本年在建工程购入 qt_grsblw
ren 本年计提折旧 qt_jtzj
ren 本年设备折旧 qt_sbjtzj
ren 本年房屋折旧 qt_fwjtzj
ren 本年外购加工费 qt_wgjgf
ren 本年外购修理费 qt_wgxlf
ren 本年外购货运费 qt_wgysf
ren 本年外购研发费 qt_wgyff
ren 本年外购信息费 qt_wgxxfw
ren 本年外购文创费 qt_wgwhcy
ren 本年广告费 qt_ggzc
ren 本年外购职工培训费 qt_wgzgpxf
ren 利息总支出 qt_lxzzc
ren 计提工资 qt_jtgzjj
ren 年初职工数 qt_nczgs
ren 年末职工数 qt_nmzgs
ren 企业总产值 qt_zcz
ren 企业增加值 qt_zjz
ren 水消费量 qt_sxfl

save "E:/企业数据/税调数据(团队数据)/1 原始数据_税收调查数据2007-2016（统一变量名称）/税调2017-2020新.dta" ,replace