**************************************************************************
****************************** Descriptives ******************************
**************************************************************************




*** Cases over time

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

keep year 

gen one=1

collapse (sum) one, by(year)

twoway area one year, ///
xtitle("Year") xla(1975(5)2020 2020) ytitle("Number of cases") xsize(8) 

graph export cases_time.png, replace




*** Frequency bar charts




	* Majority ethnicity, props

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	keep majority_ethnicity_applicants ///
		 majority_ethnicity_respondents ///
		 majority_ethnicity_judges

	ren majority_ethnicity_applicants  majority_ethnicity_1
	ren majority_ethnicity_respondents majority_ethnicity_2
	ren majority_ethnicity_judges      majority_ethnicity_3
	
	egen tota = count(majority_ethnicity_1)
	egen totr = count(majority_ethnicity_2)
	egen totj = count(majority_ethnicity_3)

	gen n=[_n]

	reshape long majority_ethnicity_, i(n tot*) j(group)

	replace n=1
	collapse (sum) n, by(group maj tot*)
	
	gen	    prop = n/tota if group==1
	replace prop = n/totr if group==2
	replace prop = n/totj if group==3
	
	drop n tot*

	reshape wide prop, i(maj) j(group)

	label define ethn 1 "No plurality" ///
					  2 "Kalenjin" ///
					  3 "Kamba" ///
					  4 "Kikuyu" ///
					  5 "Kisii" ///
					  6 "Luhya" ///
					  7 "Luo" ///
					  8 "Masai" ///
					  9 "Meru" ///
					  10 "Mijikenda" ///
					  11 "Pokot" ///
					  12 "Somali" ///
					  13 "Turkana" 
	label values maj ethn

	drop if maj==.
	
	global tpop 47564 
	gen     popprop = 5580 / $tpop if maj==2
	replace popprop = 4604 / $tpop if maj==3
	replace popprop = 2781 / $tpop if maj==12
	replace popprop = 8149 / $tpop if maj==4
	replace popprop = 2703 / $tpop if maj==5
	replace popprop = 6824 / $tpop if maj==6
	replace popprop = 5067 / $tpop if maj==7
	replace popprop = 1190 / $tpop if maj==8
	replace popprop = 1976 / $tpop if maj==9
	replace popprop = 2489 / $tpop if maj==10
	replace popprop = 778 / $tpop if maj==11
	replace popprop = 1016 / $tpop if maj==13
	
	graph hbar prop1 prop2 prop3 popp, over(maj) ///
		ytitle("Proportion") l1title("Ethnicity") ///
		legend(order(1 "Plaintiff plurality, as a proportion of total cases" ///
					 2 "Defendant plurality, as a proportion of total cases" ///
					 3 "Judge plurality, as a proportion of total cases" ///
					 4 "Proportion of total population in Kenya") ///
					 size(vsmall) ///
					 rows(4) ) ///
					 ysize(10) xsize(7)
		
	graph export ethnc_groups_prop.png, replace
	
	
	
	
	* Majority ethnicity, masked
	
	label define mask 1 "No plurality" ///
					  2 "Ethnicity 1" ///
					  3 "Ethnicity 2" ///
					  4 "Ethnicity 3" ///
					  5 "Ethnicity 4" ///
					  6 "Ethnicity 5" ///
					  7 "Ethnicity 6" ///
					  8 "Ethnicity 7" ///
					  9 "Ethnicity 8" ///
					  10 "Ethnicity 9" ///
					  11 "Ethnicity 10" ///
					  12 "Ethnicity 11" ///
					  13 "Ethnicity 12" 
	label values maj mask
	
	graph hbar prop1 prop2 prop3 popp, over(maj) ///
		ytitle("Proportion") l1title("Ethnicity") ///
		legend(order(1 "Plaintiff plurality, as a proportion of total cases" ///
					 2 "Defendant plurality, as a proportion of total cases" ///
					 3 "Judge plurality, as a proportion of total cases" ///
					 4 "Proportion of total population in Kenya") ///
					 size(vsmall) ///
					 rows(4) ) ///
					 ysize(10) xsize(7)
		
	graph export ethnc_groups_prop_masked.png, replace



	
	* Majority gender

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	keep judge_maj_fem ///
		 resp_maj_fem ///
		 appl_maj_fem

	ren judge_maj_fem majority_g1
	ren resp_maj_fem  majority_g2
	ren appl_maj_fem  majority_g3

	gen n=[_n]

	reshape long majority_g, i(n) j(group)
	replace n=1

	collapse (sum) n, by(group maj)

	reshape wide n, i(maj) j(group)

	label define gend 0 "Male" 1 "Female" 
	label values maj gend

	drop if maj==.

	graph hbar n3 n2 n1, over(maj) ///
		ytitle("Number of cases") ///
		l1title("Majority gender") ///
		legend(order(1 "Plaintiffs" 2 "Defendants" 3 "Judges") ///
		size(small)) ///
		ysize(10) xsize(7)
		
	graph export gend_groups.png, replace




