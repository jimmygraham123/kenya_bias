*****************************************************************************************
****************************** Load data and set directory ******************************
*****************************************************************************************




*** Load data and set scheme

cd "$data"

import delimited "IND_KEN_V12.csv", varnames(1) case(lower) clear 




*** Set directory for outputs scheme

cd "$outputs"

set scheme aspenBW7





*********************************************************************************
****************************** Additional cleaning ******************************
*********************************************************************************





*** Keep what you need

keep case_id judges court delivery_year delivery_month ///
	 is_win_final_0_50_thresh ///
	 applicant_majority_gender_api respondent_majority_gender_api bench_gender ///
	 num_respondents num_applicants num_judges ///
	 is_appealed is_appeal decision_reversed_50_thresh new_case_type court_division ///
	 is_appealed is_appeal decision_reversed_50_thresh new_case_type court_division ///
	 num_female_judges num_male_judges num_male_applicants_api num_female_applicants_api num_male_respondents_api num_female_respondents_api  ///
	 majority_ethnicity_applicants majority_ethnicity_respondents majority_ethnicity_judges ///
	 median_slant median_slant_goodvbad ///
	 respondent_name applicant_name ///
	 citation_count length_of_judgement judgement_citation_count laws_count new_time_to_disposition ///
	 num_meru_ethnicity_judges num_kisii_ethnicity_judges num_kalenjin_ethnicity_judges num_kamba_ethnicity_judges num_luo_ethnicity_judges num_turkana_ethnicity_judges num_mijikenda_ethnicity_judges num_luhya_ethnicity_judges num_kikuyu_ethnicity_judges num_somali_ethnicity_judges num_masai_ethnicity_judges num_pokot_ethnicity_judges num_unk_ethnicity_judges  ///
	 num_meru_ethnicity_respondents num_kisii_ethnicity_respondents num_kalenjin_eth_respondents num_kamba_ethnicity_respondents num_luo_ethnicity_respondents num_turkana_eth_respondents num_mijikenda_eth_respondents num_luhya_ethnicity_respondents num_kikuyu_ethnicity_respondents num_somali_ethnicity_respondents num_masai_ethnicity_respondents num_pokot_ethnicity_respondents num_unk_ethnicity_respondents   ///
	 num_meru_ethnicity_applicants num_kisii_ethnicity_applicants num_kalenjin_eth_applicants num_kamba_ethnicity_applicants num_luo_ethnicity_applicants num_turkana_ethnicity_applicants num_mijikenda_eth_applicants num_luhya_ethnicity_applicants num_kikuyu_ethnicity_applicants num_somali_ethnicity_applicants num_masai_ethnicity_applicants num_pokot_ethnicity_applicants num_unk_ethnicity_applicants  

   
	 
*** Rename 

ren delivery_year           	year
ren delivery_m           	    month
ren is_appeal                   appeal
ren is_appealed              	appealed
ren is_win_final_0_50_thresh 	appl_win
ren bench_gender			 	judge_majority_gender
ren judgement_citation_count 	cited_count
ren new_time_to_disposition  	time_to_disposition
ren decision_reversed_50_thresh reversed

gen c = case_id
drop case_id
ren c case_id // to convert from strL to str#




*** Label values

foreach x of varlist majority* {
	replace `x'= "No clear majority" if `x'=="NO CLEAR MAJORITY"
	}
	
foreach x of varlist majority_ethnicity_applicants majority_ethnicity_respondents majority_ethnicity_judges  {
	replace `x'= "No plurality" if `x'=="No clear majority"
	}
	
	
	
	
