********************************************************************
****************************** Master ******************************
********************************************************************




*** Path globals

global project "/Users/macswell/Dropbox/Research_ongoing/kenya_regressions/Analysis" // path to Github repository 

global data "$project/Stata_inputs" // path to data repository with IND_KEN_V11.csv, metadata_merged_v15.xslx, EPR-2019.csv, df_name_validation.dta, final_data.dta, and judge_slant_measures_5words.dta

global scripts "$project/Stata_scripts" // path to folder with Stata scripts

global outputs "$project/Stata_outputs" // path to folder with outputs (and the Lyx document, if applicable)




*** clean_construction

cd "$scripts"

do "clean_construction"




*** descriptives

cd "$scripts"

do "descriptives"




*** rando checks

cd "$scripts"

do "rando checks"




*** means

cd "$scripts"

do "means"




*** regression results




	* main gender 

	cd "$scripts"

	do "results, main gender"
	
	
	
	
	* slant
	
	cd "$scripts"

	do "results, slant"
	
	

	
	* main ethnicity
	
	cd "$scripts"

	do "results, main ethn"




	* individual judges

	cd "$scripts"

	do "results, ind judge"




	* gender-ethn combo

	cd "$scripts"

	do "results, gender_ethn combo"
	
	
	
	
	* judgement text vars 
	
	cd "$scripts"

	do "results, judgement text"
	
	
	
	
	* appeals and reversals 
	
	cd "$scripts"

	do "results, appeals and reversals"

	
	
	

*** Slant validation

cd "$scripts"

do "slant validation"


