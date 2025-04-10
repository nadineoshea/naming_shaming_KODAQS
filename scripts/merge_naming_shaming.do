

****** Nadine O'Shea: "Shaming the shameless? The impact of naming & shaming rebel groups on violence against civilians" ******

clear

*** Merge UCDP Dyadic dataset with naming_shaming dataset
*** 1. step ***

*Processing UCDP Dyadic dataset to idenfity all rebel groups in intra-state armed conflicts to have set the framework, unit of analysis is rebel group - month, dyadic structure*

use "https://github.com/nadineoshea/naming_shaming/blob/main/1.dyadic_frame.dta?raw=true", clear

*keep only years from 1989 onwards, and intra-state and internationalized intra-state conflicts
drop if year<1989
keep if type_of_conflict==3| type_of_conflict==4

rename gwno_loc country_id
rename location country
sort side_b side_a

sort side_b_id year
duplicates li side_b_id year

destring side_b_id, replace
destring country_id, replace

*expand to 12 months to have monthly structure
expand 12, g(new)
destring dyad_id, replace
replace dyad_id =. if new
bys side_a_id side_b_id (year): gen month=_n
bys side_a_id side_b_id: ipolate dyad_id month, gen(wanted) epolate
bys side_a_id side_b_id year (month): replace month=_n

sort side_b side_a year month
order gwno_a country_id country side_a side_a_id side_b side_b_id year month

*Fill in homebase countries (country country_id) for rebel groups that operate in more than 2 countries, look at where their homebase is on UCDP Encyclopedia and START

*AQIM*
replace country_id=615 if side_b_id ==539
replace country ="Algeria" if side_b_id==539

*Al-Shabaab*
replace country_id=520 if side_b_id==717
replace country ="Somalia" if side_b_id==717

*Croatian irregulars*
replace country_id=345 if side_b_id==370
replace country ="Serbia (Yugoslavia)" if side_b_id==370

*Hezbollah*
replace country_id= 660 if side_b_id==366
replace country ="Lebanon" if side_b_id==366

*IMU*
replace country_id= 770 if side_b_id==359
replace country ="Uzbekistan" if side_b_id==359

*IS*
replace country_id= 645 if side_b_id==234
replace country ="Iraq" if side_b_id==234

*JNIM*
replace country_id= 432 if side_b_id==6716
replace country ="Mali" if side_b_id==6716

*Jama'atu Ahlis Sunna Lidda'awati wal-Jihad*
replace country_id= 475 if side_b_id==1051
replace country ="Nigeria" if side_b_id==1051

*LRA*
replace country_id= 500 if side_b_id==488
replace country ="Uganda" if side_b_id==488

*MUJAO*
replace country_id= 432 if side_b_id==1161
replace country ="Mali" if side_b_id==1161

*Serbian irregulars*
replace country_id= 346 if side_b_id==371
replace country ="Bosnia-Herzegovina" if side_b_id==371

*al-Qaida*
replace country_id= 770 if side_b_id==769
replace country ="Afghanistan" if side_b_id==769

gen modate = ym(year, month) 
format modate %tm
sort side_b year modate 

destring gwno_a, replace

collapse (first)country side_a side_b (max)country_id gwno_a (max)incompatibility , by(side_b_id modate)

* save "2.dyadic.dta"

clear

*** 2. step ***

*Processing independent variable: naming & shaming variable (from excel coding file)*

/*skip this step, here I am: loading the coded naming & shaming file into Stata to save it on github as 3.naming_shaming.dta

import excel "/Users/nadineoshea/Library/CloudStorage/OneDrive-Persönlich/1. Nadine/1. PhD/2nd_paper/Coding_UNSCresolutions/coding_July_2021_1.xlsx", sheet("Tabelle1") firstrow clear

drop P Reasonfornamingshaminginj what_in_same_para_or_text1for Other_reb_mentioned_in_para1p Reasonfornamingshamingkil

destring goldstein_category, replace

save "/Users/nadineoshea/Desktop/3.naming_shaming.dta"

clear */

use "https://github.com/nadineoshea/naming_shaming/blob/main/3.naming_shaming.dta?raw=true", clear

destring goldstein_weight, replace

*gen new variables that might be of interest (main independent variable)
gen UNSC_resolution_intensity= goldstein_category if UNSC_resolution==1
replace UNSC_resolution_intensity=0 if UNSC_resolution_intensity==.

gen UNSC_press_intensity = goldstein_category if UNSC_press ==1
replace UNSC_press_intensity=0 if UNSC_press_intensity==.

gen sham_dum_resol=1 if goldstein_category >0 & UNSC_resolution==1
replace sham_dum_resol=0 if sham_dum_resol==.

gen sham_dum_press=1 if goldstein_category >0 & UNSC_press ==1
replace sham_dum_press=0 if sham_dum_press==.

gen sham_nr_UNSC_resol= 1 if UNSC_resolution==1
replace sham_nr_UNSC_resol=0 if sham_nr_UNSC_resol==.
gen sham_nr_UNSC_press= 1 if UNSC_press ==1
replace sham_nr_UNSC_press=0 if sham_nr_UNSC_press==.

gen modate = ym(year, month) 
format modate %tm
sort side_b year modate 

collapse (max)UNSC_resolution_intensity UNSC_press_intensity goldstein_category sham_dum_resol sham_dum_press sham_nr_UNSC_resol sham_nr_UNSC_press (first)country_name_rebelshamed side_b, by (side_b_id modate)

sort side_b modate

* save "4.naming_shaming.dta"


clear

*Merge 4.naming_shaming with 2.dyadic_frame (framework) in former*

use "https://github.com/nadineoshea/naming_shaming/blob/main/4.naming_shaming.dta?raw=true", clear

merge 1:m side_b_id modate using "https://github.com/nadineoshea/naming_shaming/blob/main/2.dyadic.dta?raw=true"

order _merge
sort side_b_id modate _merge

drop if _merge==1
drop _merge

sort side_b_id modate
duplicates li side_b_id modate

order side_b_id modate country side_a country_id

foreach x of varlist UNSC_resolution_intensity-sham_nr_UNSC_press  {
replace `x' = 0 if(`x' == .)
}

save "/Users/nadineoshea/naming_shaming/output/merged_data_results", replace

clear
