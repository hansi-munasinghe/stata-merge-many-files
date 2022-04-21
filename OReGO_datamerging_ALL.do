* ===================================================================
* OReGO - ALL ACTIVITIES
* Created by Hansini on Nov 9, 2021
* This is a do of dos that imports and merges data from the OReGO Local RUC study 

*==============================================================================
* House cleaning 
version 15              // Set Version number for backward compatibility
set more off            // Disable partitioned output
clear all               // Start with a clean slate
set linesize 80         // Line size limit to make output more readable
macro drop _all         // clear all macros
capture log close       // Close existing log files, if possible (capture)
*help renvars			//install package

* set directories 
cap cd "I:\Projects\Active\ODOT_Local_RUC\Task 3_Research\Analysis\Stata_Merge+QuantAnalysis"

* log file that records all steps
log using logs\OReGOmerging_ALL.smcl, replace       // Open log file


*==============================================================================
*==============================================================================
* Merge tasks within activities

do do\OReGO_datamerging_activity01.do 
do do\OReGO_datamerging_activity02.do 
do do\OReGO_datamerging_activity03.do 
do do\OReGO_datamerging_activity04.do 
do do\OReGO_datamerging_activity05.do  
do do\OReGO_datamerging_activity06.do 
do do\OReGO_datamerging_activity07.do 
do do\OReGO_datamerging_activity08.do 
do do\OReGO_datamerging_activity09.do 
do do\OReGO_datamerging_activity10.do 
do do\OReGO_datamerging_activity11.do 
do do\OReGO_datamerging_activity12.do 
do do\OReGO_datamerging_activity13.do 
do do\OReGO_datamerging_activity14.do 


*==============================================================================
*==============================================================================
* Merge activities

* MERGE IT ALL!!!

cd "I:\Projects\Active\ODOT_Local_RUC\Task 3_Research\Analysis\Stata_Merge+QuantAnalysis\data\data_final"
local filenames: dir . files "*_m.dta"
di `filenames'

local first_file: word 1 of `filenames'
local filenames: list filenames - first_file

use "`first_file'", clear
tempfile building
save `building'

foreach f of local filenames {
    use "`f'", clear
    merge 1:1 user_id using `building'
	drop _merge
    save `"`building'"', replace
}
* SAVE FINAL!
order _all, seq // puts all variables in sequential order
save 	"OReGO_RUC_ALLDATA_merged1.dta", replace 
*=============================================================================
* Merge vehicle info 
import delimited "I:\Projects\Active\ODOT_Local_RUC\Task 3_Research\Analysis\Stata_Merge+QuantAnalysis\notes and other\OReGO_analysisR\data_vehicletypes\joined.csv", clear 
drop firstname lastname

merge 1:m user_id using "OReGO_RUC_ALLDATA_merged1.dta"
drop _m m

* clean vehicle information
encode vehicle_type, gen(vehicle_type_num)
drop vehicle_type
recode vehicle_type_num ///
			(1 4 7 = 1 "battery or hybrid") ///
			(2 3 = 0 "gasoline or diesel") ///
			(5 6 =.) ///
			, gen(vehicle_ev)



* SAVE FINAL!
order _all, seq // puts all variables in sequential order
save 	"OReGO_RUC_ALLDATA_merged2.dta", replace 


*==============================================================================
*==============================================================================

* Correct missing values so that each theme has the correct denominator
cd "I:\Projects\Active\ODOT_Local_RUC\Task 3_Research\Analysis\Stata_Merge+QuantAnalysis"
use "data\data_final\OReGO_RUC_ALLDATA_merged2.dta", clear


/*This code needs to be implemented for each theme:
	replace theme=0 if missing(theme) & !missing(text) // !missing means "not missing"
*/

* *in loop format

*==============================================================================
* ACTIVITY 2

* Activity 2 Task 2
ds a02_t02*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a02_t02_alltext)
	}

* Activity 2 Task 4
ds a02_t04*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a02_t04_alltext)
	}

* Activity 2 Task 5
ds a02_t05*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a02_t05_alltext)
	}

*==============================================================================
* ACTIVITY 4

* Activity 4 Task 6
ds a04_t06*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a04_t06_alltext)
	}

* Activity 4 Task 7
ds a04_t07*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a04_t07_alltext)
	}

* Activity 4 Task 8
ds a04_t08*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a04_t08_alltext)
	}

	* Activity 4 Task 12
ds a04_t12*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a04_t12_alltext)
	}
	
* Activity 4 Task 13
ds a04_t13*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a04_t13_alltext)
	} 

*==============================================================================
* ACTIVITY 5

* Activity 5 Task 6
ds a05_t06*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a05_t06_alltext)
	} 

* Activity 5 Task 8
ds a05_t08*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a05_t08_alltext)
	} 
	
* Activity 5 Task 9
ds a05_t09*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a05_t09_alltext)
	} 

*==============================================================================
* ACTIVITY 6

* Activity 6 Task 12
ds a06_t12*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a06_t12_alltext)
	} 
	
* Activity 6 Task 13
ds a06_t13*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a06_t13_alltext)
	} 

