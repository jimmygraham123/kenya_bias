**********************************************************************************
****************************** Randomization checks ******************************
**********************************************************************************




*** Gender, full

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe  ///
	judge_maj_fem ///
	i.appl_maj_fem ///
	i.resp_maj_fem, ///
	absorb(court_year) cluster(judges) 	
quietly estadd local fixede "No", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe ///
	judge_maj_fem ///
	i.appl_maj_fem ///
	i.resp_maj_fem ///
	$controls_ethn ,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	$controls_ethn ///	
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_gender_full.tex, replace label eqlabels(none) se  ///
	title(Gender randomization checks)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"female judges than male judges. Standard errors, in parentheses, are clustered at the judge level."  ///
	"All columns are based on a linear regression model. For specification details, see equation 1."  ///
	"Ethnicity dummies include binary variables indicating whether a given ethnicity is the plurality," ///
	"one for each ethnicity, for defendants, plaintiffs, and judges. Other controls include case type" ///
	"dummies, a dummy for an appeal case, and variables for the numbers of defendants, plaintiffs," ///
	"and judges. To prevent a loss of observations, all categorical controls (such as case type)" ///
	"include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs, def. = defendants," ///
	"maj. = majority.")  ///
	coeflab(1.appl_maj_fem "Pla. maj. female" 1.resp_maj_fem "Def. maj. female") ///
	keep(1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_fem 1.resp_maj_fem) 

esttab using randocheck_gender_full_notext.tex, replace label eqlabels(none) se  ///
	title(Gender randomization checks)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote  ///
	coeflab(1.appl_maj_fem "Pla. maj. female" 1.resp_maj_fem "Def. maj. female") ///
	keep(1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_fem 1.resp_maj_fem) 


*** Gender, pre

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year<2011

eststo clear

eststo: reghdfe  ///
	judge_maj_fem ///
	i.appl_maj_fem ///
	i.resp_maj_fem, ///
	absorb(court_year) cluster(judges) 	
quietly estadd local fixede "No", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe ///
	judge_maj_fem ///
	i.appl_maj_fem ///
	i.resp_maj_fem ///
	$controls_ethn ,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	$controls_ethn ///	
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_gender_pre.tex, replace label eqlabels(none) se  ///
	title(Gender randomization checks, before 2011)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"female judges than male judges. Standard errors, in parentheses, are clustered at the judge level."  ///
	"All columns are based on a linear regression model. For specification details, see equation 1."  ///
	"Sample is restricted to the years 1976-2010. Ethnicity dummies include binary variables indicating" ///
	"whether a given ethnicity is the plurality, one for each ethnicity, for defendants, plaintiffs," ///
	"and judges. Other controls include case type dummies, a dummy for an appeal case, and variables for" ///
	"the numbers of defendants, plaintiffs, and judges. To prevent a loss of observations, all" ///
	"categorical controls (such as case type) include a dummy that denotes if data is missing/unknown." ///
	"Pla. = Plaintiffs, Def. = defendants, maj. = majority.")  ///
	coeflab(1.appl_maj_fem "Pla. maj. female" 1.resp_maj_fem "Def. maj. female") ///
	keep(1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_fem 1.resp_maj_fem) 
	
	
	
	
*** Gender, post

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year>2010

eststo clear

eststo: reghdfe  ///
	judge_maj_fem ///
	i.appl_maj_fem ///
	i.resp_maj_fem, ///
	absorb(court_year) cluster(judges) 	
quietly estadd local fixede "No", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe ///
	judge_maj_fem ///
	i.appl_maj_fem ///
	i.resp_maj_fem ///
	$controls_ethn,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	$controls_ethn ///	
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_gender_post.tex, replace label eqlabels(none) se  ///
	title(Gender randomization checks, 2011 and after)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"female judges than male judges. Standard errors, in parentheses, are clustered at the judge level."  ///
	"All columns are based on a linear regression model. For specification details, see equation 1."  ///
	"Sample is restricted to the years 2011-2020. Ethnicity dummies include binary variables indicating" ///
	"whether a given ethnicity is the plurality, one for each ethnicity, for defendants, plaintiffs," ///
	"and judges. Other controls include case type dummies, a dummy for an appeal case, and variables for" ///
	"the numbers of defendants, plaintiffs, and judges. To prevent a loss of observations, all" ///
	"categorical controls (such as case type) include a dummy that denotes if data is missing/unknown." ///
	"Pla. = Plaintiffs, Def. = defendants, maj. = majority.")  ///
	coeflab(1.appl_maj_fem "Pla. maj. female" 1.resp_maj_fem "Def. maj. female") ///
	keep(1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_fem 1.resp_maj_fem) 
	
	
	
	
