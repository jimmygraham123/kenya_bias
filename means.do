*******************************************************************
****************************** Means ******************************
*******************************************************************




*** Ethnicity 




	* 1 

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	collapse (mean) meanwin=resp_win (sd) sdwin=resp_win (count) n=resp_win, by(ethnic_ingroup)

	generate hiwin = meanwin + invttail(n-1,0.025)*(sdwin / sqrt(n))
	generate lowin = meanwin - invttail(n-1,0.025)*(sdwin / sqrt(n))
	
	keep if eth==1 | eth==2

	graph twoway  ///
	(bar meanwin ethnic if eth==1, color(black) barw(.8))  ///
	(bar meanwin ethnic if eth==2, color(black) barw(.8))  ///
	(rcap hiwin lowin ethnic, lcolor(gray)), legend(off) ///
	xlabel(1 "Judge-pla. same, judge-def. different" 2 "Judge-pla. same, judge-def. same", ///
	labsize(small)) xtitle("Similarities/differences in majority ethnicity") ytitle("Defendant win proportion") ///
	yscale(range(.4 .53)) ylabel(.4 (.02) .53)

	graph export eth_means1.png, replace



		
	* 2

	cd "$data"
	use data_clean_constructed, replace
	cd "$outputs"

	collapse (mean) meanwin=resp_win (sd) sdwin=resp_win (count) n=resp_win, by(ethnic_ingroup)

	generate hiwin = meanwin + invttail(n-1,0.025)*(sdwin / sqrt(n))
	generate lowin = meanwin - invttail(n-1,0.025)*(sdwin / sqrt(n))
	
	keep if eth==3 | eth==4

	graph twoway  ///
	(bar meanwin ethnic if eth==3, color(black) barw(.8))  ///
	(bar meanwin ethnic if eth==4, color(black) barw(.8))  ///
	(rcap hiwin lowin ethnic, lcolor(gray)), legend(off) ///
	xlabel(3 "Judge-pla. different, judge-def. different" 4 "Judge-pla. different, judge-def. same", ////
	labsize(small) ) xtitle("Similarities/differences in majority ethnicity") ytitle("Defendant win proportion") ///
	yscale(range(.4 .53)) ylabel(.4 (.02) .53)

	graph export eth_means2.png, replace




*** Gender resp

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

collapse (mean) meanwin=resp_win (sd) sdwin=resp_win (count) n=resp_win, by(judge_maj_fem resp_maj_fem)

generate hiwin = meanwin + invttail(n-1,0.025)*(sdwin / sqrt(n))
generate lowin = meanwin - invttail(n-1,0.025)*(sdwin / sqrt(n))

drop if resp_maj==.

gen group = [_n]
replace group=group+1 if judge_maj_fem==1
drop if judge_maj_fem==.

graph twoway  ///
(bar meanwin group if resp_maj_fem==1)  ///
(bar meanwin group if resp_maj_fem==0)  ///
(rcap hiwin lowin group) ,  ///
legend(row(1) order(2 "Def. maj. male" 1 "Def. maj. female" 3 "95% CI") )  ///
xlabel( 1.5 "Male" 4.5 "Female", noticks)  ///
xtitle("Judge maj. gender") ytitle("Defendants win proportion") ///
yscale(range(.36 .48)) ylabel(.36 (.02) .48)


graph export Gresp_means.png, replace




*** Gender appl

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

collapse (mean) meanwin=resp_win (sd) sdwin=resp_win (count) n=resp_win, by(judge_maj_fem appl_maj_fem)

generate hiwin = meanwin + invttail(n-1,0.025)*(sdwin / sqrt(n))
generate lowin = meanwin - invttail(n-1,0.025)*(sdwin / sqrt(n))

drop if appl_maj==.

gen group = [_n]
replace group=group+1 if judge_maj_fem==1
drop if judge_maj_fem==.

graph twoway  ///
(bar meanwin group if appl_maj_fem==1)  ///
(bar meanwin group if appl_maj_fem==0)  ///
(rcap hiwin lowin group) ,  ///
legend(row(1) order(2 "Pla. maj. male" 1 "Pla. maj. female" 3 "95% CI") )  ///
xlabel( 1.5 "Male" 4.5 "Female", noticks)  ///
xtitle("Judge maj. gender") ytitle("Defendant win proportion") ///
yscale(range(.36 .48)) ylabel(.36 (.02) .48)


graph export Gappl_means.png, replace



*** 8 gender groups

cd "$data"
use data_clean_constructed, replace
cd "$outputs"

collapse (mean) meanwin=resp_win (sd) sdwin=resp_win (count) n=resp_win, by(judge_maj_fem appl_maj_fem resp_maj_fem)

generate hiwin = meanwin + invttail(n-1,0.025)*(sdwin / sqrt(n))
generate lowin = meanwin - invttail(n-1,0.025)*(sdwin / sqrt(n))

drop if appl_maj==. | resp_maj==. | judge_maj_fem==.


gen group = [_n]
replace group=group+1 if judge_maj_fem==0 & appl_maj_fem==1 
replace group=group+2 if judge_maj_fem==1 & appl_maj_fem==0
replace group=group+3 if judge_maj_fem==1 & appl_maj_fem==1

graph twoway  ///
(bar meanwin group if resp_maj_fem==1)  ///
(bar meanwin group if resp_maj_fem==0)  ///
(rcap hiwin lowin group) ,  ///
legend(row(1) order(2 "Def. maj. male" 1 "Def. maj. female" 3 "95% CI") )  ///
xlabel( 1.5 "Male-male" 4.5 "Male-female" 7.5 "Female-male" 10.5"Female-female", noticks)  ///
xtitle("Judge-plaintiff maj. gender") ytitle("Defendant win proportion") ///
yscale(range(.36 .52)) ylabel(.36 (.02) .52)


graph export Gappl_means.png, replace



