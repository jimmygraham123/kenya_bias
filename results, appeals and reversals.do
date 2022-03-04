******************************************************************************
****************************** Reversal results ******************************
******************************************************************************


	
		
*** Slant and reversals, with binscatters




	* Family vs career

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"
	
	replace reversed=0 if reversed==.
	
	eststo clear

	eststo: reghdfe reversed ///
			c.median_slant,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe reversed ///
			c.median_slant i.resp_maj_fem ///
			c.resp_fem_x_slant,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe reversed ///
			c.median_slant i.resp_maj_fem ///
			c.resp_fem_x_slant ///
			if resp_win==0,  ///
			absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "Yes", replace
quietly estadd ysumm

	eststo: reghdfe reversed ///
			c.median_slant i.appl_maj_fem ///
			c.appl_fem_x_slant,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe reversed ///
			c.median_slant i.appl_maj_fem ///
			c.appl_fem_x_slant ///
			if resp_win==1,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "Yes", replace
quietly estadd ysumm

	esttab using reverse1.tex, replace se ///
		title(Reversals and slant, family vs career)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy fixedr N, label("DVmean" "Court-year FE" "Restricted sample" "Observations"))  ///
		keep(median_slant 1.resp_maj_fem 1.appl_maj_fem resp_fem_x_slant appl_fem_x_slant) ///
		order(median_slant 1.resp_maj_fem 1.appl_maj_fem resp_fem_x_slant appl_fem_x_slant) ///
		nonote addnote( ///
		"The regressions test whether slanted judges are more likely to have case decisions reversed. The coefficients" ///
		"of interest are 'Slant against women, career vs family' and the interactions. Column 3 (5) restricts the sample" ///
		"to cases where the defendant (plaintiff) loses, and the interaction tests if reverals are more likely if the" ///
		"judges is more slanted and the defendant (plaintiff) is female. These cases have the most potentail for gender bias." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression model."  ///
		"Pla. = plaintiffs, def. = defendants, plur. = plurality, maj. = majority.")  ///
		coefl(1.appl_maj_fem                  "Pla. maj. female" ///
			  1.resp_maj_fem 				  "Def. maj. female" ///
			  median_slant "Slant against women, career vs family" ///
			  appl_fem_x_slant "Pla. maj. fem. X Slant against women" ///
			  resp_fem_x_slant "Def. maj. fem. X Slant against women") 
			  
	binscatter reversed median_slant, ///
		nq(30) absorb(court_year) ///
		xtitle("Slant against women, career vs family measure") ytitle("Proportion reversed")  
	graph export binscat_slant_career.png, replace



				
	* Good vs bad

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"
	
	replace reversed=0 if reversed==.

	eststo clear

	eststo: reghdfe reversed ///
			c.median_slant_goodvbad,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe reversed ///
			c.median_slant_goodvbad i.resp_maj_fem ///
			c.resp_fem_x_slantgb,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe reversed ///
			c.median_slant_goodvbad i.resp_maj_fem ///
			c.resp_fem_x_slantgb ///
			if resp_win==0,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "Yes", replace
	quietly estadd ysumm

	eststo: reghdfe reversed ///
			c.median_slant_goodvbad i.appl_maj_fem ///
			c.appl_fem_x_slantgb,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe reversed ///
			c.median_slant_goodvbad i.appl_maj_fem ///
			c.appl_fem_x_slantgb ///
			if resp_win==1,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "Yes", replace
quietly estadd ysumm

	esttab using reverse2.tex, replace se ///
		title(Reversals and slant, good vs bad)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy fixedr N, label("DVmean" "Court-year FE" "Restricted sample" "Observations"))  ///
		keep(median_slant_goodvbad 1.resp_maj_fem 1.appl_maj_fem resp_fem_x_slantgb appl_fem_x_slantgb) ///
		order(median_slant_goodvbad 1.resp_maj_fem 1.appl_maj_fem resp_fem_x_slantgb appl_fem_x_slantgb) ///
		nonote addnote( ///
		"The regressions test whether slanted judges are more likely to have case decisions reversed. The coefficients" ///
		"of interest are 'Slant against women, good vs bad' and the interactions. Column 3 (5) restricts the sample" ///
		"to cases where the defendant (plaintiff) loses, and the interaction tests if reverals are more likely if the" ///
		"judges is more slanted and the defendant (plaintiff) is female. These cases have the most potentail for gender bias." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression model."  ///
		"Pla. = plaintiffs, def. = defendants, plur. = plurality, maj. = majority.")  ///
		coefl(1.appl_maj_fem                  "Pla. maj. female" ///
			  1.resp_maj_fem 				  "Def. maj. female" ///
			  median_slant_goodvbad "Slant against women, good vs bad" ///
			  appl_fem_x_slantgb "Pla. maj. fem. X Slant against women" ///
			  resp_fem_x_slantgb "Def. maj. fem. X Slant against women") 
			  
	binscatter reversed median_slant_goodvbad, ///
		nq(30) absorb(court_year) ///
		xtitle("Slant against women, good vs bad measure") ytitle("Proportion reversed")  
	graph export binscat_slant_gb.png, replace
	
	
	
	