*** Ethnicity 1, full

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear
	
eststo: reghdfe  ///
	judge_maj_kalenjin  ///
	i.appl_maj_kalenjin  ///
	i.resp_maj_kalenjin ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	i.case_type num_respondents num_applicants num_judges appeal, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_kamba ///
	i.appl_maj_kamba ///
	i.resp_maj_kamba ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.case_type num_respondents num_applicants num_judges appeal, ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_kikuyu ///
	i.appl_maj_kikuyu ///
	i.resp_maj_kikuyu ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth1_full.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks 1)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities. Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Other controls include case type dummies, a dummy for" ///
	"an appeal case, and variables for the numbers of defendants, plaintiffs, and judges. To prevent" /// 
	"a loss of observations, all categorical controls (such as case type) include a dummy that" ///
	"denotes if data is missing/unknown. Pla. = plaintiffs, def. = defendants, plur. = plurality," ///
	"maj. = majority.")  ///
	coeflab(1.appl_maj_kalenjin "Pla. plur. Kalenjin" 1.resp_maj_kalenjin "Def. plur. Kalenjin" ///
			1.appl_maj_kamba "Pla. plur. Kamba" 1.resp_maj_kamba "Def. plur. Kamba" ///
			1.appl_maj_kikuyu "Pla. plur. Kikuyu" 1.resp_maj_kikuyu "Def. plur. Kikuyu" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_kalenjin 1.resp_maj_kalenjin 1.appl_maj_kamba 1.resp_maj_kamba  1.appl_maj_kikuyu 1.resp_maj_kikuyu) /// 1.appl_maj_fem 1.resp_maj_fem) ///
	order (1.appl_maj_kalenjin 1.resp_maj_kalenjin 1.appl_maj_kamba 1.resp_maj_kamba 1.appl_maj_kikuyu 1.resp_maj_kikuyu) // 1.appl_maj_fem 1.resp_maj_fem) 

	
esttab using randocheck_eth1_full_notext.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks 1)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote ///
	coeflab(1.appl_maj_kalenjin "Pla. plur. Kalenjin" 1.resp_maj_kalenjin "Def. plur. Kalenjin" ///
			1.appl_maj_kamba "Pla. plur. Kamba" 1.resp_maj_kamba "Def. plur. Kamba" ///
			1.appl_maj_kikuyu "Pla. plur. Kikuyu" 1.resp_maj_kikuyu "Def. plur. Kikuyu" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_kalenjin 1.resp_maj_kalenjin 1.appl_maj_kamba 1.resp_maj_kamba  1.appl_maj_kikuyu 1.resp_maj_kikuyu) /// 1.appl_maj_fem 1.resp_maj_fem) ///
	order (1.appl_maj_kalenjin 1.resp_maj_kalenjin 1.appl_maj_kamba 1.resp_maj_kamba 1.appl_maj_kikuyu 1.resp_maj_kikuyu) // 1.appl_maj_fem 1.resp_maj_fem) 
	

