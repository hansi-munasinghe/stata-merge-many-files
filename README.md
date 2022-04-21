# stata-merge-many-files
* Syntax for merging many stata datasets 
*==============================================================================

* STEPS:
* Save all datasets you want merged in one folder
* start with first dataset (call this building)
* merge next file onto it, save 
* keep going through list of all files

* TIPS:
* Make sure all datasets have the same unique ID
* Because this involves opening and saving many times, consider working locally (VPN gave out for me)

*==============================================================================
* SYNTAX - MERGE IT ALL!!!

* set directory 
cd "your-folder/with-all-datasets-to-be-merged"

* get filenames
local filenames: dir . files "*_m.dta" // full list of filenames ending with .dta
di `filenames'

local first_file: word 1 of `filenames' // identify first filename

local filenames: list filenames - first_file // remove first filename from list

use "`first_file'", clear
tempfile building
save `building' // start with first filename 

foreach f of local filenames {
    use "`f'", clear
    merge 1:1 user_id using `building'
	drop _merge
    save `"`building'"', replace
}

* SAVE FINAL!
order _all, seq // puts all variables in sequential order
save 	"ALLDATA_merged.dta", replace 

*==============================================================================