*** Encoding




	* Case type

	encode new_case_type, gen(case_type)
	drop   new_case_type




	* Ethnicity 

	gen mea = 1 if majority_ethnicity_applicants =="No plurality" 
	replace mea = 2 if majority_ethnicity_applicants =="kalenjin" 
	replace mea = 3 if majority_ethnicity_applicants =="kamba"
	replace mea = 4 if majority_ethnicity_applicants =="kikuyu" 
	replace mea = 5 if majority_ethnicity_applicants =="kisii" 
	replace mea = 6 if majority_ethnicity_applicants =="luhya" 
	replace mea = 7 if majority_ethnicity_applicants =="luo"
	replace mea = 8 if majority_ethnicity_applicants =="masai"
	replace mea = 9 if majority_ethnicity_applicants =="meru"
	replace mea = 10 if majority_ethnicity_applicants =="mijikenda"
	replace mea = 11 if majority_ethnicity_applicants =="pokot"
	replace mea = 12 if majority_ethnicity_applicants =="somali"
	replace mea = 13 if majority_ethnicity_applicants =="turkana"
	replace mea = . if majority_ethnicity_applicants =="unk"

	gen mer = 1 if majority_ethnicity_respondents =="No plurality"
	replace mer = 2 if majority_ethnicity_respondents =="kalenjin"
	replace mer = 3 if majority_ethnicity_respondents =="kamba"
	replace mer = 4 if majority_ethnicity_respondents =="kikuyu"
	replace mer = 5 if majority_ethnicity_respondents =="kisii"
	replace mer = 6 if majority_ethnicity_respondents =="luhya"
	replace mer = 7 if majority_ethnicity_respondents =="luo"
	replace mer = 8 if majority_ethnicity_respondents =="masai"
	replace mer = 9 if majority_ethnicity_respondents =="meru"
	replace mer = 10 if majority_ethnicity_respondents =="mijikenda"
	replace mer = 11 if majority_ethnicity_respondents =="pokot"
	replace mer = 12 if majority_ethnicity_respondents =="somali"
	replace mer = 13 if majority_ethnicity_respondents =="turkana"
	replace mer = . if majority_ethnicity_respondents =="unk"

	gen mej = 1 if majority_ethnicity_judges =="No plurality"
	replace mej = 2 if majority_ethnicity_judges =="kalenjin"
	replace mej = 3 if majority_ethnicity_judges =="kamba"
	replace mej = 4 if majority_ethnicity_judges =="kikuyu"
	replace mej = 5 if majority_ethnicity_judges =="kisii"
	replace mej = 6 if majority_ethnicity_judges =="luhya"
	replace mej = 7 if majority_ethnicity_judges =="luo"
	replace mej = 8 if majority_ethnicity_judges =="masai"
	replace mej = 9 if majority_ethnicity_judges =="meru"
	replace mej = 10 if majority_ethnicity_judges =="mijikenda";
	replace mej = 11 if majority_ethnicity_judges =="pokot"
	replace mej = 12 if majority_ethnicity_judges =="somali"
	replace mej = 13 if majority_ethnicity_judges =="turkana"
	replace mej = . if majority_ethnicity_judges =="unk" 

	labmask mej, values(majority_ethnicity_judges) 
	labmask mer, values(majority_ethnicity_respondents) 
	labmask mea, values(majority_ethnicity_applicants) 

	drop majority_ethnicity_judges ///
		 majority_ethnicity_respondents ///
		 majority_ethnicity_applicants

	ren mej majority_ethnicity_judges 
	ren mer majority_ethnicity_respondents
	ren mea majority_ethnicity_applicants
	
	
	
	
*** Label variables

label variable appl_win 					  "Pla. win"
label variable num_resp					      "Number of defendants"
label variable num_jud 						  "Number of judges"
label variable num_ap					      "Number of plaintiffs"
label variable appealed 					  "This case is appealed"
label variable appeal 						  "This is an appeal case"
label variable judges 						  "Judge name(s)"
label variable year 						  "Year of delivery"
label variable case_type 					  "Type of case"
label variable case_id 				          "Case ID"
label variable majority_ethnicity_applicants  "Plurality ethnicity of plaintiffs"
label variable majority_ethnicity_respondents "Plurality ethnicity of defendants"
label variable majority_ethnicity_judges   	  "Plurality ethnicity of judges"
label variable median_slant   	 			  "Median slant, career v family"
label variable median_slant_goodvbad		  "Median slant, good v bad"
label variable court_d   	 			 	  "Court division"
label variable num_female_judges			  "Number of female judges"
label variable num_male_judges			 	  "Number of male judges"
label variable num_female_a			 		  "Number of female plaintiffs"
label variable num_female_r					  "Number of female defendants"
label variable num_male_a			 		  "Number of male plaintiffs"
label variable num_male_r					  "Number of male defendants"
label variable judge_majority_gender		  "Judge majority gender"
label variable applicant_majority_gender 	  "Plaintiff majority gender"
label variable respondent_majority_gender	  "Defendant majority gender"
label variable citation_count				  "Number of cases cited in judgement"
label variable cited_count					  "Times judgement cited"
label variable length_of_judgement			  "Words in judgement"
label variable laws_count					  "Laws cited in judgement"
label variable time_to_disposition		 	  "Time to disposition"
label variable reversed		 	 			  "Decision is reversed in the appeal"
label variable court						  "Court name"

    