*** Ethnicity 2, full

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe  ///
	judge_maj_kisii  ///
	i.appl_maj_kisii  ///
	i.resp_maj_kisii  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_luhya ///
	i.appl_maj_luhya ///
	i.resp_maj_luhya ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_luo ///
	i.appl_maj_luo ///
	i.resp_maj_luo ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth2_full.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks 2)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities. Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Other controls include case type dummies, a dummy for" ///
	"an appeal case, and variables for the numbers of defendants, plaintiffs, and judges. To prevent" /// 
	"a loss of observations, all categorical controls (such as case type) include a dummy that" ///
	"denotes if data is missing/unknown. Pla. = plaintiffs, def. = defendants, plur. = plurality," ///
	"maj. = majority.")  ///
	coefl(1.appl_maj_kisii "Pla. plur. Kisii" 1.resp_maj_kisii "Def. plur. Kisii" ///
		  1.appl_maj_luhya "Pla. plur. Luhya" 1.resp_maj_luhya "Def. plur. Luhya" ///
		  1.appl_maj_luo "Pla. plur. Luo" 1.resp_maj_luo "Def. plur. Luo" ///
		  1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_kisii  1.resp_maj_kisii  1.appl_maj_luhya 1.resp_maj_luhya  1.appl_maj_luo 1.resp_maj_luo) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_kisii  1.resp_maj_kisii  1.appl_maj_luhya 1.resp_maj_luhya 1.appl_maj_luo 1.resp_maj_luo) // 1.appl_maj_fem 1.resp_maj_fem) 



	
*** Ethnicity 3, full

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe  ///
	judge_maj_masai ///
	i.appl_maj_masai  ///
	i.resp_maj_masai ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_meru ///
	i.appl_maj_meru ///
	i.resp_maj_meru ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year)  cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_mijikenda ///
	i.appl_maj_mijikenda ///
	i.resp_maj_mijikenda ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth3_full.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks 3)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities. Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Other controls include case type dummies, a dummy for" ///
	"an appeal case, and variables for the numbers of defendants, plaintiffs, and judges. To prevent" /// 
	"a loss of observations, all categorical controls (such as case type) include a dummy that" ///
	"denotes if data is missing/unknown. Pla. = plaintiffs, def. = defendants, plur. = plurality," ///
	"maj. = majority.")  ///
	coeflab(1.appl_maj_masai "Pla. plur. Masai" 1.resp_maj_masai  "Def. plur. Masai" ///
			1.appl_maj_meru "Pla. plur. Meru" 1.resp_maj_meru "Def. plur. Meru" ///
			1.appl_maj_mijikenda "Pla. plur. Mijikenda" 1.resp_maj_mijikenda "Def. maj. Mijikenda" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_masai  1.resp_maj_masai  1.appl_maj_meru 1.resp_maj_meru 1.appl_maj_mijikenda 1.resp_maj_mijikenda) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_masai  1.resp_maj_masai  1.appl_maj_meru 1.resp_maj_meru 1.appl_maj_mijikenda 1.resp_maj_mijikenda) // 1.appl_maj_fem 1.resp_maj_fem) 

	


*** Ethnicity 4, full

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe  ///
	judge_maj_pokot  ///
	i.appl_maj_pokot ///
	i.resp_maj_pokot ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_somali ///
	i.appl_maj_somali ///
	i.resp_maj_somali ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_turkana ///
	i.appl_maj_turkana ///
	i.resp_maj_turkana ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm


esttab using randocheck_eth4_full.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks 4)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities. Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Other controls include case type dummies, a dummy for" ///
	"an appeal case, and variables for the numbers of defendants, plaintiffs, and judges. To prevent" /// 
	"a loss of observations, all categorical controls (such as case type) include a dummy that" ///
	"denotes if data is missing/unknown. Pla. = plaintiffs, def. = defendants, plur. = plurality," ///
	"maj. = majority.")  ///
	coeflab(1.appl_maj_pokot "Pla. plur. Pokot" 1.resp_maj_pokot "Def. plur. Pokot" ///
			1.appl_maj_somali "Pla. plur. Somali" 1.resp_maj_somali "Def. plur. Somali" ///
			1.appl_maj_turkana "Pla. plur. Turkana" 1.resp_maj_turkana "Def. plur. Turkana" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep( 1.appl_maj_pokot  1.resp_maj_pokot  1.appl_maj_somali 1.resp_maj_somali  1.appl_maj_turkana 1.resp_maj_turkana) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_pokot  1.resp_maj_pokot  1.appl_maj_somali 1.resp_maj_somali  1.appl_maj_turkana 1.resp_maj_turkana) // 1.appl_maj_fem 1.resp_maj_fem) 
	
	
	
	
