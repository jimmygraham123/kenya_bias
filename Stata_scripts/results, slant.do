***************************************************************************
****************************** Slant results ******************************
***************************************************************************


	
		
*** Gender with slant

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe resp_win ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant ///
	c.appl_fem_x_slant,  ///
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
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant ///
	c.resp_fem_x_slant,  ///
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
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant ///
	c.appl_fem_x_slant ///
	c.resp_fem_x_slant,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
quietly estadd ysumm

	* Marginsplot
	
	reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant ///
	c.appl_fem_x_slant ///
	i.resp_maj_fem#c.median_slant, ///
	absorb(court_year) cluster(judges)  
	
	margins resp_maj_fem, at(median_slant=(-.05(.05).2) )

	marginsplot, level(90) ciopt(color(%50)) recastci(rarea) ///
				 ytitle("Defendant win proportion") ///
				 xtitle("Slant against women, career vs family measure") ///
				 title("") ///
				 legend(order(3 "Male defendants" ///
							  4 "Female defendants" ///
							  1 "90% CI" 2 "90% CI")) 
	graph export slant_margins_fam.png, replace

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant ///
	c.appl_fem_x_slant ///
	c.resp_fem_x_slant ///
	$controls_ethn ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 


esttab using reg_slant.tex, replace label eqlabels(none) se ///
	title(Gender results with text slant, career vs family measure)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ysumm fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote addnote( ///
	"The regressions test whether defendants/plaintiffs are more likely to lose if they are female and the" ///
	"judge is slanted against females in their writing. The coefficients of interest are on the interaction" ///
	"terms in the last two rows. The measure of slant against women is based on the judges' stereotypical" ///
	"association of women with family-based qualities rather than career-based qualities. All columns are" ///
	"based on a linear regression model. For specification details, see equation 3. Ethnicity dummies include" ///
	"binary variables indicating whether a given ethnicity is the plurality, one for each ethnicity, for" ///
	"defendants, plaintiffs, and judges. Other controls include case type dummies, a dummy for an appeal case," ///
	"and variables for the numbers of defendants, plaintiffs, and judges. To prevent a loss of observations," ///
	"all categorical controls (such as case type) include a dummy that denotes if data is missing/unknown." ///
	"Pla. = plaintiff, def. = defendant, maj. = majority.")  ///
		coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		  1.appl_maj_fem                  "Pla. maj. female" ///
		  1.resp_maj_fem 				  "Def. maj. female" ///
		  1.judge_maj_fem#1.appl_maj_fem  "Judge maj. fem. X pla. maj. fem."  ///
		  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem."  ///
		  median_slant "Slant against women, career vs family" ///
		  appl_fem_x_slant "Pla. maj. fem. X Slant against women" ///
		  resp_fem_x_slant "Def. maj. fem. X Slant against women") ///
	keep(1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem median_slant appl_fem_x_slant resp_fem_x_slant)  ///
	order (1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem median_slant appl_fem_x_slant resp_fem_x_slant) 

	
	
	
*** Gender with slant, good v bad measure + marginsplot

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

eststo: reghdfe resp_win ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant_goodvbad ///
	c.appl_fem_x_slantgb,  ///
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
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant_goodvbad ///
	c.resp_fem_x_slantgb,  ///
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
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant_goodvbad ///
	c.appl_fem_x_slantgb ///
	c.resp_fem_x_slantgb,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "No", replace 
quietly estadd local fixedo "No", replace 
	quietly estadd ysumm

	* Marginsplot
			
	reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant_goodvbad ///
	c.appl_fem_x_slantgb ///
	i.resp_maj_fem#c.median_slant_goodvbad, ///
	absorb(court_year) cluster(judges)  

	margins resp_maj_fem, at(median_slant_goodvbad=(-.05(.05).2) )

	marginsplot, level(90) ciopt(color(%50)) recastci(rarea) ///
				 ytitle("Defendant win proportion") ///
				 xtitle("Slant against women, good vs bad measure") ///
				 title("") ///
				 legend(order(3 "Male defendants" ///
							  4 "Female defendants" ///
							  1 "90% CI" 2 "90% CI")) 
	graph export slant_margins.png, replace

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.appl_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.appl_maj_fem  ///
	i.judge_maj_fem#i.resp_maj_fem ///
	c.median_slant_goodvbad ///
	c.appl_fem_x_slantgb ///
	c.resp_fem_x_slantgb ///
	$controls_ethn ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges) 
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixede "Yes", replace 
quietly estadd local fixedo "Yes", replace 


esttab using reg_slantgb.tex, replace label eqlabels(none) se ///
	title(Gender results with text slant, good vs bad measure)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ysumm fixedcy fixede fixedo N, label("DV mean" "Court-year FE" "Ethnicity dummies" "Other controls" "Observations"))  ///
		nonote addnote( ///
		"The regressions test whether defendants/plaintiffs are more likely to lose if they are female and the" ///
	"judge is slanted against females in their writing. The coefficients of interest are on the interaction" ///
	"terms in the last two rows. The measure of slant against women is based on the judges' association of women" ///
	"with negative qualities. All columns are based on a linear regression model. For specification details, see" ///
	"equation 3. Ethnicity dummies include binary variables indicating whether a given ethnicity is the plurality," ///
	"one for each ethnicity, for defendants, plaintiffs, and judges. Other controls include case type dummies, a" ///
	"dummy for an appeal case, and variables for the numbers of defendants, plaintiffs, and judges. To prevent a" ///
	"loss of observations, all categorical controls (such as case type) include a dummy that denotes if data is" ///
	"missing/unknown. Pla. = plaintiff, def. = defendant, maj. = majority.")  ///
		coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		  1.appl_maj_fem                  "Pla. maj. female" ///
		  1.resp_maj_fem 				  "Def. maj. female" ///
		  1.judge_maj_fem#1.appl_maj_fem  "Judge maj. fem. X pla. maj. fem."  ///
		  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem."  ///
		  median_slant_goodvbad "Slant against women, good vs bad" ///
		  appl_fem_x_slantgb "Pla. maj. fem. X Slant against women" ///
		  resp_fem_x_slantgb "Def. maj. fem. X Slant against women") ///
	keep(1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem median_slant_goodvbad appl_fem_x_slantgb resp_fem_x_slantgb)  ///
	order (1.judge_maj_fem 1.appl_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.appl_maj_fem 1.judge_maj_fem#1.resp_maj_fem median_slant_goodvbad appl_fem_x_slantgb resp_fem_x_slantgb) 
	
	