*** Additional cleaning




	* drop cases without necessary info 
	
	drop if missing(court)
	drop if missing(appl_win)
	



	* Sparse case types to miscellaneous

	replace case_type = 13 if case_type==1
	replace case_type = 13 if case_type==15	
	
	
	
	
	* Drop additional non-human litigants	
	
	foreach name of varlist respondent_name applicant_name {
		drop if strpos(`name',"c/a")>0 | ///
				strpos(`name',"C/A")>0 | ///
				strpos(`name',"t/a")>0 |  ///
				strpos(`name',"T/A")>0 | ///
				strpos(`name',"club")>0 | ///
				strpos(`name',"Club")>0 | ///
				strpos(`name',"trust")>0 | ///
				strpos(`name',"Trust")>0 | ///
				strpos(`name',"resort")>0 | ///
				strpos(`name',"Resort")>0 | ///
				strpos(`name',"sport")>0 | ///
				strpos(`name',"Sport")>0 | ///
				strpos(`name',"processors")>0 | ///
				strpos(`name',"Processors")>0 | ///
				strpos(`name',"pharmacy")>0 | ///
				strpos(`name',"Pharmacy")>0 | ///
				strpos(`name',"institute")>0 | ///
				strpos(`name',"Institute")>0 | ///
				strpos(`name',"research")>0 | ///
				strpos(`name',"Research")>0 | ///
				strpos(`name',"management")>0 | ///
				strpos(`name',"Management")>0 | ///
				strpos(`name',"restaurant")>0 | ///
				strpos(`name',"Restaurant")>0 |  ///
				strpos(`name',"movement")>0 | ///
				strpos(`name',"Movement")>0 | ///
				strpos(`name',"democra")>0 | ///
				strpos(`name',"Democra")>0 | ///
				strpos(`name',"department")>0 | ///
				strpos(`name',"Department")>0 | ///
				strpos(`name',"affair")>0 | ///
				strpos(`name',"Affair")>0 | ///
				strpos(`name',"World")>0 | ///
				strpos(`name',"world")>0 | ///
				strpos(`name',"enterprise")>0 | ///
				strpos(`name',"Enterprise")>0 | ///
				strpos(`name',"women")>0 | ///
				strpos(`name',"Women")>0 | ///
				strpos(`name',"refugee")>0 | ///
				strpos(`name',"Refugee")>0 | ///
				strpos(`name',"offic")>0 | ///
				strpos(`name',"Offic")>0 | ///
				strpos(`name',"Manufact")>0 | ///
				strpos(`name',"manufact")>0 | ///
				strpos(`name',"County")>0 | ///
				strpos(`name',"county")>0 | ///
				strpos(`name',"assembly")>0 | ///
				strpos(`name',"Assembly")>0 | ///
				strpos(`name',"government")>0 | ///
				strpos(`name',"Government")>0 | ///
				strpos(`name',"africa")>0 | ///
				strpos(`name',"Africa")>0 | ///
				strpos(`name',"health")>0 | ///
				strpos(`name',"Health")>0 | ///
				strpos(`name',"centre")>0 | ///
				strpos(`name',"Centre")>0 | ///
				strpos(`name',"consortium")>0 | ///
				strpos(`name',"Consortium")>0 | ///
				(strpos(`name',"kenya")>0  & !strpos(`name',"kenyat")>0) | ///
			    (strpos(`name',"Kenya")>0  & !strpos(`name',"Kenyat")>0) | ///
				strpos(`name',"church")>0 | ///
				strpos(`name',"Church")>0 | ///
				strpos(`name',"district")>0 | ///
				strpos(`name',"District")>0 | ///
				strpos(`name',"Registered")>0 | ///
				strpos(`name',"registered")>0 | ///
				strpos(`name',"development")>0 | ///
				strpos(`name',"Development")>0 | ///
				strpos(`name',"incorporated")>0 | ///
				strpos(`name',"Incorporated")>0 | ///
				strpos(`name',"deutsche")>0 | ///
				strpos(`name',"Deutsche")>0 | ///
				strpos(`name',"Financ")>0 | ///
				strpos(`name',"financ")>0 | ///
				strpos(`name',"children")>0 | ///
				strpos(`name',"Children")>0 | ///
				strpos(`name',"welfare")>0 | ///
				strpos(`name',"Welfare")>0 | ///
				strpos(`name',"Project")>0 | ///
				strpos(`name',"project")>0 | ///
				strpos(`name',"medical")>0 | ///
				strpos(`name',"Medical")>0 | ///
				strpos(`name',"committee")>0 | ///
				strpos(`name',"Committee")>0 | ///
				strpos(`name',"Forum")>0 | ///
				strpos(`name',"forum")>0 | ///
				strpos(`name',"diocese")>0 | ///
				strpos(`name',"Diocese")>0 | ///
				strpos(`name',"secretary")>0 | ///
				strpos(`name',"Secretary")>0 | ///
				strpos(`name',"clerk")>0 | ///
				strpos(`name',"Clerk")>0 | ///
				strpos(`name',"w/o")>0 | ///
				strpos(`name',"Force")>0 | ///
				strpos(`name',"force")>0 | ///
				strpos(`name',"societ")>0 | ///
				strpos(`name',"Societ")>0 | ///
				strpos(`name',"Defence")>0 | ///
				strpos(`name',"defence")>0 | ///
				strpos(`name',"parlour")>0 | ///
				strpos(`name',"Parlour")>0 | ///
				strpos(`name',"fellowship")>0 | ///
				strpos(`name',"Fellowship")>0 | ///
				strpos(`name',"Institute")>0 | ///
				strpos(`name',"institute")>0 | ///
				strpos(`name',"other")>0 | ///
				strpos(`name',"Other")>0 | ///
				strpos(`name',"Group")>0 | ///
				strpos(`name',"group")>0 | ///
				strpos(`name',"trad")>0 | ///
				strpos(`name',"Trad")>0 | ///
				strpos(`name',"commission")>0 | ///
				strpos(`name',"Commission")>0 | ///
				strpos(`name',"electoral")>0 | ///
				strpos(`name',"Electoral")>0 | ///
				strpos(`name',"regist")>0 | ///
				strpos(`name',"Regist")>0 | ///
				strpos(`name',"Team")>0 | ///
				strpos(`name',"team")>0 | ///
				strpos(`name',"corp")>0 | ///
				strpos(`name',"Corp")>0 | ///
				strpos(`name',"Coprs")>0 | ///
				strpos(`name',"private")>0 | ///
				strpos(`name',"Private")>0 | ///
				strpos(`name',"technic")>0 | ///
				strpos(`name',"Technic")>0 | ///
				strpos(`name',"simply perfect")>0 | ///
				strpos(`name',"factory")>0 | ///
				strpos(`name',"Factory")>0 | ///
				strpos(`name',"consult")>0 | ///
				strpos(`name',"Consult")>0 | ///
				strpos(`name',"party")>0 | ///
				strpos(`name',"Party")>0 | ///
				strpos(`name',"Contract")>0 | ///
				strpos(`name',"contract")>0 | ///
				strpos(`name',"print")>0 | ///
				strpos(`name',"Print")>0 | ///
				strpos(`name',"agricult")>0 | ///
				strpos(`name',"Agricult")>0 | ///
				strpos(`name',"mainten")>0 | ///
				strpos(`name',"Mainten")>0 | ///
				strpos(`name',"farm")>0 | ///
				strpos(`name',"Farm")>0 | ///
				strpos(`name',"sacco")>0 | ///
				strpos(`name',"Sacco")>0 | ///
				strpos(`name',"federation")>0 | ///
				strpos(`name',"Federation")>0 | ///
				strpos(`name',"empl")>0 | ///
				strpos(`name',"Empl")>0 | ///
				strpos(`name',"bureau")>0 | ///
				strpos(`name',"army")>0 | ///
				strpos(`name',"power")>0 | ///
				strpos(`name',"lodge")>0 | ///
				strpos(`name',"staff")>0 | ///
				strpos(`name',"constr")>0 | ///
				strpos(`name',"internat")>0 | ///
				strpos(`name',"organi")>0 | ///
				strpos(`name',"guide")>0 | ///
				strpos(`name',"airw")>0 | ///
				strpos(`name',"united")>0 | ///
				strpos(`name',"electr")>0 | ///
				strpos(`name',"brew")>0 | ///
				strpos(`name',"produc")>0 | ///
				strpos(`name',"livestock")>0 | ///
				strpos(`name',"college")>0 | ///
				strpos(`name',"univ")>0 | ///
				strpos(`name',"planter")>0 | ///
				strpos(`name',"action")>0 | ///
				strpos(`name',"telkom")>0 | ///
				strpos(`name',"postal")>0 | ///
				strpos(`name',"cultur")>0 | ///
				strpos(`name',"chancellor")>0 | ///
				strpos(`name',"sugar")>0 | ///
				strpos(`name',"Bureau")>0 | ///
				strpos(`name',"Army")>0 | ///
				strpos(`name',"Power")>0 | ///
				strpos(`name',"Lodge")>0 | ///
				strpos(`name',"Staff")>0 | ///
				strpos(`name',"Constr")>0 | ///
				strpos(`name',"Internat")>0 | ///
				strpos(`name',"Organi")>0 | ///
				strpos(`name',"Guide")>0 | ///
				strpos(`name',"Airw")>0 | ///
				strpos(`name',"United")>0 | ///
				strpos(`name',"Electr")>0 | ///
				strpos(`name',"Brew")>0 | ///
				strpos(`name',"Produc")>0 | ///
				strpos(`name',"Livestock")>0 | ///
				strpos(`name',"College")>0 | ///
				strpos(`name',"Univ")>0 | ///
				strpos(`name',"Planter")>0 | ///
				strpos(`name',"Action")>0 | ///
				strpos(`name',"Telkom")>0 | ///
				strpos(`name',"Postal")>0 | ///
				strpos(`name',"Cultur")>0 | ///
				strpos(`name',"Chancellor")>0 | ///
				strpos(`name',"Sugar")>0 | ///
				strpos(`name',"cross")>0  | ///
				strpos(`name',"Cross")>0  | ///
				strpos(`name',"scheme")>0  | ///
				strpos(`name',"Scheme")>0  | ///
				strpos(`name',"Easy Coach")>0  | ///
				strpos(`name',"express")>0  | ///
				strpos(`name',"Express")>0  | ///
				strpos(`name',"carrier")>0  | ///
				strpos(`name',"Carrier")>0  | ///
				strpos(`name',"Center")>0  | ///
				strpos(`name',"center")>0  | ///
				strpos(`name',"owner")>0  | ///
				strpos(`name',"Owner")>0  | ///
				strpos(`name',"Aidspan")>0  | ///
				strpos(`name',"aidspan")>0  | ///
				strpos(`name',"Build")>0  | ///
				strpos(`name',"build")>0  | ///
				strpos(`name',"repub")>0  | ///
				strpos(`name',"Repub")>0  | ///
				strpos(`name',"prosec")>0  | ///
				strpos(`name',"Prosec")>0  | ///
				strpos(`name',"repul")>0  | ///
				strpos(`name',"Repul")>0  
		}
		
		
		
		
	* Drop obs with num app/resp = 1 that actually have multiple, which were not caught by code 
	
	drop if respondent_name=="1 the driver of kwr 893 2. samuel mwangi kingori" | ///
			respondent_name=="1. gide fissah ale goitom ) 2. deheb behrane abed )" | ///
			respondent_name=="1. peter lunani ongoma2. mariko ayieko ongoma" | ///
			respondent_name=="1. philip juma ojijo ) 2. george adha adongo )" | ///
			respondent_name=="1. purity makambi 2. max makabmi" | ///
			respondent_name=="1. thuku gachiri 2. ibrahim wachira mathu 3. fidelis mueke nguli" | ///
			respondent_name=="1. zakayo malakwen ngeleche 2. david k. monyingisi 3. daniel morgo" | ///
			respondent_name=="1.claus kruger 2.rosemary nyakinyua" | ///
			respondent_name=="1.david samoei 2.elisha busienei" | ///
			respondent_name=="1.paul mutuku 2.kyama paul mutuku‚Ä¶.." | ///
			respondent_name=="1.rama lugu 2.suleiman moni" | ///
			respondent_name=="1.said s. karama 2.ahmed s. karama" 
			
	drop if applicant_name== "1. george roine titus) 2. daniel ndichu )" | ///
			applicant_name== "1. philip wamacho chemiati) 2. paul wepukhulu chemiati) vsnathan wekesa nakitare" | ///
			applicant_name== "1.abdalla s. karama 2.fathiya s. karama 3.swabir s. karama 4.munaa s. karama 5.ghubesha s. karama" | ///
			applicant_name== "1.omar said awadh 2.fahima said awadh" | ///
			applicant_name== "1. philip wamacho chemiati) 2. paul wepukhulu chemiati) vsnathan wekesa nakitare  "


			
	
***********************************************************************************
****************************** Constructing the data ******************************
***********************************************************************************




*** Respondent (defendant) DV

gen 			resp_win = (appl_win==0)
label variable  resp_win "Def. win"
 

 
 
 
*** Court ids and court-year FE

egen 		   cid = group(court)
label variable cid "Court ID"

egen 		   court_year = group(cid year)
label variable court_year "Court-year FE"




*** Gender dummies

gen            judge_maj_fem = 1 if judge_majority_gender=="female"
replace 	   judge_maj_fem = 0 if judge_majority_gender=="male"
label variable judge_maj_fem "Judge maj. female"

gen 		   appl_maj_fem = 1 if applicant_majority_gender =="female"
replace 	   appl_maj_fem = 0 if applicant_majority_gender=="male"
label variable appl_maj_fem "Pla. maj. female"

gen			   resp_maj_fem = 1 if respondent_majority_gender=="female"
replace 	   resp_maj_fem = 0 if respondent_majority_gender=="male"
label variable resp_maj_fem "Def. maj. female"

	// gender variables missing if gender unknown or no clear majority
	// this allows for the dummy interaction specification




*** Ethnicity dummies 

gen judge_maj_kalenjin=(majority_ethnicity_j==2) if majority_ethnicity_j!=.
label variable judge_maj_kalenjin "Judge plur. Kalenjin"

gen judge_maj_kamba=(majority_ethnicity_j==3) if majority_ethnicity_j!=.
label variable judge_maj_kamba "Judge plur. Kamba"

gen judge_maj_kikuyu=(majority_ethnicity_j==4)  if majority_ethnicity_j!=.
label variable judge_maj_kikuyu "Judge plur. Kikuyu"

gen judge_maj_kisii=(majority_ethnicity_j==5)  if majority_ethnicity_j!=.
label variable judge_maj_kisii "Judge plur. Kisii"

gen judge_maj_luhya=(majority_ethnicity_j==6)  if majority_ethnicity_j!=.
label variable judge_maj_luhya "Judge plur. Luhya"

gen judge_maj_luo=(majority_ethnicity_j==7)  if majority_ethnicity_j!=.
label variable judge_maj_luo "Judge plur. Luo"

gen judge_maj_masai=(majority_ethnicity_j==8)  if majority_ethnicity_j!=.
label variable judge_maj_masai "Judge plur. Masai"

gen judge_maj_meru=(majority_ethnicity_j==9)  if majority_ethnicity_j!=.
label variable judge_maj_meru "Judge plur. Meru"

gen judge_maj_mijikenda=(majority_ethnicity_j==10)  if majority_ethnicity_j!=.
label variable judge_maj_mijikenda "Judge plur. Mijikenda"

gen judge_maj_pokot=(majority_ethnicity_j==11)  if majority_ethnicity_j!=.
label variable judge_maj_pokot "Judge plur. Pokot"

gen judge_maj_somali=(majority_ethnicity_j==12)  if majority_ethnicity_j!=.
label variable judge_maj_somali "Judge plur. Somali"

gen judge_maj_turkana=(majority_ethnicity_j==13)  if majority_ethnicity_j!=.
label variable judge_maj_turkana "Judge plur. Turkana"


gen appl_maj_kalenjin=(majority_ethnicity_a==2) if majority_ethnicity_a!=.
gen appl_maj_kamba=(majority_ethnicity_a==3) if majority_ethnicity_a!=.
gen appl_maj_kikuyu=(majority_ethnicity_a==4) if majority_ethnicity_a!=.
gen appl_maj_kisii=(majority_ethnicity_a==5) if majority_ethnicity_a!=.
gen appl_maj_luhya=(majority_ethnicity_a==6) if majority_ethnicity_a!=.
gen appl_maj_luo=(majority_ethnicity_a==7) if majority_ethnicity_a!=.
gen appl_maj_masai=(majority_ethnicity_a==8) if majority_ethnicity_a!=.
gen appl_maj_meru=(majority_ethnicity_a==9) if majority_ethnicity_a!=.
gen appl_maj_mijikenda=(majority_ethnicity_a==10) if majority_ethnicity_a!=.
gen appl_maj_pokot=(majority_ethnicity_a==11) if majority_ethnicity_a!=.
gen appl_maj_somali=(majority_ethnicity_a==12) if majority_ethnicity_a!=.
gen appl_maj_turkana=(majority_ethnicity_a==13) if majority_ethnicity_a!=.

gen resp_maj_kalenjin=(majority_ethnicity_r==2) if majority_ethnicity_r!=.
gen resp_maj_kamba=(majority_ethnicity_r==3) if majority_ethnicity_r!=.
gen resp_maj_kikuyu=(majority_ethnicity_r==4) if majority_ethnicity_r!=.
gen resp_maj_kisii=(majority_ethnicity_r==5) if majority_ethnicity_r!=.
gen resp_maj_luhya=(majority_ethnicity_r==6) if majority_ethnicity_r!=.
gen resp_maj_luo=(majority_ethnicity_r==7) if majority_ethnicity_r!=.
gen resp_maj_masai=(majority_ethnicity_r==8) if majority_ethnicity_r!=.
gen resp_maj_meru=(majority_ethnicity_r==9) if majority_ethnicity_r!=.
gen resp_maj_mijikenda=(majority_ethnicity_r==10) if majority_ethnicity_r!=.
gen resp_maj_pokot=(majority_ethnicity_r==11) if majority_ethnicity_r!=.
gen resp_maj_somali=(majority_ethnicity_r==12) if majority_ethnicity_r!=.
gen resp_maj_turkana=(majority_ethnicity_r==13) if majority_ethnicity_r!=.




*** Judge in-group dummies, for resp and appl




	* Ethnicity

	gen 			judge_app_same=(majority_ethnicity_judges==majority_ethnicity_a) ///
									 if majority_ethnicity_judges!=. & majority_ethnicity_a!=.
	replace		    judge_app_same=0 if majority_ethnicity_judges==1
	label variable  judge_app_same "Judge-plaintiff same ethnicity"


	gen 			judge_resp_same=(majority_ethnicity_judges==majority_ethnicity_r) ///
									  if majority_ethnicity_judges!=. & majority_ethnicity_r!=.
	replace 		judge_resp_same=0 if majority_ethnicity_judges==1
	label variable  judge_resp_same "Judge-defendant same ethnicity"

		// Note that "No plurality" is included in these variables 
		// (=0 if either group is "No plurality")
		// unknown is missing
		
		
		
		
	* Gender

	gen 			judge_app_same_G=(judge_maj_fem==appl_maj_fem) if judge_maj_fem!=. & appl_maj_fem!=.
	label variable  judge_app_same_G "Judge-plaintiff same gender"

	gen 			judge_resp_same_G=(judge_maj_fem==resp_maj_fem) if judge_maj_fem!=. & resp_maj_fem!=.
	label variable  judge_resp_same_G "Judge-defendant same gender"

		// "No clear majority" and unknown is missing 




*** In-group categories



	* Ethnicity

	gen ethnic_ingroup = 2 if ///
		majority_ethnicity_judges==majority_ethnicity_respondents & ///
		majority_ethnicity_judges==majority_ethnicity_applicants

	replace ethnic_ingroup = 4 if ///
		majority_ethnicity_judges==majority_ethnicity_respondents & ///
		majority_ethnicity_judges!= majority_ethnicity_applicants

	replace ethnic_ingroup = 1 if ///
		majority_ethnicity_judges==majority_ethnicity_applicants & ///
		majority_ethnicity_judges!= majority_ethnicity_respondents

	replace ethnic_ingroup = 3 if ///
		majority_ethnicity_judges!=majority_ethnicity_applicants & ///
		majority_ethnicity_judges!= majority_ethnicity_respondents
	replace ethnic_ingroup = 3 if majority_ethnicity_judges==1 
	
	replace ethnic_ingroup = . if majority_ethnicity_judges==. | ///
								  majority_ethnicity_respondents==. | ///
								  majority_ethnicity_applicants==.

	label define group 2 "all same" ///
					   4 "judge-def same" ///
					   1 "judge-pla same" ///
					   3 "judge different"
	label value     ethnic_ingroup group 
	label variable  ethnic_ingroup "Ethnic in-group categories"

		// Note that "No plurality" is included in these variables 
		// (as "judge different" if the judge is "No plurality")




	* Gender

	gen gender_ingroup = 2 if ///
		judge_maj_fem==resp_maj_fem & ///
		judge_maj_fem==appl_maj_fem

	replace gender_ingroup = 4 if ///
		judge_maj_fem==resp_maj_fem & ///
		judge_maj_fem!= appl_maj_fem

	replace gender_ingroup = 1 if ///
		judge_maj_fem==appl_maj_fem & ///
		judge_maj_fem!= resp_maj_fem

	replace gender_ingroup = 3 if ///
		judge_maj_fem!=appl_maj_fem & ///
		judge_maj_fem!= resp_maj_fem

	replace gender_ingroup = . if judge_maj_fem==. | ///
								  appl_maj_fem==. | ///
								  resp_maj_fem==.

	label value 	gender_ingroup group 
	label variable  gender_ingroup "Gender in-group categories"

		// Note that "no clear majority" is missing for gender


		

*** Individual judges dummies




	* Single judge name variable
	
	gen    		   judge_name = judges if num_j==1
	label variable judge_name "Judge names, individual judges only"


	

	* Judge dummies

	tab judge_name , generate(judge)

		/// Missing judge_names go to missing for each judge var 




*** Win proportion, same and different, respondent and applicant



	* Respondents

	bysort judge_name: egen same_winpropT = mean(resp_win) if judge_resp_same_G==1
	bysort judge_name: egen diff_winpropT = mean(resp_win) if judge_resp_same_G==0

	bysort judge_name: egen same_winpropR = max(same_winpropT) if judge_resp_same_G!=.
	bysort judge_name: egen diff_winpropR = max(diff_winpropT) if judge_resp_same_G!=.
	
	drop same_winpropT diff_winpropT

	label variable same_winpropR "Win proportion for defendants when judge and def. are same gender"
	label variable diff_winpropR "Win proportion for defendants when judge and def. are diff. gender"



	* Applicants

	bysort judge_name: egen same_winpropT = mean(appl_win) if judge_app_same_G==1
	bysort judge_name: egen diff_winpropT = mean(appl_win) if judge_app_same_G==0

	bysort judge_name: egen same_winpropA = max(same_winpropT) if judge_app_same_G!=.
	bysort judge_name: egen diff_winpropA = max(diff_winpropT) if judge_app_same_G!=.

	drop same_winpropT diff_winpropT
	
	label variable same_winpropA "Win proportion for plaintiffs when judge and pla. are same gender"
	label variable diff_winpropA "Win proportion for plaintiffs when judge and pla. are diff. gender"
	
	
	
	
*** Adjust name vars

ren respondent_name respondents
label variable      respondents  			  "Defendant names"

ren applicant_name applicants
label variable    applicants				  "Plaintiff names"
 
gen            respondent_name = respondents if num_r==1
label variable respondent_name  			  "Defendant name, single def. only"

gen            applicant_name = applicants if num_a==1
label variable applicant_name  				  "Plaintiff name, single pla. only"	
	
	
	
	
*** Interactions
	
gen 			appl_fem_x_slant = appl_maj_fem*median_slant
label variable  appl_fem_x_slant "Interaction, slant x pla_fem"

gen 			resp_fem_x_slant = resp_maj_fem*median_slant
label variable  resp_fem_x_slant "Interaction, slant x def_fem"

gen 			appl_fem_x_slantgb = appl_maj_fem*median_slant_goodvbad
label variable  appl_fem_x_slantgb "Interaction, slant good vs bad x pla_fem"

gen 			resp_fem_x_slantgb = resp_maj_fem*median_slant_goodvbad
label variable  resp_fem_x_slantgb "Interaction, slant good vs bad x def_fem"




*** Judge panel gender variables




	* Complete 

	gen jpanel = .
	replace jpanel = 1 if num_j==1 & num_female_judges==1
	replace jpanel = 2 if num_j==1 & num_female_judges==0 & num_male_judges==1
	replace jpanel = 3 if num_j==2 
	replace jpanel = 4 if num_j==3 & num_female_judges==3
	replace jpanel = 5 if num_j==3 & num_female_judges==2 & num_male_judges==1
	replace jpanel = 6 if num_j==3 & num_female_judges==1 & num_male_judges==2
	replace jpanel = 7 if num_j==3 & num_female_judges==0 & num_male_judges==3
	replace jpanel = 8 if num_j==4
	replace jpanel = 9 if num_j==5
	replace jpanel = 10 if num_j==9


	label define jpanel 1 "1 judge: 1 fem., 0 male" ///
						2 "1 judge: 0 fem., 1 male" ///
						3 "2 judges" ///
						4 "3 judges: 3 fem., 0 male" ///
						5 "3 judges: 2 fem., 1 male" ///
						6 "3 judges: 1 fem., 2 male" ///
						7 "3 judges: 0 fem., 3 male" ///
						8 "4 judges" ///
						9 "5 judges" ///
						10 "9 judges"
	label value    jpanel jpanel
	label variable jpanel "Gender composition of judge panel"




	* Revised

	gen jpanel2 = .
	replace jpanel2 = 1 if num_j==1 & num_female_judges==1
	replace jpanel2 = 2 if num_j==1 & num_female_judges==0 & num_male_judges==1
	replace jpanel2 = 3 if num_j==3 & num_female_judges==2 & num_male_judges==1
	replace jpanel2 = 4 if num_j==3 & num_female_judges==1 & num_male_judges==2
	replace jpanel2 = 5 if num_j==3 & num_female_judges==0 & num_male_judges==3

	label define jpanel2 1 "1 fem., 0 male" ///
						 2 "0 fem., 1 male" ///
						 3 "2 fem., 1 male" ///
						 4 "1 fem., 2 male" ///
						 5 "0 fem., 3 male" 
	label value    jpanel2 jpanel2
	
	label variable jpanel2 "Gender composition of judge panel, revised"





*** Court types

encode court, gen(court2)

gen 		court_type=""
replace		court_type = "Court of appeal" if inlist(court2, 1,2,3,4,5,6,7,8,9)
replace		court_type = "Employment and labor relations" if inlist(court2, 11,12,13,14,15,16,17,18,19,20)
replace		court_type = "Environment and land court" if inlist(court2, 21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49)
replace		court_type = "High court" if inlist(court2, 50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90)
replace		court_type = "Supreme court" if inlist(court2, 97)

replace		court_type = "Other" if inlist(court2, 10,91,92,93,94,95,96)
	//Election Petition in Magistrate Courts 
	//Judges and Magistrates Vetting Board
	//Kadhis court
	//National Environment Tribunal
	
drop court court2

label variable court_type "Court type"




*** Judge fixed effect 

egen 			judgeFE = group(judge_name)
replace 		judgeFE=. if judge_name==""
label variable  judgeFE "FE for judges, single-judge cases"





*** Create unknown category for controls

gen control_majority_ethnicity_a = majority_ethnicity_applicants
replace control_majority_ethnicity_a=99 if control_majority_ethnicity_a==.
	
gen control_majority_ethnicity_r = majority_ethnicity_respondents
replace control_majority_ethnicity_r=99 if control_majority_ethnicity_r==.

gen control_majority_ethnicity_j = majority_ethnicity_judges
replace control_majority_ethnicity_j=99 if control_majority_ethnicity_j

gen control_case_type = case_type
replace control_case_type=99 if control_case_type==.

gen control_appeal = appeal
replace control_appeal=99 if control_appeal==.

gen control_judge_maj_fem = judge_maj_fem
replace control_judge_maj_fem=99 if control_judge_maj_fem==.

gen control_appl_maj_fem = appl_maj_fem
replace control_appl_maj_fem=99 if control_appl_maj_fem==.

gen control_resp_maj_fem = resp_maj_fem
replace control_resp_maj_fem=99 if control_resp_maj_fem==.




*** Variable globals

global controls_ethn i.control_majority_ethnicity_r i.control_majority_ethnicity_a

global controls_ethn_nojudge i.control_maj*

global controls_gend i.control_judge_maj_fem i.control_appl_maj_fem i.control_resp_maj_fem

global controls_other i.control_case_type i.control_appeal num_respondents num_applicants num_judges



	
*** Order 

order case_id ///
	  appl_win resp_win ///
	  judge_maj_fem appl_maj_fem resp_maj_fem ///
	  judge_majority_gender applicant_majority_gender respondent_majority_gender ///
	  majority_ethnicity_applicants majority_ethnicity_respondents majority_ethnicity_judges ///
	  cid year court_year judgeFE ///
	  case_type court_div court_type appeal appealed reversed ///
	  num_respondents num_applicants num_judges ///
	  judge_app_same judge_resp_same ///
	  judge_app_same_G judge_resp_same_G  ///
	  ethnic_ingroup gender_ingroup ///
	  num_female_judges num_male_judges ///
	  num_female_a num_male_a num_female_r num_male_r ///
	  jpanel* ///
	  same_winpropR diff_winpropR same_winpropA diff_winpropA ///
	  median* appl_fem_x_slant resp_fem_x_slant appl_fem_x_slantgb resp_fem_x_slantgb ///
	  judges judge_name respondents respondent_name applicants applicant_name  ///
	  citation_count cited_count length_of_judgement laws_count time_to_disposition ///
	  control*
	  
	  
	
	
*** Path to data folder

cd "$data"


	 
	  	 
*** Drop obs that will not be used in any analysis --- save

drop if judge_app_same==. & judge_resp_same==. & judge_app_same_G==. & judge_resp_same_G==.

drop if case_type==6

save data_clean_constructed, replace