*** Ethnicity 1, pre

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year<2011

eststo clear
	
eststo: reghdfe  ///
	judge_maj_kalenjin  ///
	i.appl_maj_kalenjin  ///
	i.resp_maj_kalenjin ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_kamba ///
	i.appl_maj_kamba ///
	i.resp_maj_kamba ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_kikuyu ///
	i.appl_maj_kikuyu ///
	i.resp_maj_kikuyu ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth1.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks, before 2011, 1)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities.Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Sample is restricted to the years 1976-2010. Other" ///
	"controls include case type dummies, a dummy for an appeal case, and variables for the numbers" ///
	"of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls" ///
	"(such as case type) include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs," ///
	"def. = defendants, plur. = plurality, maj. = majority.")  ///
	coeflab(1.appl_maj_kalenjin "Pla. plur. Kalenjin" 1.resp_maj_kalenjin "Def. plur. Kalenjin" ///
			1.appl_maj_kamba "Pla. plur. Kamba" 1.resp_maj_kamba "Def. plur. Kamba" ///
			1.appl_maj_kikuyu "Pla. plur. Kikuyu" 1.resp_maj_kikuyu "Def. plur. Kikuyu" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_kalenjin 1.resp_maj_kalenjin 1.appl_maj_kamba 1.resp_maj_kamba  1.appl_maj_kikuyu 1.resp_maj_kikuyu) /// 1.appl_maj_fem 1.resp_maj_fem) ///
	order (1.appl_maj_kalenjin 1.resp_maj_kalenjin 1.appl_maj_kamba 1.resp_maj_kamba 1.appl_maj_kikuyu 1.resp_maj_kikuyu) // 1.appl_maj_fem 1.resp_maj_fem) 

	
	

*** Ethnicity 2, pre

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year<2011

eststo clear

eststo: reghdfe  ///
	judge_maj_kisii  ///
	i.appl_maj_kisii  ///
	i.resp_maj_kisii  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_luhya ///
	i.appl_maj_luhya ///
	i.resp_maj_luhya ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_luo ///
	i.appl_maj_luo ///
	i.resp_maj_luo ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth2.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks, before 2011, 2)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities.Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Sample is restricted to the years 1976-2010. Other" ///
	"controls include case type dummies, a dummy for an appeal case, and variables for the numbers" ///
	"of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls" ///
	"(such as case type) include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs," ///
	"def. = defendants, plur. = plurality, maj. = majority.")  ///
	coefl(1.appl_maj_kisii "Pla. plur. Kisii" 1.resp_maj_kisii "Def. plur. Kisii" ///
		  1.appl_maj_luhya "Pla. plur. Luhya" 1.resp_maj_luhya "Def. plur. Luhya" ///
		  1.appl_maj_luo "Pla. plur. Luo" 1.resp_maj_luo "Def. plur. Luo" ///
		  1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_kisii  1.resp_maj_kisii  1.appl_maj_luhya 1.resp_maj_luhya  1.appl_maj_luo 1.resp_maj_luo) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_kisii  1.resp_maj_kisii  1.appl_maj_luhya 1.resp_maj_luhya 1.appl_maj_luo 1.resp_maj_luo) // 1.appl_maj_fem 1.resp_maj_fem) 



	
*** Ethnicity 3, pre

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year<2011

eststo clear

eststo: reghdfe  ///
	judge_maj_masai ///
	i.appl_maj_masai  ///
	i.resp_maj_masai ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_meru ///
	i.appl_maj_meru ///
	i.resp_maj_meru ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year)  cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_mijikenda ///
	i.appl_maj_mijikenda ///
	i.resp_maj_mijikenda ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth3.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks, before 2011, 3)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities.Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Sample is restricted to the years 1976-2010. Other" ///
	"controls include case type dummies, a dummy for an appeal case, and variables for the numbers" ///
	"of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls" ///
	"(such as case type) include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs," ///
	"def. = defendants, plur. = plurality, maj. = majority.")  ///
	coeflab(1.appl_maj_masai "Pla. plur. Masai" 1.resp_maj_masai  "Def. plur. Masai" ///
			1.appl_maj_meru "Pla. plur. Meru" 1.resp_maj_meru "Def. plur. Meru" ///
			1.appl_maj_mijikenda "Pla. plur. Mijikenda" 1.resp_maj_mijikenda "Def. maj. Mijikenda" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_masai  1.resp_maj_masai  1.appl_maj_meru 1.resp_maj_meru 1.appl_maj_mijikenda 1.resp_maj_mijikenda) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_masai  1.resp_maj_masai  1.appl_maj_meru 1.resp_maj_meru 1.appl_maj_mijikenda 1.resp_maj_mijikenda) // 1.appl_maj_fem 1.resp_maj_fem) 

	


