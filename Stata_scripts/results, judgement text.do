*********************************************************************************
****************************** Judgement variables ******************************
*********************************************************************************




*** Split by resp win, G 



	* Full sample
	
	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	label variable citation_count				  "Num. citations"
	label variable cited_count					  "Times cited"
	label variable length_of_judgement			  "Words in judg."
	label variable laws_count					  "Num laws cited"

	eststo clear

	eststo: reghdfe citation_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store A1


	eststo: reghdfe cited_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store B1

	eststo: reghdfe laws_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd ysumm
estimates store C1

	eststo: reghdfe length_of_judgement  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store D1


	esttab using jvarsy_full.tex, replace label eqlabels(none) se ///
		title(Judgement text regressions, gender, full sample)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy  N, label("DV mean" "Court-year FE" "Observations"))  ////
		coefl(1.judge_maj_fem                 "Judge maj. female"  ///
			  1.resp_maj_fem 				  "Def. maj. female" ///
			  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
		keep(1.judge_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
		order(1.judge_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
		nonote addnote( ///
		"The regressions test whether in-group bias is associated with significantly different aspects of judges' written" ///
		"judgements. If in-group bias is associated with different characteristics for judgement texts, then we should" ///
		"see significant coefficients for the defendant-win sample but not the defendant-lose sample, the coefficients" ///
		"in the defendant-win sample should be larger than in the full sample. This table presents the full sample results." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression" ///
		"model. For specification details, see equation 6. Num. citations refers to the number of citations in the judgement." ///
		"Times cited refers to the number of times the case has been cited. Num. laws cited refers to the number of laws" ///
		"and and acts cited in the judgement. Words in judg. refers to the number of words in the written judgement." ///
		"Def. = defendant, maj. = majority, fem. = female.")
			
			
			
			
	* Resp win
	
	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	label variable citation_count				  "Num. citations"
	label variable cited_count					  "Times cited"
	label variable length_of_judgement			  "Words in judg."
	label variable laws_count					  "Num laws cited"
	
	keep if resp_win==1

	eststo clear

	eststo: reghdfe citation_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store A2

	eststo: reghdfe cited_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store B2

	eststo: reghdfe laws_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd ysumm
estimates store C2

eststo: reghdfe length_of_judgement  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store D2


	esttab using jvarsy_win.tex, replace label eqlabels(none) se ///
		title(Judgement text regressions, gender, defendant win)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy  N, label("DV mean" "Court-year FE" "Observations"))  ////
		coefl(1.judge_maj_fem                 "Judge maj. female"  ///
			  1.resp_maj_fem 				  "Def. maj. female" ///
			  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
		keep(1.judge_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
		order(1.judge_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
		nonote addnote( ///
		"The regressions test whether in-group bias is associated with significantly different aspects of judges' written" ///
		"judgements. If in-group bias is associated with different characteristics for judgement texts, then we should" ///
		"see significant coefficients for the defendant-win sample but not the defendant-lose sample, the coefficients" ///
		"in the defendant-win sample should be larger than in the full sample. This table presents the defendant-win sample results." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression" ///
		"model. For specification details, see equation 6. Num. citations refers to the number of citations in the judgement." ///
		"Times cited refers to the number of times the case has been cited. Num. laws cited refers to the number of laws" ///
		"and and acts cited in the judgement. Words in judg. refers to the number of words in the written judgement." ///
		"Def. = defendant, maj. = majority, fem. = female.")
			
			
			
			
	* Resp lose
	
	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	label variable citation_count				  "Num. citations"
	label variable cited_count					  "Times cited"
	label variable length_of_judgement			  "Words in judg."
	label variable laws_count					  "Num laws cited"
	
	keep if resp_win==0

	eststo clear
	
	eststo: reghdfe citation_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store A3

	eststo: reghdfe cited_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store B3

	eststo: reghdfe laws_count  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd ysumm
estimates store C3

	eststo: reghdfe length_of_judgement  ///
		i.judge_maj_fem  i.resp_maj_fem ///
		i.judge_maj_fem#i.resp_maj_fem ,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace   
quietly estadd ysumm
estimates store D3

	esttab using jvarsy_lose.tex, replace label eqlabels(none) se ///
		title(Judgement text regressions, gender, defendant lose)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy  N, label("DV mean" "Court-year FE" "Observations"))  ////
		coefl(1.judge_maj_fem                 "Judge maj. female"  ///
			  1.resp_maj_fem 				  "Def. maj. female" ///
			  1.judge_maj_fem#1.resp_maj_fem  "Judge maj. fem. X def. maj. fem." ) ///
		keep(1.judge_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
		order(1.judge_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.resp_maj_fem)  ///
		nonote addnote( ///
		"The regressions test whether in-group bias is associated with significantly different aspects of judges' written" ///
		"judgements. If in-group bias is associated with different characteristics for judgement texts, then we should" ///
		"see significant coefficients for the defendant-win sample but not the defendant-lose sample, the coefficients" ///
		"in the defendant-win sample should be larger than in the full sample. This table presents the defendant-lost sample results." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression" ///
		"model. For specification details, see equation 6. Num. citations refers to the number of citations in the judgement." ///
		"Times cited refers to the number of times the case has been cited. Num. laws cited refers to the number of laws" ///
		"and and acts cited in the judgement. Words in judg. refers to the number of words in the written judgement." ///
		"Def. = defendant, maj. = majority, fem. = female.")

		coefplot    (A1, label(Full sample)) (A2, label(Defendant win sample)) (A3, label(Defendant lose sample)), bylabel(Number of cases cited) ///
				||  (C1, label(Full sample)) (C2, label(Defendant win sample)) (C3, label(Defendant lose sample)), bylabel(Number of laws cited) ///
				||  (B1, label(Full sample)) (B2, label(Defendant win sample)) (B3, label(Defendant lose sample)), bylabel(Number of times cited) ///
				||  (D1, label(Full sample)) (D2, label(Defendant win sample)) (D3, label(Defendant lose sample)), bylabel(Word count) ///
				|| , keep(1.judge_maj_fem#1.resp_maj_fem) ///
		 			 coefl(1.judge_maj_fem#1.resp_maj_fem = " ") ///
					 drop(_cons) xline(0, lcolor(black)) byopts(xrescale)
		graph export coefs_text_gend.png, replace
			
			
			
			
*** Split by resp win, ethn



	* Full sample
	
	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	label variable citation_count				  "Num. citations"
	label variable cited_count					  "Times cited"
	label variable length_of_judgement			  "Words in judg."
	label variable laws_count					  "Num laws cited"

		eststo clear

	eststo: reghdfe citation_count  ///
		i.judge_resp_same ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store A1

	eststo: reghdfe cited_count  ///
		i.judge_resp_same,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store B1

	eststo: reghdfe laws_count  ///
		i.judge_resp_same,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd ysumm
estimates store C1

	eststo: reghdfe length_of_judgement  ///
	i.judge_resp_same,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store D1

	esttab using jvarsy_full_e.tex, replace label eqlabels(none) se ///
		title(Judgement text regressions, ethnicity, full sample)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy  N, label("DV mean" "Court-year FE" "Observations"))  ////
			keep(1.judge_resp_same) ///
		nonote addnote( ///
		"The regressions test whether in-group bias is associated with significantly different aspects of judges' written" ///
		"judgements. If in-group bias is associated with different characteristics for judgement texts, then we should" ///
		"see significant coefficients for the defendant-win sample but not the defendant-lose sample, the coefficients" ///
		"in the defendant-win sample should be larger than in the full sample. This table presents the full sample results." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression" ///
		"model. For specification details, see equation 6. Num. citations refers to the number of citations in the judgement." ///
		"Times cited refers to the number of times the case has been cited. Num. laws cited refers to the number of laws" ///
		"and and acts cited in the judgement. Words in judg. refers to the number of words in the written judgement.")
			
			
			
			
	* Resp win
	
	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	label variable citation_count				  "Num. citations"
	label variable cited_count					  "Times cited"
	label variable length_of_judgement			  "Words in judg."
	label variable laws_count					  "Num laws cited"
	
	keep if resp_win==1

	eststo clear

	eststo: reghdfe citation_count  ///
		i.judge_resp_same ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store A2

	eststo: reghdfe cited_count  ///
		i.judge_resp_same,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store B2

	eststo: reghdfe laws_count  ///
		i.judge_resp_same,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd ysumm
estimates store C2

	eststo: reghdfe length_of_judgement  ///
	i.judge_resp_same,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store D2


	esttab using jvarsy_win_e.tex, replace label eqlabels(none) se ///
		title(Judgement text regressions, ethnicity, defendant win)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy  N, label("DV mean" "Court-year FE" "Observations"))  ////
			keep(1.judge_resp_same) ///
		nonote addnote( ///
		"The regressions test whether in-group bias is associated with significantly different aspects of judges' written" ///
		"judgements. If in-group bias is associated with different characteristics for judgement texts, then we should" ///
		"see significant coefficients for the defendant-win sample but not the defendant-lose sample, the coefficients" ///
		"in the defendant-win sample should be larger than in the full sample. This table presents the defendant-win sample results." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression" ///
		"model. For specification details, see equation 6. Num. citations refers to the number of citations in the judgement." ///
		"Times cited refers to the number of times the case has been cited. Num. laws cited refers to the number of laws" ///
		"and and acts cited in the judgement. Words in judg. refers to the number of words in the written judgement.")
			
			
			
			
	* Resp lose
	
	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	label variable citation_count				  "Num. citations"
	label variable cited_count					  "Times cited"
	label variable length_of_judgement			  "Words in judg."
	label variable laws_count					  "Num laws cited"
	
	keep if resp_win==0

	eststo clear

	eststo: reghdfe citation_count  ///
		i.judge_resp_same ,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store A3

	eststo: reghdfe cited_count  ///
		i.judge_resp_same,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store B3

	eststo: reghdfe laws_count  ///
		i.judge_resp_same,  ///
		absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd ysumm
estimates store C3

	eststo: reghdfe length_of_judgement  ///
	i.judge_resp_same,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedcy "Yes", replace 
quietly estadd ysumm
estimates store D3

	esttab using jvarsy_lose_e.tex, replace label eqlabels(none) se ///
		title(Judgement text regressions, ethnicity, defendant lose)  ///
		star(* 0.10 ** 0.05 *** 0.01)  ///
		s(ymean fixedcy  N, label("DV mean" "Court-year FE" "Observations"))  ////
			keep(1.judge_resp_same) ///
		nonote addnote( ///
		"The regressions test whether in-group bias is associated with significantly different aspects of judges' written" ///
		"judgements. If in-group bias is associated with different characteristics for judgement texts, then we should" ///
		"see significant coefficients for the defendant-win sample but not the defendant-lose sample, the coefficients" ///
		"in the defendant-win sample should be larger than in the full sample. This table presents the defendant-lose sample results." ///
		"Standard errors, in parentheses, are clustered at the judge level. All columns are based on a linear regression" ///
		"model. For specification details, see equation 6. Num. citations refers to the number of citations in the judgement." ///
		"Times cited refers to the number of times the case has been cited. Num. laws cited refers to the number of laws" ///
		"and and acts cited in the judgement. Words in judg. refers to the number of words in the written judgement.")
			
			
					coefplot    (A1, label(Full sample)) (A2, label(Defendant win sample)) (A3, label(Defendant lose sample)), bylabel(Number of cases cited) ///
				||  (C1, label(Full sample)) (C2, label(Defendant win sample)) (C3, label(Defendant lose sample)), bylabel(Number of laws cited) ///
				||  (B1, label(Full sample)) (B2, label(Defendant win sample)) (B3, label(Defendant lose sample)), bylabel(Number of times cited) ///
				||  (D1, label(Full sample)) (D2, label(Defendant win sample)) (D3, label(Defendant lose sample)), bylabel(Word count) ///
				|| , keep(1.judge_resp_same) ///
		 			 coefl(1.judge_resp_same = " ") ///
					 drop(_cons) xline(0, lcolor(black)) byopts(xrescale)
		graph export coefs_text_ethn.png, replace

			
*** Split by resp win, joint

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

label variable citation_count				  "Num. citations"
label variable cited_count					  "Times cited"
label variable length_of_judgement			  "Words in judg."
label variable laws_count					  "Num laws cited"

keep if resp_win==1

eststo clear

eststo: reghdfe cited_count  ///
	i.judge_maj_fem  i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem ///
	i.judge_resp_same,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedo "No", replace
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd ysumm

eststo: reghdfe cited_count  ///
	i.judge_maj_fem  i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem ///
	i.judge_resp_same ///
	$controls_ethn  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedo "Yes", replace
	quietly estadd local fixedcy "Yes", replace
	quietly estadd ysumm

eststo: reghdfe length_of_judgement  ///
	i.judge_maj_fem  i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem ///
	i.judge_resp_same ,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedo "No", replace
	quietly estadd local fixedcy "Yes", replace 
	quietly estadd ysumm

eststo: reghdfe length_of_judgement  ///
	i.judge_maj_fem  i.resp_maj_fem ///
	i.judge_maj_fem#i.resp_maj_fem ///
	i.judge_resp_same ///
	$controls_ethn  ///
	$controls_other ,  ///
	absorb(court_year) cluster(judges) 
	quietly estadd local fixedo "Yes", replace
	quietly estadd local fixedcy "Yes", replace
quietly estadd ysumm

esttab using jvarsy_win_jount.tex, replace label eqlabels(none) se ///
	title(Judgement text regressions, additional controls, defendant win)  ///
	star(* 0.10 ** 0.05 *** 0.01)  ///
	s(ymean fixedcy fixedo N, label("DV mean" "Court-year FE" "Other controls" "Observations"))  ////
		coefl(1.judge_maj_fem                 "Judge maj. female"  ///
		1.resp_maj_fem 				          "Def. maj. female" ///
		1.judge_maj_fem#1.resp_maj_fem        "Judge maj. fem. X def. maj. fem." ) ///
		keep(1.judge_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.resp_maj_fem 1.judge_resp_same)  ///
		order(1.judge_maj_fem 1.resp_maj_fem 1.judge_maj_fem#1.resp_maj_fem 1.judge_resp_same)  ///
		nonote addnote( ///
		"The regressions test whether in-group bias is associated with significantly different aspects of judges' written" ///
		"judgements. Standard errors, in parentheses, are clustered at the judge level. Num. citations refers to the number" ///
		"of citations in the judgement. Times cited refers to the number of times the case has been cited. Num. laws cited" ///
		"refers to the number of laws and and acts cited in the judgement. Words in judg. refers to the number of words" ///
		"in the written judgement. Other controls include binary variables indicating whether a given ethnicity is the" ///
		"plurality, one for each ethnicity, for defendants, plaintiffs, and judges; case type dummies; a dummy for an" ///
		"appeal case; and variables for the numbers of defendants, plaintiffs, and judges. To prevent a loss of observations," ///
		"all categorical controls (such as case type) include a dummy that denotes if data is missing/unknown. Def. = defendant," ///
		"maj. = majority, fem. = female.")
		
		
		
