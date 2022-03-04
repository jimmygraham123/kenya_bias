************************************************************************************
****************************** Main ethnicity results ******************************
************************************************************************************




*** Ethnicity 

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe resp_win  ///
	i.judge_app_same, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
    i.judge_resp_same, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm
estimates store A

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge , ///
	absorb(court_year) cluster(judges)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm
estimates store B

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge ///
	$controls_gender ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm
estimates store C

* Test difference in coeffs
lincom 1.judge_app_same - 1.judge_resp_same 


esttab using reg_eth.tex, replace label eqlabels(none) se  ///
	title(Ethnicity results)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote  addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"plurality ethnicity as judges. Standard errors, in parentheses, are clustered at the judge level. All columns are based" ///
	"on a linear regression model. For specification details, see equation 5. Judge-pla. same and Judge-def. same refer to" ///
	"similarity in plurality ethnicity. Ethnicity dummies include binary variables indicating whether a given ethnicity is" ///
	"the plurality, one for each ethnicity, for both defendants and plaintifs. Other controls include case type dummies;" ///
	"a dummy for an appeal case; variables for the numbers of defendants, plaintiffs, and judges; and dummies for defendant," ///
	"plaintiff, and judge majority gender. To prevent a loss of observations, all categorical controls (such as case type)" ///
	"include a dummy that denotes if data is missing/unknown. Pla. = plaintiff, def. = defendant.")  ///
	coefl(1.judge_app_same  "Judge-pla. same" ///
		  1.judge_resp_same "Judge-def. same") ///
	keep(1.judge_app_same 1.judge_resp_same)  ///
	order (1.judge_app_same 1.judge_resp_same) 


	coefplot (A, label(Fixed effects only)) (B, label(Controls added)) (C, label(Ethnicity and other controls added)), ///
		 keep(1.judge_app_same 1.judge_resp_same) ///
		 coefl(1.judge_app_same = "Judge-pla. same" ///
		  1.judge_resp_same = "Judge-def. same") ///
		 drop(_cons) xline(0, lcolor(black))
		 
graph export coefplot_ethn.png, replace





*** Ethnicity probit

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: probit resp_win  ///
	i.judge_app_same ///
	i.court_year, cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: probit resp_win  ///
    i.judge_resp_same ///
	i.court_year, cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: probit resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	i.court_year, cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: probit resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge ///
	i.court_year, cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: probit resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge ///
	$controls_gender ///
	$controls_other  ///
	i.court_year, cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using reg_eth_prob.tex, replace label eqlabels(none) se  ///
	title(Ethnicity results, probit)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote  addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"plurality ethnicity as judges. Standard errors, in parentheses, are clustered at the judge level. All columns are based" ///
	"on a probit regression model. Judge-pla. same and Judge-def. same refer to similarity in plurality ethnicity. Ethnicity" ///
	"dummies include binary variables indicating whether a given ethnicity is the plurality, one for each ethnicity, for both" ///
	"defendants and plaintifs. Other controls include case type dummies; a dummy for an appeal case; variables for the numbers" ///
	"of defendants, plaintiffs, and judges; and dummies for defendant, plaintiff, and judge majority gender. To prevent a loss" ///
	"of observations, all categorical controls (such as case type) include a dummy that denotes if data is missing/unknown." ///
	"Pla. = plaintiff, def. = defendant.")  ///
	coefl(1.judge_app_same  "Judge-pla. same" ///
		  1.judge_resp_same "Judge-def. same") ///
	keep(1.judge_app_same 1.judge_resp_same)  ///
	order (1.judge_app_same 1.judge_resp_same) 		
	
	
	
	
*** Ethnicity, no Luhya or Kamba
	
cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

drop if inlist(majority_ethnicity_applicants, 3, 6) | ///
		inlist(majority_ethnicity_respondents, 3, 6) | ///
		inlist(majority_ethnicity_judges, 3, 6) 
		
eststo: reghdfe resp_win  ///
	i.judge_app_same ,   ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
    i.judge_resp_same,   ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same,   ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge , ///
	absorb(court_year) cluster(judges)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge ///
	$controls_gender ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm


esttab using reg_eth_noSom.tex, replace  ///
	label eqlabels(none) se noeqli ///
	title(Ethnicity results, no Kamba or Luhya)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"plurality ethnicity as judges. Standard errors, in parentheses, are clustered at the judge level. All columns are based" ///
	"on a linear regression model. For specification details, see equation 5. Judge-pla. same and Judge-def. same refer to" ///
	"similarity in plurality ethnicity. Ethnicity dummies include binary variables indicating whether a given ethnicity is" ///
	"the plurality, one for each ethnicity, for both defendants and plaintifs. Other controls include case type dummies;" ///
	"a dummy for an appeal case; variables for the numbers of defendants, plaintiffs, and judges; and dummies for defendant," ///
	"plaintiff, and judge majority gender. To prevent a loss of observations, all categorical controls (such as case type)" ///
	"include a dummy that denotes if data is missing/unknown. Pla. = plaintiff, def. = defendant.")  ///
	coefl(1.judge_app_same  "Judge-pla. same" ///
		  1.judge_resp_same "Judge-def. same") ///
	keep(1.judge_app_same 1.judge_resp_same)  ///
	order (1.judge_app_same 1.judge_resp_same) 
	
	
	
	
*** Ethnicity, post-2010

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

drop if year<2010

eststo clear

eststo: reghdfe resp_win  ///
	i.judge_app_same, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
    i.judge_resp_same, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge , ///
	absorb(court_year) cluster(judges)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge ///
	$controls_gender ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using reg_eth_2010.tex, replace label eqlabels(none) se  ///
	title(Ethnicity results, 2010 and after)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"plurality ethnicity as judges. Standard errors, in parentheses, are clustered at the judge level. All columns are based" ///
	"on a linear regression model. For specification details, see equation 5. Judge-pla. same and Judge-def. same refer to" ///
	"similarity in plurality ethnicity. Ethnicity dummies include binary variables indicating whether a given ethnicity is" ///
	"the plurality, one for each ethnicity, for both defendants and plaintifs. Other controls include case type dummies;" ///
	"a dummy for an appeal case; variables for the numbers of defendants, plaintiffs, and judges; and dummies for defendant," ///
	"plaintiff, and judge majority gender. To prevent a loss of observations, all categorical controls (such as case type)" ///
	"include a dummy that denotes if data is missing/unknown. Pla. = plaintiff, def. = defendant. Years before 2010 are dropped")  ///
	coefl(1.judge_app_same  "Judge-pla. same" ///
		  1.judge_resp_same "Judge-def. same") ///
	keep(1.judge_app_same 1.judge_resp_same)  ///
	order (1.judge_app_same 1.judge_resp_same) 

	
	
	

*** Ethnicity robust

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe resp_win  ///
	i.judge_app_same, ///
	absorb(court_year) vce(robust)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
    i.judge_resp_same, ///
	absorb(court_year) vce(robust)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same, ///
	absorb(court_year) vce(robust)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge , ///
	absorb(court_year) vce(robust)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same i.judge_resp_same ///
	$controls_ethn_nojudge ///
	$controls_gender ///
	$controls_other ,  ///
	absorb(court_year) vce(robust)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using reg_eth_rob.tex, replace label eqlabels(none) se  ///
	title(Ethnicity results, robust standard errors)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"plurality ethnicity as judges. Includes robust standard errors. All columns are based on a linear regression model." ///
	"For specification details, see equation 5. Judge-pla. same and Judge-def. same refer to similarity in plurality ethnicity." ///
	"Ethnicity dummies include binary variables indicating whether a given ethnicity is the plurality, one for each ethnicity," ///
	"for both defendants and plaintifs. Other controls include case type dummies; a dummy for an appeal case; variables for the" ///
	"numbers of defendants, plaintiffs, and judges; and dummies for defendant, plaintiff, and judge majority gender. To prevent" ///
	"a loss of observations, all categorical controls (such as case type) include a dummy that denotes if data is missing/unknown." ///
	"Pla. = plaintiff, def. = defendant. Years before 2010 are dropped")  ///
	coefl(1.judge_app_same  "Judge-pla. same" ///
		  1.judge_resp_same "Judge-def. same") ///
	keep(1.judge_app_same 1.judge_resp_same)  ///
	order (1.judge_app_same 1.judge_resp_same) 
	

	
	

	
	