*** Ethnicity 4, pre

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year<2011

eststo clear

eststo: reghdfe  ///
	judge_maj_pokot  ///
	i.appl_maj_pokot ///
	i.resp_maj_pokot ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_somali ///
	i.appl_maj_somali ///
	i.resp_maj_somali ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_turkana ///
	i.appl_maj_turkana ///
	i.resp_maj_turkana ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm


esttab using randocheck_eth4.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks, before 2011, 4)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities.Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Sample is restricted to the years 1976-2010. Other" ///
	"controls include case type dummies, a dummy for an appeal case, and variables for the numbers" ///
	"of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls" ///
	"(such as case type) include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs," ///
	"def. = defendants, plur. = plurality, maj. = majority.")  ///
	coeflab(1.appl_maj_pokot "Pla. plur. Pokot" 1.resp_maj_pokot "Def. plur. Pokot" ///
			1.appl_maj_somali "Pla. plur. Somali" 1.resp_maj_somali "Def. plur. Somali" ///
			1.appl_maj_turkana "Pla. plur. Turkana" 1.resp_maj_turkana "Def. plur. Turkana" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep( 1.appl_maj_pokot  1.resp_maj_pokot  1.appl_maj_somali 1.resp_maj_somali  1.appl_maj_turkana 1.resp_maj_turkana) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_pokot  1.resp_maj_pokot  1.appl_maj_somali 1.resp_maj_somali  1.appl_maj_turkana 1.resp_maj_turkana) // 1.appl_maj_fem 1.resp_maj_fem) 
	
	
	
	
*** Ethnicity, no controls, pre

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year<2011
	
eststo: reghdfe  ///
	judge_maj_kalenjin  ///
	i.appl_maj_kalenjin  ///
	i.resp_maj_kalenjin, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_kamba ///
	i.appl_maj_kamba ///
	i.resp_maj_kamba, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_kikuyu ///
	i.appl_maj_kikuyu ///
	i.resp_maj_kikuyu, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_kisii  ///
	i.appl_maj_kisii  ///
	i.resp_maj_kisii, ///
	absorb(court_year) cluster(judges)  
	
eststo: reghdfe  ///
	judge_maj_luhya ///
	i.appl_maj_luhya ///
	i.resp_maj_luhya, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_luo ///
	i.appl_maj_luo ///
	i.resp_maj_luo, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_masai ///
	i.appl_maj_masai  ///
	i.resp_maj_masai, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_meru ///
	i.appl_maj_meru ///
	i.resp_maj_meru, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_mijikenda ///
	i.appl_maj_mijikenda ///
	i.resp_maj_mijikenda, ///
	absorb(court_year) cluster(judges)  
	
eststo: reghdfe  ///
	judge_maj_pokot  ///
	i.appl_maj_pokot ///
	i.resp_maj_pokot, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_somali ///
	i.appl_maj_somali ///
	i.resp_maj_somali, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_turkana ///
	i.appl_maj_turkana ///
	i.resp_maj_turkana, ///
	absorb(court_year) cluster(judges)  

	
	
	
*** Ethnicity 1, post

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year>2010

eststo clear
	
