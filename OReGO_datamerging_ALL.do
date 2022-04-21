
*==============================================================================
* Merge activities

* MERGE IT ALL!!!

cd "data\data_final"
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
save 	"ALLDATA_merged.dta", replace 

