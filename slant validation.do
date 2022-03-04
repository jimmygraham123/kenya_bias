clear
cd "$data"
use "df_name_validation.dta"
xpose, clear v
ren _varname name
drop if name=="judge_name"
drop if name=="index"
* manually assigned gender_bool to 10 names and made this dataset - /Users/shashanksingh/Desktop/GloVe/slant/final_data.dta
clear
cd "$data"
use "final_data.dta"
mat def A=J(163,6,.)
local row = 1
pause off
foreach var of varlist v* {
    qui reg gender_bool `var' if name!="tokens"
    mat def A[`row',1]=_b[`var']
    mat def A[`row',2]=_se[`var']
    mat def A[`row',3]=_b[`var']/_se[`var']
    mat def A[`row',4]=(2 * ttail(e(df_r), abs(_b[`var']/_se[`var'])))
    mat def A[`row',5]=`e(N)'
    qui su `var' if name=="tokens"
    mat def A[`row',6]=`r(mean)'
    local ++row
    pause
    }
    
clear
svmat A
ren A1 beta
ren A2 standard_error
ren A3 tstat
ren A4 pvalue
ren A5 N
ren A6 tokens
sort tstat
g n=_n
sort beta
g m=_n
**************
* TSTAT GRAPH*
**************
 
cumul tstat if tokens<500000, gen(cumul1) 
cumul tstat if tokens>=500000&tokens<1000000, gen(cumul2) 
cumul tstat if tokens>=1000000&tokens<1500000, gen(cumul3) 
cumul tstat if tokens>=1500000, gen(cumul4) 
sort tstat
tw  line cumul1 tstat, lc(blue) lp(dot) xline(1.96, lc(pink)) || line cumul2 tstat, lc(blue) lp(shortdash) || line cumul3 tstat, lc(blue) lp(longdash) || line cumul4 tstat, lc(blue) xlabel(-5(2.5)10, grid valuel glc(gs12) glp(dot)) ylabel(0(0.25)1, grid valuel glc(gs12) glp(dot)) legend(label(1 "{&le} 500K") label(2 "{&ge} 500K and <1M") label(3 "{&ge} 1M and < 1,5M") label(4 "{&ge} 1,5M") ring(0) pos(11) cols(1) region(lc(white))) graphregion(color(white)) bgcolor(white) xtitle("T-statistic") ytitle("Empirical Cumulative Distribution")
 
cd "$outputs"

*tw     line cumul1 tstat, lc(black) lp(dot) xline(1.96, lc(grey)) || line cumul2 tstat, lc(black) lp(shortdash) || line cumul3 tstat, lc(black) lp(longdash) || line cumul4 tstat, lc(black) xlabel(-5(2.5)10, grid valuel glc(gs12) glp(dot)) ylabel(0(0.25)1, grid valuel glc(gs12) glp(dot)) legend(label(1 "{&le} 500K") label(2 "{&ge} 500K and <1M") label(3 "{&ge} 1M and < 1,5M") label(4 "{&ge} 1,5M") ring(0) pos(11) cols(1) region(lc(white)) title("Number of Tokens", color(black))) graphregion(color(white)) bgcolor(white) xtitle("T-statistic") ytitle("Empirical Cumulative Distribution")
tw  line cumul1 tstat, lc(black) lp(dot) xline(1.96, lc(grey)) || line cumul2 tstat, lc(black) lp(shortdash) || line cumul3 tstat, lc(black) lp(longdash) || line cumul4 tstat, lc(black) xlabel(-5(2.5)10, grid valuel glc(gs12) glp(dot)) ylabel(0(0.25)1, grid valuel glc(gs12) glp(dot)) legend(label(1 "{&le} 500K") label(2 "{&ge} 500K and <1M") label(3 "{&ge} 1M and < 1,5M") label(4 "{&ge} 1,5M") ring(0) pos(11) cols(1)  title("Number of Tokens", color(black))) graphregion(color(white)) bgcolor(white) xtitle("T-statistic") ytitle("Empirical Cumulative Distribution") note("*Vertical line denotes T-Statistic = 1.96, for p < 0.05")
    
graph export tokens.png, replace