*** Area chart, cases by in-group over time




	* Ethnicity

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	drop if majority_ethnicity_respondents==. | majority_ethnicity_applicants==. | majority_ethnicity_judges==.

	keep year ethnic_ingroup

	gen same = (eth==2)
	gen jr   = (eth==4)
	gen ja   = (eth==1)
	gen diff = (eth==3)

	collapse (sum) same jr ja diff, by(year)

	gen sum2 = same + jr
	gen sum3 = same + jr + ja
	gen sum4 = same + jr + ja + diff

	twoway area same year || ///
	rarea same sum2 year ||  ///
	rarea sum2 sum3 year ||   ///
	rarea sum3 sum4 year,      ///
	legend(order(4 "Judge-pla. different, judge-def. different" 3 "Judge-pla. same, judge-def. different" 2 "Judge-pla. different, judge-def. same" 1 "Judge-pla. same, judge-def. same")  ///
	pos(3) col(1) size(small))  ///
	xtitle("Year")xla(1975(5)2020 2020) ytitle("Number of cases") xsize(8) 

	graph export ethn_groups_time.png, replace

	
	
	
	* Gender

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	keep year gender_ingroup

	gen same = (gen==2)
	gen jr   = (gen==4)
	gen ja   = (gen==1)
	gen diff = (gen==3)

	collapse (sum) same jr ja diff, by(year)

	gen sum2 = same + jr
	gen sum3 = same + jr + ja
	gen sum4 = same + jr + ja + diff

	twoway area same year ||  ///
	rarea same sum2 year ||  ///
	rarea sum2 sum3 year ||   ///
	rarea sum3 sum4 year,      ///
	legend(order(4 "Judge-pla. different, judge-def. different" 3 "Judge-pla. same, judge-def. different" 2 "Judge-pla. different, judge-def. same" 1 "Judge-pla. same, judge-def. same")  ///
	pos(3) col(1) size(small))  ///
	xtitle("Year")xla(1975(5)2020 2020) ytitle("Number of cases") xsize(8) 

	graph export gender_groups_time.png, replace




