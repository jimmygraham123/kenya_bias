********************************************************************************************
****************************** Gender-ethnicity combo results ******************************
********************************************************************************************




*** Gender-ethnicity combo

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe resp_win  ///
	i.judge_resp_same_G ///
	i.judge_resp_same ///
	i.judge_resp_same_G#i.judge_resp_same,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_app_same_G ///
	i.judge_app_same ///
	i.judge_app_same_G#i.judge_app_same,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm


eststo: reghdfe resp_win  ///
	i.judge_resp_same_G ///
	i.judge_resp_same ///
	i.judge_resp_same_G#i.judge_resp_same ///
	i.judge_app_same_G ///
	i.judge_app_same ///
	i.judge_app_same_G#i.judge_app_same,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm


esttab using reg_eth_gender.tex, replace label eqlabels(none) se ///
	title(Ethnicity and gender interaction results)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	nonote addnote("Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear" ///
	"regression model. For specification details, see equation 5. Pla. = plaintiff, def. = defendant, maj. = majority.")  ///
	s(ymean fixedcy N, label("DV mean" "Court-year FE" "Observations"))  ///
	coefl ( 1.judge_app_same_G "Judge-pla. same gender" ///
			1.judge_app_same "Judge-pla. same ethnicity" ///
			1.judge_app_same_G#1.judge_app_same "Judge-pla. same gender X Judge-pla. same ethnicity" ///
			1.judge_resp_same_G "Judge-def. same gender" ///
			1.judge_resp_same "Judge-def. same ethnicity" ///
			1.judge_resp_same_G#1.judge_resp_same "Judge-def. same gender X Judge-def. same ethnicity") ///
	keep(1.judge_app_same_G ///
		1.judge_app_same ///
		1.judge_app_same_G#1.judge_app_same ///
		1.judge_resp_same_G ///
		1.judge_resp_same ///
		1.judge_resp_same_G#1.judge_resp_same)

	
	
		

