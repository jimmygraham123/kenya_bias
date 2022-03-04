**************************************************************************************
****************************** Individual judge effects ******************************
**************************************************************************************




*** Respondent gender




	* Keep only single judge cases with judges identified

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	drop if missing(judge_name)
	
	
	
	
	* Drop judge dummies with insufficient observations
	
	drop if judge_resp_same_G==.
	
	foreach judge of varlist judge1-judge494 {
			sum `judge',  meanonly
			if r(mean)==0 {
			drop `judge'
			}
	}
	
	foreach judge of varlist judge14-judge494 {
			sum resp_win if `judge'==1,  meanonly
			if r(mean)==0 {
			drop `judge'
			}
	}
	
	foreach judge of varlist judge14-judge494 {
			sum resp_win if `judge'==1,  meanonly
			if r(mean)==1 {
			drop `judge'
			}
	}
	

	foreach judge of varlist judge22-judge494 {
			sum resp_win if `judge'==1,  meanonly
			if r(N)<10 {
			drop `judge'
			}
	}
	
	
	
	
	* Count # of judges included, for notes in the graph
	
	preserve
		
	foreach judge of varlist judge28-judge493 {
		replace `judge' = 1
	}
	
	egen jnum = rowtotal(judge28-judge493)
	tab jnum
	
	
	restore
	
	


	* Observation per judges variable

	bysort  judge_name: gen obs  = [_N]
	label variable 		obs "Observations for each judge"

	
	

	* Individual judge regressions to create vars for pvalue predicted outcome

	gen 		   pval = .
	label variable pval "P values of individual judge regressions"
	
	gen coeffs=.
	
	gen ses=.

	foreach judge of varlist judge28-judge493 {

		quietly reghdfe resp_win judge_resp_same_G if `judge'==1, absorb(court_year)
		
		replace pval =  2*ttail(e(df_r), abs(_b[judge_resp_same_G]/_se[judge_resp_same_G]))    ///
		   if `judge' == 1
		   
		predict yhat_`judge' if `judge' == 1
		
		replace coeffs=_b[judge_resp_same_G ] if `judge'==1
		
		replace ses=_se[judge_resp_same_G ] if `judge'==1
			   
		}
		
	gen yhat = .
	
	foreach yhat of varlist yhat_j* {

			replace yhat = `yhat' if yhat==.
	
		}

		
	drop if pval==. // a few judges had omitted coefficients
	
	
	
	
	* Aggregate judge regression
		
	reghdfe resp_win judge_resp_same_G, absorb(court_year)
	
	predict yhat_agg 
	gen     pval_agg =  2*ttail(e(df_r), abs(_b[judge_resp_same_G]/_se[judge_resp_same_G]))
	
	
	
	
	* Create predicted outcomes vars
	
	gen same_winpropR_p = yhat if judge_resp_same_G == 1
	
	gen diff_winpropR_p = yhat if judge_resp_same_G == 0
	
	bysort judgeFE: egen same_winpropR_pred = max(same_winpropR_p)
	
	bysort judgeFE: egen diff_winpropR_pred = max(diff_winpropR_p)
		
	label variable same_winpropR_pred "Win proportion for defendants when judge and def. are same gender"

	label variable diff_winpropR_pred "Win proportion for defendants when judge and def. are different genders"
	
	gen same_winpropR_pred_agg = yhat_agg if judge_resp_same_G == 1
	gen diff_winpropR_pred_agg = yhat_agg if judge_resp_same_G == 0 // for the total observation

	
	
		
	* Add an observation to capture totals
	
	local    plus1 = _N + 1
	set obs `plus1'
	
	replace judge_name = "Total" if missing(judge_name)
	
	
	
	
	* Fill in props for new total obsevation 
	
	egen same_winpropR_pred_agg2 = max(same_winpropR_pred_agg)
	
	egen diff_winpropR_pred_agg2 = max(diff_winpropR_pred_agg)
	
	replace same_winpropR_pred = same_winpropR_pred_agg2 if judge_name == "Total"

	replace diff_winpropR_pred = diff_winpropR_pred_agg2 if judge_name == "Total"
	
	drop same_winpropR_pred_*

	
	
	
	* Gen significance categories
	
	egen pval_agg2 = max(pval_agg)
	replace pval = pval_agg2 if judge_name == "Total"
	drop pval_*
		// fill in for the total observation
		
	gen     sig = 1 if pval >= .1
	replace sig = 2 if pval <  .1 
	replace sig = 3 if pval <  .05
	
	
	
	
	* Gen observation categories  
	
	sum obs, detail
	
	gen     obgroup = .
	replace obgroup = 1 if obs > 150  // 150 - 719
	replace obgroup = 2 if obs < 150 // 75 - 149
	replace obgroup = 3 if obs < 75 // 10  - 74
	replace obgroup = 4 if judge_name=="Total"
	
	
	
	* Data for panel analysis
	
	preserve
	
	keep judge_name coeffs sig 
	
	gen sigj = sig>1 & coeffs>0 // judges that exhibit significant in-group bias
	
	keep judge_n sigj
	
	duplicates drop judge_name, force
	
	cd "$data"
	save sigj, replace // use this for the panel analysis, below
	cd "$outputs"

	restore



				
	* Restructure the data
	
	preserve

	keep pval obs same_winpropR diff_winpropR judge_name sig obgroup judge_maj_fem same_winpropR_pred diff_winpropR_pred

	duplicates drop judge_name, force

	drop judge_n




	* Graph, predicted values

	twoway (function y=x, lc(black) lp(dash)) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==1 & obgroup==1, m(circle) msiz(vlarge) mfc(white%80) mlc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==1 & obgroup==2, m(circle) msiz(medium) mfc(white%80) mlc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==1 & obgroup==3, m(circle) msiz(vsmall) mfc(white%80) mlc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==1 & obgroup==1, m(circle) msiz(vlarge) mfc(white%80) mlc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==4 & obgroup==4, m(circle) msiz(vlarge) mc(gray%80) ) /// this is just for the lengend
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==2 & obgroup==2, m(circle) msiz(medium) mc(gray%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==2 & obgroup==3, m(circle) msiz(vsmall) mc(gray%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==3 & obgroup==1, m(circle) msiz(vlarge) mc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==3 & obgroup==2, m(circle) msiz(medium) mc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==3 & obgroup==3, m(circle) msiz(vsmall) mc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==3 & obgroup==4, m(plus) msiz(ehuge) mc(black) ), /// (qfit same_winpropR_pred diff_winpropR_pred, lc(black) lp(solid)) , ///
		   legend (colfirst order(2 "150-719 obs."     ///
						  3 "75-149 obs."     ///
						  4 "10-74 obs."      ///
						  1 "45-degree line" ///
						  5 "Insignificant" ///
						  6 "p < 0.1"      ///
						  9 "p < 0.05"   ///
						  12 "Aggregate"  )) /// 12 "Best fit line")) ///
		   xtitle("Predicted def. win prop., judge-def. different gender", size(small)) ///
		   ytitle("Predicted def. win prop., judge-def. same gender", size(vsmall))
    
	graph export coefplot_gend_resp_all_pred.png, replace
	
	
	
	
	*** Coeeficient plot
	
	restore 
	
	keep coeffs ses
	
	duplicates drop coeffs, force
	
	hist coeffs, xtitle("Coefficients") xla(-1(.2)1)
	
	graph export distplot_gender.png, replace
	
	summ ses // mean is .1731691
	
	summ coeffs // SD is .2224401 
		
	
	
	
*** Respondent ethn




	* Keep only single judge cases with judges identified

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	drop if missing(judge_name)
	
	
	
	
	* Drop judge dummies with insufficient observations
	
	drop if judge_resp_same==.
	
	foreach judge of varlist judge1-judge494 {
			sum `judge',  meanonly
			if r(mean)==0 {
			drop `judge'
			}
	}
	
	foreach judge of varlist judge2-judge494 {
			sum resp_win if `judge'==1,  meanonly
			if r(mean)==0 {
			drop `judge'
			}
	}
	
	foreach judge of varlist judge2-judge494 {
			sum resp_win if `judge'==1,  meanonly
			if r(mean)==1 {
			drop `judge'
			}
	}
	
	foreach judge of varlist judge2-judge494 {
			sum resp_win if `judge'==1,  meanonly
			if r(N)<10 {
			drop `judge'
			}
	}
	
	
	
	
	* Count # of judges included, for notes in the graph
	
	preserve
		
		foreach judge of varlist judge30-judge493 {
			replace `judge' = 1
		}
		
		egen jnum = rowtotal(judge30-judge493)
		tab jnum
		
	restore
	
	


	* Observation per judges variable

	bysort  judge_name: gen obs  = [_N]
	label variable 		obs "Observations for each judge"

	
	

	* Individual judge regressions to create vars for pvalue predicted outcome

	gen 		   pval = .
	label variable pval "P values of individual judge regressions"
	
	gen coeffs=.
	
	gen ses=.

	foreach judge of varlist judge30-judge493 {

		quietly reghdfe resp_win judge_resp_same if `judge'==1, absorb(court_year)
		
		replace pval =  2*ttail(e(df_r), abs(_b[judge_resp_same]/_se[judge_resp_same]))    ///
		   if `judge' == 1
		   
		predict yhat_`judge' if `judge' == 1
		
		replace coeffs=_b[judge_resp_same] if `judge'==1
		
		replace ses=_se[judge_resp_same] if `judge'==1

			   
		}
		
	gen yhat = .
	
	foreach yhat of varlist yhat_j* {

			replace yhat = `yhat' if yhat==.
	
		}

		
	drop if pval==. // a few judges had omitted coefficients
	
	
	
	
	* Aggregate judge regression
		
	reghdfe resp_win judge_resp_same, absorb(court_year)
	
	predict yhat_agg 
	gen     pval_agg =  2*ttail(e(df_r), abs(_b[judge_resp_same]/_se[judge_resp_same]))
	
	
	
	
	* Create predicted outcomes vars
	
	gen same_winpropR_p = yhat if judge_resp_same == 1
	
	gen diff_winpropR_p = yhat if judge_resp_same == 0
	
	bysort judgeFE: egen same_winpropR_pred = max(same_winpropR_p)
	
	bysort judgeFE: egen diff_winpropR_pred = max(diff_winpropR_p)
		
	label variable same_winpropR_pred "Win proportion for respondents when judge and resp. are same gender"

	label variable diff_winpropR_pred "Win proportion for respondents when judge and resp. are different genders"
	
	gen same_winpropR_pred_agg = yhat_agg if judge_resp_same == 1
	gen diff_winpropR_pred_agg = yhat_agg if judge_resp_same == 0 // for the total observation

	
	
		
	* Add an observation to capture totals
	
	local    plus1 = _N + 1
	set obs `plus1'
	
	replace judge_name = "Total" if missing(judge_name)
	
	
	
	
	* Fill in props for new total obsevation 
	
	egen same_winpropR_pred_agg2 = max(same_winpropR_pred_agg)
	
	egen diff_winpropR_pred_agg2 = max(diff_winpropR_pred_agg)
	
	replace same_winpropR_pred = same_winpropR_pred_agg2 if judge_name == "Total"

	replace diff_winpropR_pred = diff_winpropR_pred_agg2 if judge_name == "Total"
	
	drop same_winpropR_pred_*

	
	
	
	* Gen significance categories
	
	egen pval_agg2 = max(pval_agg)
	replace pval = pval_agg2 if judge_name == "Total"
	drop pval_*
		// fill in for the total observation
		
	gen     sig = 1 if pval >= .1
	replace sig = 2 if pval <  .1 
	replace sig = 3 if pval <  .05
	
	
	
	
	* Gen observation categories  
	
	sum obs, detail
	
	gen     obgroup = .
	replace obgroup = 1 if obs > 150  // 150 - 681
	replace obgroup = 2 if obs < 150 // 75 - 149
	replace obgroup = 3 if obs < 75 // 10  - 74
	replace obgroup = 4 if judge_name=="Total"
	
	
	
	
	* data for panel analysis
	
	preserve
	
	keep judge_name coeffs sig 
	
	gen sigje = sig>1 & coeffs>0 // judges that exhibit significant in-group bias
	
	keep judge_n sigje
	
	duplicates drop judge_name, force
	
	cd "$data"
	save sigje, replace // use this for the panel analysis, below
	cd "$outputs"

	restore



				
	* Restructure the data
	
	preserve

	keep pval obs same_winpropR diff_winpropR judge_name sig obgroup judge_maj_fem same_winpropR_pred diff_winpropR_pred

	duplicates drop judge_name, force

	drop judge_n




	* Graph, predicted values

	twoway (function y=x, lc(black) lp(dash)) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==1 & obgroup==1, m(circle) msiz(vlarge) mfc(white%80) mlc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==1 & obgroup==2, m(circle) msiz(medium) mfc(white%80) mlc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==1 & obgroup==3, m(circle) msiz(vsmall) mfc(white%80) mlc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==1 & obgroup==1, m(circle) msiz(vlarge) mfc(white%80) mlc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==4 & obgroup==4, m(circle) msiz(vlarge) mc(gray%80) ) /// this is just for the lengend
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==2 & obgroup==2, m(circle) msiz(medium) mc(gray%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==2 & obgroup==3, m(circle) msiz(vsmall) mc(gray%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==3 & obgroup==1, m(circle) msiz(vlarge) mc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==3 & obgroup==2, m(circle) msiz(medium) mc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==3 & obgroup==3, m(circle) msiz(vsmall) mc(black%80) ) ///
		   (scatter same_winpropR_pred diff_winpropR_pred if sig==3 & obgroup==4, m(plus) msiz(ehuge) mc(black) ), /// (qfit same_winpropR_pred diff_winpropR_pred, lc(black) lp(solid)) , ///
		   legend (colfirst order(2 "150-681 obs."     ///
						  3 "75-149 obs."     ///
						  4 "10-74 obs."      ///
						  1 "45-degree line" ///
						  5 "Insignificant" ///
						  6 "p < 0.1"      ///
						  9 "p < 0.05"   ///
						  12 "Aggregate"  )) /// 12 "Best fit line")) ///
		   xtitle("Predicted def. win prop., judge-def. different ethnicity", size(small)) ///
		   ytitle("Predicted def. win prop., judge-def. same ethnicity", size(vsmall))
    
	graph export coefplot_ethn_resp_all_pred.png, replace
	
	
	
	
	*** Coeeficient plot
	
	restore 
	
	keep coeffs ses
	
	duplicates drop coeffs, force
	
	hist coeffs, xtitle("Coefficients") xla(-1(.2)1)
	
	graph export distplot_ethn.png, replace
	
	summ coeffs //
	
	summ ses //
	
	
	
	
*** Panel effects, gender

cd "$data"
use data_clean_constructed, replace

merge m:1 judge_name using sigj

cd "$outputs"

tab judge_name if sigj==1 // see significantly in-group biased judges
drop sigj
gen sigj = strpos(judges, "daniel kiio musinga") == 1 | ///
		   strpos(judges, "david kipyegomen kemei") == 1 | ///
		   strpos(judges, "hilary kiplagat chemitei") == 1 | ///
		   strpos(judges, "jemutai grace kemei") == 1 | ///
		   strpos(judges, "jessie wanjiku lessit") == 1 | ///
		   strpos(judges, "john walter onyango otieno") == 1 | ///
		   strpos(judges, "martha karambu koome") == 1 | ///
		   strpos(judges, "mohammed khadhar ibrahim") == 1 | ///
		   strpos(judges, "milton stephen asike makhandia") == 1 | ///
		   strpos(judges, "nelly awori matheka") == 1 | ///
		   strpos(judges, "nelson jorum  abuodha") == 1 | ///
		   strpos(judges, "philomena mbete mwilu") == 1 | ///
		   strpos(judges, "reuben nyambati nyakundi") == 1 | ///
		   strpos(judges, "samuel elikana ondari bosire") == 1  
		   				   
eststo clear

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem ///
	if num_j==1 & sigj==1 ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedi "Yes", replace
quietly estadd local fixedp "No", replace
quietly estadd ysumm

eststo: reghdfe resp_win  ///
	i.judge_maj_fem  ///
	i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem ///
	if num_j>1 & sigj==1 ,  ///
	absorb(court_year) cluster(judges)  
quietly estadd local fixedcy "Yes", replace 
quietly estadd local fixedi "No", replace
quietly estadd local fixedp "Yes", replace
quietly estadd ysumm

esttab using biased_judges.tex, replace label eqlabels(none) se ///
title(Results for significantly in-group gender biased judges, off and on panels)  ///
star(* 0.10 ** 0.05 *** 0.01)  ///
s(ymean fixedcy fixedi fixedp N, label("DV mean" "Court-year FE" "Individual decisions" "Panel decisions" "Observations")) ///
nonote addnote( ///
	"Sample is restricted to the 14 judges with significant gender in-group bias coefficients for defendants" ///
	"in individual regression Column 1 includes only cases where the judges ruled individually. Column 2" ///
	"includes only cases where they ruled on panels. Standard errors, in parentheses, are clustered at the" ///
	"judge level. All columns are based on a linear regression model. For specification details, see" ///
	"equations 3 and 4. Pla. = plaintiff, def. = defendant, maj. = majority.")  ///
	coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		  1.resp_maj_fem 				  "Def. maj. female" ///
		  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
	keep(1.judge_maj_fem  1.resp_maj_fem  1.judge_maj_fem#1.resp_maj_fem)  ///
	order (1.judge_maj_fem  1.resp_maj_fem  1.judge_maj_fem#1.resp_maj_fem) 
	
	
	
	