eststo: reghdfe  ///
	judge_maj_kalenjin  ///
	i.appl_maj_kalenjin  ///
	i.resp_maj_kalenjin ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_kamba ///
	i.appl_maj_kamba ///
	i.resp_maj_kamba ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_kikuyu ///
	i.appl_maj_kikuyu ///
	i.resp_maj_kikuyu ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth1_post.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks, 2011 and after, 1)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities.Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Sample is restricted to the years 2011-2020. Other" ///
	"controls include case type dummies, a dummy for an appeal case, and variables for the numbers" ///
	"of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls" ///
	"(such as case type) include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs," ///
	"def. = defendants, plur. = plurality, maj. = majority.")  ///
	coeflab(1.appl_maj_kalenjin "Pla. plur. Kalenjin" 1.resp_maj_kalenjin "Def. plur. Kalenjin" ///
			1.appl_maj_kamba "Pla. plur. Kamba" 1.resp_maj_kamba "Def. plur. Kamba" ///
			1.appl_maj_kikuyu "Pla. plur. Kikuyu" 1.resp_maj_kikuyu "Def. plur. Kikuyu" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_kalenjin 1.resp_maj_kalenjin 1.appl_maj_kamba 1.resp_maj_kamba  1.appl_maj_kikuyu 1.resp_maj_kikuyu) /// 1.appl_maj_fem 1.resp_maj_fem) ///
	order (1.appl_maj_kalenjin 1.resp_maj_kalenjin 1.appl_maj_kamba 1.resp_maj_kamba 1.appl_maj_kikuyu 1.resp_maj_kikuyu) // 1.appl_maj_fem 1.resp_maj_fem) 

	
	

*** Ethnicity 2, post

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year>2010

eststo clear

eststo: reghdfe  ///
	judge_maj_kisii  ///
	i.appl_maj_kisii  ///
	i.resp_maj_kisii  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_luhya ///
	i.appl_maj_luhya ///
	i.resp_maj_luhya ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_luo ///
	i.appl_maj_luo ///
	i.resp_maj_luo ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth2_post.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks, 2011 and after, 2)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities.Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Sample is restricted to the years 2011-2020. Other" ///
	"controls include case type dummies, a dummy for an appeal case, and variables for the numbers" ///
	"of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls" ///
	"(such as case type) include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs," ///
	"def. = defendants, plur. = plurality, maj. = majority.")  ///
	coefl(1.appl_maj_kisii "Pla. plur. Kisii" 1.resp_maj_kisii "Def. plur. Kisii" ///
		  1.appl_maj_luhya "Pla. plur. Luhya" 1.resp_maj_luhya "Def. plur. Luhya" ///
		  1.appl_maj_luo "Pla. plur. Luo" 1.resp_maj_luo "Def. plur. Luo" ///
		  1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_kisii  1.resp_maj_kisii  1.appl_maj_luhya 1.resp_maj_luhya  1.appl_maj_luo 1.resp_maj_luo) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_kisii  1.resp_maj_kisii  1.appl_maj_luhya 1.resp_maj_luhya 1.appl_maj_luo 1.resp_maj_luo) // 1.appl_maj_fem 1.resp_maj_fem) 



	
*** Ethnicity 3, post

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year>2010

eststo clear

eststo: reghdfe  ///
	judge_maj_masai ///
	i.appl_maj_masai  ///
	i.resp_maj_masai ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_meru ///
	i.appl_maj_meru ///
	i.resp_maj_meru ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year)  cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_mijikenda ///
	i.appl_maj_mijikenda ///
	i.resp_maj_mijikenda ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using randocheck_eth3_post.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks, 2011 and after, 3)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities.Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Sample is restricted to the years 2011-2020. Other" ///
	"controls include case type dummies, a dummy for an appeal case, and variables for the numbers" ///
	"of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls" ///
	"(such as case type) include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs," ///
	"def. = defendants, plur. = plurality, maj. = majority.")  ///
	coeflab(1.appl_maj_masai "Pla. plur. Masai" 1.resp_maj_masai  "Def. plur. Masai" ///
			1.appl_maj_meru "Pla. plur. Meru" 1.resp_maj_meru "Def. plur. Meru" ///
			1.appl_maj_mijikenda "Pla. plur. Mijikenda" 1.resp_maj_mijikenda "Def. maj. Mijikenda" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep(1.appl_maj_masai  1.resp_maj_masai  1.appl_maj_meru 1.resp_maj_meru 1.appl_maj_mijikenda 1.resp_maj_mijikenda) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_masai  1.resp_maj_masai  1.appl_maj_meru 1.resp_maj_meru 1.appl_maj_mijikenda 1.resp_maj_mijikenda) // 1.appl_maj_fem 1.resp_maj_fem) 

	


