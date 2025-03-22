cd "C:\Users\coule\OneDrive - Bentley University\Fall 2024\EC431\Stata data"

**************************** SCE 2013-2023 ****************************
use "SCE 2013-2016"

* Compile SCE Surveys from 2016 to 2023
append using "SCE 2017-2019"
append using "SCE 2020-2023"

* Generate year and month variables for merging
gen year = floor(date / 100)
gen month = mod(date, 100)  

* Generate index for states
rename _STATE STATE

* Create STATEI as a sequential numeric index based on sorted order
gen STATEI = .

replace STATEI = 1 if STATE == "AL"
replace STATEI = 2 if STATE == "AK"
replace STATEI = 3 if STATE == "AZ"
replace STATEI = 4 if STATE == "AR"
replace STATEI = 5 if STATE == "CA"
replace STATEI = 6 if STATE == "CO"
replace STATEI = 7 if STATE == "CT"
replace STATEI = 8 if STATE == "DC"
replace STATEI = 9 if STATE == "DE"
replace STATEI = 10 if STATE == "FL"
replace STATEI = 11 if STATE == "GA"
replace STATEI = 12 if STATE == "HI"
replace STATEI = 13 if STATE == "ID"
replace STATEI = 14 if STATE == "IL"
replace STATEI = 15 if STATE == "IN"
replace STATEI = 16 if STATE == "IA"
replace STATEI = 17 if STATE == "KS"
replace STATEI = 18 if STATE == "KY"
replace STATEI = 19 if STATE == "LA"
replace STATEI = 20 if STATE == "ME"
replace STATEI = 21 if STATE == "MD"
replace STATEI = 22 if STATE == "MA"
replace STATEI = 23 if STATE == "MI"
replace STATEI = 24 if STATE == "MN"
replace STATEI = 25 if STATE == "MS"
replace STATEI = 26 if STATE == "MO"
replace STATEI = 27 if STATE == "MT"
replace STATEI = 28 if STATE == "NC"
replace STATEI = 29 if STATE == "ND"
replace STATEI = 30 if STATE == "NE"
replace STATEI = 31 if STATE == "NV"
replace STATEI = 32 if STATE == "NH"
replace STATEI = 33 if STATE == "NJ"
replace STATEI = 34 if STATE == "NM"
replace STATEI = 35 if STATE == "NY"
replace STATEI = 36 if STATE == "OH"
replace STATEI = 37 if STATE == "OK"
replace STATEI = 38 if STATE == "OR"
replace STATEI = 39 if STATE == "PA"
replace STATEI = 40 if STATE == "RI"
replace STATEI = 41 if STATE == "SC"
replace STATEI = 42 if STATE == "SD"
replace STATEI = 43 if STATE == "TN"
replace STATEI = 44 if STATE == "TX"
replace STATEI = 45 if STATE == "UT"
replace STATEI = 46 if STATE == "VT"
replace STATEI = 47 if STATE == "VA"
replace STATEI = 48 if STATE == "WA"
replace STATEI = 49 if STATE == "WV"
replace STATEI = 50 if STATE == "WI"
replace STATEI = 51 if STATE == "WY"
replace STATEI = 99 if STATE == "AP"

* Keep only rows with userid's
keep if userid != .

**************************** PCE 2012-2024 ****************************
use "SCE 2013-2023 Merged"

* Many to one merge with monthly PCE data
merge m:1 year month using "Monthly PCE 2012-2024"

**************************** SCE Labor Market 2014-2022 ****************************
use "SCE Labor Market"

* Prepare SCE Labor Market Survey data for merge by repeating year and date gen
gen year = floor(date / 100)
gen month = mod(date, 100)  

* Many to one merge with SCE Labor Market Survey
merge m:1 userid year month using "SCE Labor Market"

**************************** Yearly State-level PCE 1997-2021 ****************************
use "Yearly State PCE"
use "Yearly State PCE rev"

* Keep only overall PCE and leave out national PCE in state-level PCE dataset
keep if LineCode == 1

* Reshape state-level PCE dataset in long format
reshape long PCE, i(GeoFIPS) j(year)

* Temporary StateCode variable for YoY PCE calculation
encode GeoFIPS, generate(StateCode)

* Create YoY PCE for each state
tsset StateCode year
gen SPCE = ln(PCE) - ln(l.PCE)
replace SPCE = SPCE * 100

* Traditional percent change calculation
tsset STATEI year
gen SPCE2 = (PCE - l.PCE) / l.PCE

