********************************************************************
****************************** Master ******************************
********************************************************************




*** Path global

global project "/Users/macswell/Dropbox/kenya_regressions/ethnicity"




*** clean_construction

cd "$project/_dos and scripts/dos"

do "clean_construction"




*** descriptives

cd "$project/_dos and scripts/dos"

do "descriptives"




*** rando checks

cd "$project/_dos and scripts/dos"

do "rando checks"




*** means

cd "$project/_dos and scripts/dos"

do "means"




*** reg results




	* main gender 

	cd "$project/_dos and scripts/dos"

	do "results, main gender"
	
	
	
	
	* panel gender
	
	cd "$project/_dos and scripts/dos"

	do "results, gender panel"
	
	
	
	
	* slant
	
	cd "$project/_dos and scripts/dos"

	do "results, slant"
	
	

	
	* main ethnicity
	
	cd "$project/_dos and scripts/dos"

	do "results, main ethn"




	* individual judges

	cd "$project/_dos and scripts/dos"

	do "results, ind judge"




	* hetero effects

	cd "$project/_dos and scripts/dos"

	do "results, hetero effects"




	* gender-ethn combo

	cd "$project/_dos and scripts/dos"

	do "results, gender_ethn combo"
	
	
	

	* woman court

	cd "$project/_dos and scripts/dos"

	do "results, women court"

	