*** Ethnicity 4, post

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year>2010

eststo clear

eststo: reghdfe  ///
	judge_maj_pokot  ///
	i.appl_maj_pokot ///
	i.resp_maj_pokot ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_somali ///
	i.appl_maj_somali ///
	i.resp_maj_somali ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe  ///
	judge_maj_turkana ///
	i.appl_maj_turkana ///
	i.resp_maj_turkana ///
	i.appl_maj_fem  ///
	i.resp_maj_fem  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm


esttab using randocheck_eth4_post.tex, replace label eqlabels(none) se ///
	title(Ethnicity randomization checks, 2011 and after, 4)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether female plaintiffs/defendants are more likely to be matched with" ///
	"judges of their own ethnicity than judges of other ethnicities.Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For" ///
	"specification details, see equation 2. Sample is restricted to the years 2011-2020. Other" ///
	"controls include case type dummies, a dummy for an appeal case, and variables for the numbers" ///
	"of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls" ///
	"(such as case type) include a dummy that denotes if data is missing/unknown. Pla. = plaintiffs," ///
	"def. = defendants, plur. = plurality, maj. = majority.")  ///
	coeflab(1.appl_maj_pokot "Pla. plur. Pokot" 1.resp_maj_pokot "Def. plur. Pokot" ///
			1.appl_maj_somali "Pla. plur. Somali" 1.resp_maj_somali "Def. plur. Somali" ///
			1.appl_maj_turkana "Pla. plur. Turkana" 1.resp_maj_turkana "Def. plur. Turkana" ///
			1.appl_maj_fem "Pla. maj. fem" 1.resp_maj_fem "Def. maj. fem") ///
	keep( 1.appl_maj_pokot  1.resp_maj_pokot  1.appl_maj_somali 1.resp_maj_somali  1.appl_maj_turkana 1.resp_maj_turkana) /// 1.appl_maj_fem 1.resp_maj_fem)  ///
	order (1.appl_maj_pokot  1.resp_maj_pokot  1.appl_maj_somali 1.resp_maj_somali  1.appl_maj_turkana 1.resp_maj_turkana) // 1.appl_maj_fem 1.resp_maj_fem) 
	
	
	
	
*** Ethnicity, no controls, post
cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep if year>2010
	
eststo: reghdfe  ///
	judge_maj_kalenjin  ///
	i.appl_maj_kalenjin  ///
	i.resp_maj_kalenjin, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_kamba ///
	i.appl_maj_kamba ///
	i.resp_maj_kamba, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_kikuyu ///
	i.appl_maj_kikuyu ///
	i.resp_maj_kikuyu, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_kisii  ///
	i.appl_maj_kisii  ///
	i.resp_maj_kisii, ///
	absorb(court_year) cluster(judges)  
	
eststo: reghdfe  ///
	judge_maj_luhya ///
	i.appl_maj_luhya ///
	i.resp_maj_luhya, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_luo ///
	i.appl_maj_luo ///
	i.resp_maj_luo, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_masai ///
	i.appl_maj_masai  ///
	i.resp_maj_masai, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_meru ///
	i.appl_maj_meru ///
	i.resp_maj_meru, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_mijikenda ///
	i.appl_maj_mijikenda ///
	i.resp_maj_mijikenda, ///
	absorb(court_year) cluster(judges)  
	
eststo: reghdfe  ///
	judge_maj_pokot  ///
	i.appl_maj_pokot ///
	i.resp_maj_pokot, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_somali ///
	i.appl_maj_somali ///
	i.resp_maj_somali, ///
	absorb(court_year) cluster(judges)  

eststo: reghdfe  ///
	judge_maj_turkana ///
	i.appl_maj_turkana ///
	i.resp_maj_turkana, ///
	absorb(court_year) cluster(judges)  