* Create STATEI in state-level PCE dataset for merging
gen STATEI = .

replace STATEI = 1 if GeoName == "Alabama"
replace STATEI = 2 if GeoName == "Alaska"
replace STATEI = 3 if GeoName == "Arizona"
replace STATEI = 4 if GeoName == "Arkansas"
replace STATEI = 5 if GeoName == "California"
replace STATEI = 6 if GeoName == "Colorado"
replace STATEI = 7 if GeoName == "Connecticut"
replace STATEI = 8 if GeoName == "District of Columbia"
replace STATEI = 9 if GeoName == "Delaware"
replace STATEI = 10 if GeoName == "Florida"
replace STATEI = 11 if GeoName == "Georgia"
replace STATEI = 12 if GeoName == "Hawaii"
replace STATEI = 13 if GeoName == "Idaho"
replace STATEI = 14 if GeoName == "Illinois"
replace STATEI = 15 if GeoName == "Indiana"
replace STATEI = 16 if GeoName == "Iowa"
replace STATEI = 17 if GeoName == "Kansas"
replace STATEI = 18 if GeoName == "Kentucky"
replace STATEI = 19 if GeoName == "Louisiana"
replace STATEI = 20 if GeoName == "Maine"
replace STATEI = 21 if GeoName == "Maryland"
replace STATEI = 22 if GeoName == "Massachusetts"
replace STATEI = 23 if GeoName == "Michigan"
replace STATEI = 24 if GeoName == "Minnesota"
replace STATEI = 25 if GeoName == "Mississippi"
replace STATEI = 26 if GeoName == "Missouri"
replace STATEI = 27 if GeoName == "Montana"
replace STATEI = 28 if GeoName == "North Carolina"
replace STATEI = 29 if GeoName == "North Dakota"
replace STATEI = 30 if GeoName == "Nebraska"
replace STATEI = 31 if GeoName == "Nevada"
replace STATEI = 32 if GeoName == "New Hampshire"
replace STATEI = 33 if GeoName == "New Jersey"
replace STATEI = 34 if GeoName == "New Mexico"
replace STATEI = 35 if GeoName == "New York"
replace STATEI = 36 if GeoName == "Ohio"
replace STATEI = 37 if GeoName == "Oklahoma"
replace STATEI = 38 if GeoName == "Oregon"
replace STATEI = 39 if GeoName == "Pennsylvania"
replace STATEI = 40 if GeoName == "Rhode Island"
replace STATEI = 41 if GeoName == "South Carolina"
replace STATEI = 42 if GeoName == "South Dakota"
replace STATEI = 43 if GeoName == "Tennessee"
replace STATEI = 44 if GeoName == "Texas"
replace STATEI = 45 if GeoName == "Utah"
replace STATEI = 46 if GeoName == "Vermont"
replace STATEI = 47 if GeoName == "Virginia"
replace STATEI = 48 if GeoName == "Washington"
replace STATEI = 49 if GeoName == "West Virginia"
replace STATEI = 50 if GeoName == "Wisconsin"
replace STATEI = 51 if GeoName == "Wyoming"

* Drop non-state variables
keep if STATEI != .

* Many to one merge with yearly state-level PCE data
merge m:1 STATEI year using "Yearly State PCE rev"

**************************** Merging Semiannual State PCE ****************************

* Create semiannual variable in main dataset where Jan-June=1 and July-Dec=0
gen semiannual = (inrange(month, 1, 6))

* Create 1 column in temp SAPCE 1 dataset representing Jan-June
gen semiannual = 1

* Create 0 column in temp SAPCE 0 dataset representing July-Dec
replace semiannual = 0 if semiannual == 1

* Add one to each year in temp SAPCE 0 dataset
replace year = year+1

* Many to one merge with temp SAPCE 1 dataset
merge m:1 year STATEI semiannual using "Temp SAPCE (1997-2021) 1"

* Many to one merge with temp SAPCE 0 dataset
merge m:1 year STATEI semiannual using "Temp SAPCE (1997-2021) 0"

* Check merge
browse userid year month STATE STATEI OGSPCE semiannual SPCE1 SPCE0 if inrange(year, 2013, 2023) & STATEI == 1

* Create final SPCE variable by merging SPCE0 and SPCE1 and multiply by 100 for %
replace SPCE1 = SPCE0 if SPCE1 == .
rename SPCE1 SPCE
replace SPCE = SPCE * 100