*** Slant and appeals, with binscatters




	* Family vs career

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"
		
	eststo clear

	eststo: reghdfe appealed ///
			c.median_slant,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe appealed ///
			c.median_slant i.resp_maj_fem ///
			c.resp_fem_x_slant,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe appealed ///
			c.median_slant i.resp_maj_fem ///
			c.resp_fem_x_slant ///
			if resp_win==0,  ///
			absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "Yes", replace
quietly estadd ysumm

	eststo: reghdfe appealed ///
			c.median_slant i.appl_maj_fem ///
			c.appl_fem_x_slant,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe appealed ///
			c.median_slant i.appl_maj_fem ///
			c.appl_fem_x_slant ///
			if resp_win==1,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedr "Yes", replace
quietly estadd ysumm

	esttab using appealed1.tex, replace se ///
		title(Appeals and slant, family vs career)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy fixedr N, label("DVmean" "Court-year FE" "Restricted sample" "Observations"))  ///
		keep(median_slant 1.resp_maj_fem 1.appl_maj_fem resp_fem_x_slant appl_fem_x_slant) ///
		order(median_slant 1.resp_maj_fem 1.appl_maj_fem resp_fem_x_slant appl_fem_x_slant) ///
		nonote addnote( ///
		"The regressions test whether slanted judges are more likely to have case decisions appealed.The coefficients" ///
		"of interest are 'Slant against women, family vs career' and the interactions. Column 3 (5) restricts the sample" ///
		"to cases where the defendant (plaintiff) loses, and the interaction tests if reverals are more likely if the" ///
		"judges is more slanted and the defendant (plaintiff) is female. These cases have the most potentail for gender bias." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression model.") ///
		coefl(1.appl_maj_fem                  "Pla. maj. female" ///
			  1.resp_maj_fem 				  "Def. maj. female" ///
			  median_slant "Slant against women, career vs family" ///
			  appl_fem_x_slant "Pla. maj. fem. X Slant against women" ///
			  resp_fem_x_slant "Def. maj. fem. X Slant against women")
			  
	binscatter appealed median_slant, ///
		nq(30) absorb(court_year) ///
		xtitle("Slant against women, career vs family measure") ytitle("Proportion appealed")  
	graph export binscat_slantappealed_career.png, replace



				
	* Good vs bad

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"
	
	eststo clear

	eststo: reghdfe appealed ///
			c.median_slant_goodvbad,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedo "No", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe appealed ///
			c.median_slant_goodvbad i.resp_maj_fem ///
			c.resp_fem_x_slantgb,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedo "No", replace 
	quietly estadd local fixedr "No", replace
	quietly estadd ysumm

	eststo: reghdfe appealed ///
			c.median_slant_goodvbad i.resp_maj_fem ///
			c.resp_fem_x_slantgb ///
			if resp_win==0,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedo "No", replace
	quietly estadd local fixedr "Yes", replace
	quietly estadd ysumm

	eststo: reghdfe appealed ///
			c.median_slant_goodvbad i.appl_maj_fem ///
			c.appl_fem_x_slantgb,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedo "No", replace
	quietly estadd local fixedr "No", replace
	   quietly estadd ysumm

	eststo: reghdfe appealed ///
			c.median_slant_goodvbad i.appl_maj_fem ///
			c.appl_fem_x_slantgb ///
			if resp_win==1,  ///
		absorb(court_year) cluster(judges)  
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd local fixedo "No", replace
	quietly estadd local fixedr "Yes", replace
quietly estadd ysumm

	esttab using appealed2.tex, replace se ///
		title(Appeals and slant, good vs bad)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy fixedr N, label("DVmean" "Court-year FE" "Restricted sample" "Observations"))  ///
		keep(median_slant_goodvbad 1.resp_maj_fem 1.appl_maj_fem resp_fem_x_slantgb appl_fem_x_slantgb) ///
		order(median_slant_goodvbad 1.resp_maj_fem 1.appl_maj_fem resp_fem_x_slantgb appl_fem_x_slantgb) ///
		nonote addnote( ///
		"The regressions test whether slanted judges are more likely to have case decisions appealed.The coefficients" ///
		"of interest are 'Slant against women, good vs bad' and the interactions. Column 3 (5) restricts the sample" ///
		"to cases where the defendant (plaintiff) loses, and the interaction tests if reverals are more likely if the" ///
		"judges is more slanted and the defendant (plaintiff) is female. These cases have the most potentail for gender bias." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression model.")  ///
		coefl(1.appl_maj_fem                  "Pla. maj. female" ///
			  1.resp_maj_fem 				  "Def. maj. female" ///
			  median_slant_goodvbad "Slant against women, good vs bad" ///
			  appl_fem_x_slantgb "Pla. maj. fem. X Slant against women" ///
			  resp_fem_x_slantgb "Def. maj. fem. X Slant against women") 
		
	binscatter reversed median_slant_goodvbad, ///
		nq(30) absorb(court_year) ///
		xtitle("Slant against women, good vs bad measure") ytitle("Proportion appealed")  
	graph export binscat_slantappealed_gb.png, replace

		
		
		
		