*** Gender proprtions 




	* over time

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	keep year judge_maj_fem appl_maj_fem resp_maj_fem

	collapse (mean) judge_maj_fem appl_maj_fem resp_maj_fem, by(year)
	
	foreach maj of varlist judge_maj_fem appl_maj_fem resp_maj_fem {
			gen `maj'_avgs = (`maj'[_n] + `maj'[_n-1] + `maj'[_n-2] + `maj'[_n-3] + `maj'[_n-4]) / 5
	}
	
	drop judge_maj_fem appl_maj_fem resp_maj_fem
	
	drop if year <1980

	twoway (line judge_maj_fem year,lwidth(medthick) lcolor(black) lpattern(solid)) ///
		   (line appl_maj_fem year,lwidth(medthick) lcolor(black) lpattern(dash)) ///
		   (line resp_maj_fem year,lwidth(medthick) lcolor(black) lpattern(dot)),   ///
		   legend(order(1 "Judges" 2 "Plaintiffs" 3 "Defendants")) ///
		   xtitle("Year")xla(1980(5)2020 2020) ytitle("Proportion majority female, 5-year averages") xsize(8) ///
		   
		   
	graph export gender_prop_time.png, replace
	
	
	
	
	* by case type 
	
	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	keep appl_maj_fem judge_maj_fem resp_maj_fem case_type 
	
	keep if (!missing(appl_maj_fem) | !missing(resp_maj_fem) | !missing(judge_maj_fem)) & !missing(case_type)
	
	replace case = 999 if case == 3 | case == 4 | case == 5 | case == 7 | case == 8 | case == 12 | case == 13
		// make fewer case groups
							 
	collapse (mean) propfemA=appl propfemR=resp propfemJ=judge ///
			   (sd) sd_propfemA=appl sd_propfemR=resp sd_propfemJ=judge ///
			(count) nA=appl nR=resp nJ=judge, by(case)
						
	reshape long propfem, i(case) j(role) string
	
	gen     sd = sd_propfemA if role=="A"
	replace sd = sd_propfemR if role=="R"
	replace sd = sd_propfemJ if role=="J"

	gen     n = nA if role=="A"
	replace n = nR if role=="R"
	replace n = nJ if role=="J"
	
	drop sd_* nA nR nJ
	
	generate hiprop = propfem + invttail(n-1,0.025)*(sd / sqrt(n))
	generate loprop = propfem - invttail(n-1,0.025)*(sd / sqrt(n))
		// errors
		
	sort case
	gen group = [_n]
		
	replace group = group + 1 if case==9
	replace group = group + 2 if case==10
	replace group = group + 3 if case==11
	replace group = group + 4 if case==14
	replace group = group + 5 if case==999
		// group spacing
		
	replace loprop=0 if loprop<0 // so graph axis won't go below 0
	
	encode role, gen(rolen)
	drop   role
	
	replace group = group+1 if role==2
	replace group = group-1 if role==3
	sort group
		// move labels around for graphing

	graph twoway  ///
	(bar prop group if role==1, hor )  ///
	(bar prop group if role==3, hor) 	///
	(bar prop group if role==2, hor) 	///
	(rcap hip lop group, hor lcolor("100 100 100") ), ///
	xline(.5, lcolor(black) lpattern(dash)) ///
	legend(row(2) order( 3 "Judges"    2 "Defendants" 1 "Plaintiffs" 4 "95% CI" ) ) ///
	ylabel( 2 "Civil" 6 "Labor relations" 10 "Env. and land" 14 "Family" ///
			18 "Succession" 22 "Other", noticks angle(0))  ///
	xtitle("Proportion of females") ytitle("") ///
	text (7 .468 "Gender parity"", size(.27cm))
	
	graph export gender_prop_case.png, replace 




*** Variable summary tables, means and no means

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

tab case_type if case_type!=., gen(case) 

label variable case1 "Case type: civil"
label variable case2 "Case type: tax"
label variable case3 "Case type: human rights"
label variable case4 "Case type: judicial review"
label variable case5 "Case type: divorce"
label variable case6 "Case type: election"
label variable case7 "Case type: labor relations"
label variable case8 "Case type: environment and land"
label variable case9 "Case type: family"
label variable case10 "Case type: industrial"
label variable case11 "Case type: miscellaneous"
label variable case12 "Case type: succession"

eststo clear

estpost summ resp_win ///
			 judge_maj_fem appl_maj_fem resp_maj_fem  ///
			 judge_app_same judge_resp_same ///
			 appeal appealed reversed ///
			 num_respondents num_applicants num_judges ///
			 median_slant median_slant_goodvbad   ///
			 case1-case12 ///
			 citation_count cited_count laws_count length_of_judgement  
			
esttab using varsumm.tex, replace ///
	   cells("count mean sd min max") label /// 
	   noobs nonumber ///
	   title(Summary of main variables) 
	   
eststo clear

estpost summ cid year court_year ///
			 majority_ethnicity_applicants ///
			 majority_ethnicity_respondents ///
			 majority_ethnicity_judges 
			 

esttab using varsumm2.tex, replace ///
	   cells("count") label /// 
	   noobs nonumber ///
	   title(Summary of main variables, count only) 
	   
	   
	   
	   
*** Frequency of court case types

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

eststo clear

estpost tab court_t, label

esttab using ctype.tex, replace ///
	nogaps nonotes nonum noobs ///
	mtitles("Frequency") ///
	varlabels(`e(labels)') /// 
	title(Frequency of court types in the dataset) ///
	addnote("Other includes Election Petition in Magistrate Courts," ///
			"the Judges and Magistrates Vetting Board, Kadhis Courts," ///
			"and the National Environment Tribunal")
 

	
	
	
	
	
	
	
