*********************************************************************************
****************************** Main gender results ******************************
*********************************************************************************



*** Gender  

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.judge_maj_fem#i.appl_maj_fem, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm
estimates store A

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem 	 ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm
estimates store B

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem 	 ///
	$controls_ethn ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm
estimates store C

* Test difference in coeffs
lincom 1.judge_maj_fem#1.appl_maj_fem - 1.judge_maj_fem#1.resp_maj_fem 


esttab using reg_gender.tex, replace label eqlabels(none) se ///
	title(Gender main results)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"majority gender as judges. The coefficients of interest are on the interaction terms. Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a linear regression model. For specification details, see" ///
	"equations 3 and 4. Ethnicity dummies include binary variables indicating whether a given ethnicity is the plurality," ///
	"one for each ethnicity, for defendants, plaintiffs, and judges. Other controls include case type dummies, a dummy for" ///
	"an appeal case, and variables for the numbers of defendants, plaintiffs, and judges. To prevent a loss of observations," ///
	"all categorical controls (such as case type) include a dummy that denotes if data is missing/unknown.Pla. = plaintiff," ///
	"def. = defendant, maj. = majority.")  ///
	coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		  1.appl_maj_fem                  "Pla. maj. female" ///
		  1.resp_maj_fem 				  "Def. maj. female" ///
		  1.judge_maj_fem#1.appl_maj_fem  "Judge maj. fem. X pla. maj. fem."  ///
		  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
	keep(1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
	order (1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem) 

esttab using reg_gender_notext.tex, replace label eqlabels(none) se ///
	title(Gender main results)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote ///
	coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		  1.appl_maj_fem                  "Pla. maj. female" ///
		  1.resp_maj_fem 				  "Def. maj. female" ///
		  1.judge_maj_fem#1.appl_maj_fem  "Judge maj. fem. X pla. maj. fem."  ///
		  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
	keep(1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
	order (1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem) 

coefplot (A, label(Fixed effects only)) (B, label(Controls added)) (C, label(Ethnicity and other controls added)), ///
		 keep(1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem) ///
		 coefl(1.judge_maj_fem#1.appl_maj_fem = "Judge maj. fem. X pla. maj. fem." ///
		 1.judge_maj_fem#1.resp_maj_fem = "Judge maj. fem. X def. maj. fem." ) ///
		 drop(_cons) xline(0, lcolor(black))
		 
graph export coefplot_gend.png, replace




	
*** Gender, 2010 and after

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.judge_maj_fem#i.appl_maj_fem, ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem 	 ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem 	 ///
	$controls_ethn ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using reg_gender_2010.tex, replace label eqlabels(none) se ///
	title(Gender results, 2010 and after)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"majority gender as judges. The coefficients of interest are on the interaction terms. Years before 2010 are dropped." ///
	"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression model." ///
	"For specification details, see equations 3 and 4. Ethnicity dummies include binary variables indicating whether a given" ///
	"ethnicity is the plurality, one for each ethnicity, for defendants, plaintiffs, and judges. Other controls include case" ///
	"type dummies, a dummy for an appeal case, and variables for the numbers of defendants, plaintiffs, and judges. To prevent" ///
	"a loss of observations, all categorical controls (such as case type) include a dummy that denotes if data is missing/unknown." ///
	"Pla. = plaintiff, def. = defendant, maj. = majority.")  ///
	coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		  1.appl_maj_fem                  "Pla. maj. female" ///
		  1.resp_maj_fem 				  "Def. maj. female" ///
		  1.judge_maj_fem#1.appl_maj_fem  "Judge maj. fem. X pla. maj. fem."  ///
		  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
	keep(1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
	order (1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem) 
	




*** Gender probit

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: probit resp_win  ///
	i.judge_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem  ///
	i.court_year, cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace
quietly estadd ysumm

eststo: probit resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.court_year, cluster(judges)   
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: probit resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem  ///
	i.court_year, cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: probit resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem 	 ///
	$controls_other   ///
	i.court_year, cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: probit resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem 	 ///
	$controls_ethn ///
	$controls_other   ///
	i.court_year, cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using reg_gender_prob.tex, replace label eqlabels(none) se ///
	title(Gender results, probit)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
	nonote addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"majority gender as judges. The coefficients of interest are on the interaction terms. Standard errors, in parentheses," ///
	"are clustered at the judge level. All columns are based on a probit regression model. Ethnicity dummies include binary" ///
	"variables indicating whether a given ethnicity is the plurality, one for each ethnicity, for defendants, plaintiffs," ///
	"and judges. Other controls include case type dummies, a dummy for an appeal case, and variables for the numbers of" ///
	"defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls (such as case type)" ///
	"include a dummy that denotes if data is missing/unknown.Pla. = plaintiff, def. = defendant, maj. = majority.")  ///
	coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		  1.appl_maj_fem                  "Pla. maj. female" ///
		  1.resp_maj_fem 				  "Def. maj. female" ///
		  1.judge_maj_fem#1.appl_maj_fem  "Judge maj. fem. X pla. maj. fem."  ///
		  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
	keep(1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
	order (1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem) 




*** Gender, robust SE

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem,  ///
	absorb(court_year) vce(robust)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.judge_maj_fem#i.appl_maj_fem, ///
	absorb(court_year) vce(robust)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem,  ///
	absorb(court_year) vce(robust)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem 	 ///
	$controls_other ,  ///
	absorb(court_year) vce(robust)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem 	 ///
	$controls_ethn ///
	$controls_other ,  ///
	absorb(court_year) vce(robust)
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 
quietly estadd ysumm

esttab using reg_gender_rob.tex, replace label eqlabels(none) se ///
	title(Gender results, robust standard errors)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote addnote( ///
	"The regressions test whether defendants (plaintiffs) are more likely to win (lose) if they have the same (a different)" ///
	"majority gender as judges. The coefficients of interest are on the interaction terms. Includes robust standard errors."  ///
	"All columns are based on a linear regression model. For specification details, see equations 3 and 4. Ethnicity dummies" ///
	"include binary variables indicating whether a given ethnicity is the plurality, one for each ethnicity, for defendants," ///
	"plaintiffs, and judges. Other controls include case type dummies, a dummy for an appeal case, and variables for the" ///
	"numbers of defendants, plaintiffs, and judges. To prevent a loss of observations, all categorical controls (such as" ///
	"case type) include a dummy that denotes if data is missing/unknown.Pla. = plaintiff, def. = defendant, maj. = majority.")  ///
	coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		  1.appl_maj_fem                  "Pla. maj. female" ///
		  1.resp_maj_fem 				  "Def. maj. female" ///
		  1.judge_maj_fem#1.appl_maj_fem  "Judge maj. fem. X pla. maj. fem."  ///
		  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
	keep(1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
	order (1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem) 
	