* Activity 6 Task 15
ds a06_t15*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a06_t15_alltext)
	} 
	
* Activity 6 Task 16
ds a06_t16*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a06_t16_alltext)
	} 
	
* Activity 6 Task 17
ds a06_t17*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a06_t17_alltext)
	} 
	
* Activity 6 Tasks 6, 7, 8 combined

replace a06_t06_alltext = "" if a06_t06_alltext=="Skip Reason: Skipped due to task segmentation"
replace a06_t07_alltext = "" if a06_t07_alltext=="Skip Reason: Skipped due to task segmentation"
replace a06_t08_alltext = "" if a06_t08_alltext=="Skip Reason: Skipped due to task segmentation"


ds a06_t060708*_thm
foreach var in `r(varlist)' {
		replace `var'=0 if ///
						missing(`var') & ///
										(	!missing(a06_t06_alltext) | ///
											!missing(a06_t07_alltext) | ///
											!missing(a06_t08_alltext) )
	} 
	
*==============================================================================
* ACTIVITY 7

* Activity 7 Task 2
ds a07_t02*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a07_t02_alltext)
	} 
	
* Activity 7 Task 3
ds a07_t03*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a07_t03_alltext)
	} 

* Activity 7 Task 9
ds a07_t09*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a07_t09_alltext)
	} 


*==============================================================================
* ACTIVITY 8

* Activity 8 Task 6
ds a08_t06*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a08_t06_alltext)
	}

* Activity 8 Task 7
ds a08_t07*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a08_t07_alltext)
	}

* Activity 8 Task 8
ds a08_t08*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a08_t08_alltext)
	}
	
* Activity 8 Task 9
ds a08_t09*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a08_t09_alltext)
	}

* Activity 8 Task 12
ds a08_t12*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a08_t12_alltext)
	}

* Activity 8 Task 13
ds a08_t13*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a08_t13_alltext)
	}


*==============================================================================
* ACTIVITY 9
* Activity 9 Task 6
ds a09_t06*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a09_t06_alltext)
	}

* Activity 9 Task 8
ds a09_t08*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a09_t08_alltext)
	}

* Activity 9 Task 9
ds a09_t09*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a09_t09_alltext)
	}
  

*==============================================================================
* ACTIVITY 10
* No themes?


*==============================================================================
* ACTIVITY 11

* Activity 11 Task 2
ds a11_t02*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a11_t02_alltext)
	}

* Activity 11 Task 4
ds a11_t04*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a11_t04_alltext)
	}



*==============================================================================
* ACTIVITY 12


* Activity 12 Task 6
ds a12_t06*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a12_t06_alltext)
	}
	
* Activity 12 Task 7
ds a12_t07*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a12_t07_alltext)
	}
	
* Activity 12 Task 8
ds a12_t08*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a12_t08_alltext)
	}
   
* Activity 12 Task 9
ds a12_t09*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a12_t09_alltext)
	}  

* Activity 12 Task 12
ds a12_t12*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a12_t12_alltext)
	}  
	
* Activity 12 Task 13
ds a12_t13*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a12_t13_alltext)
	}  	
       

*==============================================================================
* ACTIVITY 13

* Activity 13 Task 02
ds a13_t02*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a13_t02)
	}  	

* Activity 13 Task 03
ds a13_t03*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a13_t03_alltext)
	}  
	
* Activity 13 Task 09
ds a13_t09*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a13_t09_alltext)
	}  

*==============================================================================
* ACTIVITY 14

* Activity 14 Task 08
ds a14_t08*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a14_t08_alltext)
	}  	
      
* Activity 14 Task 09
ds a14_t09*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a14_t09_alltext)
	}  	

 * Activity 14 Task 10
ds a14_t10*_thm
foreach var in `r(varlist)' {
	replace `var'=0 if missing(`var') & !missing(a14_t10_alltext)
	}  	




*=============================================================================
* Close

save 	"data\data_final\OReGO_RUC_ALLDATA_clean.dta", replace 
 
 
di "ALL MERGING & CLEANING COMPLETE! YOU DID IT!"
cap log close
translate "logs\OReGOmerging_ALL.smcl" "logs\OReGOmerging_ALL.pdf", replace

* generate codebook (compact)
quietly {
    log using data\data_final\OReGO_RUC_QuantCodebook.txt, text replace
    noisily codebook, compact
    log close
	translate "data\data_final\OReGO_RUC_QuantCodebook.txt" "data\data_final\OReGO_RUC_QuantCodebook_compact.pdf", replace
}

* generate codebook (full)
quietly {
    log using data\data_final\OReGO_RUC_QuantCodebook.txt, text replace
    noisily codebook
    log close
	translate "data\data_final\OReGO_RUC_QuantCodebook.txt" "data\data_final\OReGO_RUC_QuantCodebook_full.pdf", replace
	translate "data\data_final\OReGO_RUC_QuantCodebook.txt" "I:\Projects\Active\ODOT_Local_RUC\Task 3_Research\Report\OReGO_RUC_QuantCodebook_full.pdf", replace
}
