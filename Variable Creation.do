cd "C:\Users\coule\OneDrive - Bentley University\Fall 2024\EC431\Stata data"
use "SCE 2013-2023 Merged rev"

* Create Raw EXPE variable for oERROR
gen rawEXPE = YFPCE - Q9_cent50

* Create dERROR dummy variable where EXPE is within +/- .5% is 1 and else is 0
drop dERROR
gen dERROR = (EXPE < 1)

* Create oERROR categorical variable where EXPE is within +/- .5% is well calibrated group, higher is overestimate group, and lower is underestimate.
* 1 = Accurate (Within +/- 1% point) ; 2 = Underestimate ; 3 = Overestimate
gen oERROR = .
replace oERROR = 1 if rawEXPE > -1 & rawEXPE < 1
replace oERROR = 2 if rawEXPE > 1
replace oERROR = 3 if rawEXPE < -1

* Create Expectation Error Variable
gen EXPE = abs(YFPCE - Q9_cent50)

* Create obs variable
sort year month
gen obs = _n

* Generate binary gender variable for female
gen female = . 
replace female = 0 if Q33 == 2
replace female = 1 if Q33 == 1

* Generate Covid Binary Variable
drop covid
gen covid = (date > 202002)

* Create binary hispanic variable
gen hispanic = . 
replace hispanic = 0 if Q34 == 2
replace hispanic = 1 if Q34 == 1

* Create binary married variable
gen married = . 
replace married = 0 if Q38 == 2
replace married = 1 if Q38 == 1

* Create binary rent/own variable
gen ownhome = . 
replace ownhome = 0 if Q43 == 2 | Q43 == 3
replace ownhome = 1 if Q43 == 1

* Create race variables (one numeric one string)
gen race = "" 
replace race = "White" if Q35_1 == 1
replace race = "Black" if Q35_2 == 1
replace race = "Native" if Q35_3 == 1
replace race = "Asian" if Q35_4 == 1
replace race = "Islander" if Q35_5 == 1
replace race = "Other" if Q35_6 == 1

gen racecat = . 
replace racecat = 1 if Q35_1 == 1
replace racecat = 2 if Q35_2 == 1
replace racecat = 3 if Q35_3 == 1
replace racecat = 4 if Q35_4 == 1
replace racecat = 5 if Q35_5 == 1
replace racecat = 6 if Q35_6 == 1

* Based on foward and backfilled revised race variable
gen racecat_rev = . 
replace racecat_rev = 1 if race_rev == "White"
replace racecat_rev = 2 if race_rev == "Black"
replace racecat_rev = 3 if race_rev == "Native"
replace racecat_rev = 4 if race_rev == "Asian"
replace racecat_rev = 5 if race_rev == "Islander"
replace racecat_rev = 6 if race_rev == "Other"

* Categorical household income variable (D6 is repeat respondents)
gen income = .
replace income = D6 if D6 > 0
replace income = Q47 if income == . & Q47 > 0

* Create employment variable
gen employment = . 
* Employed Full/Part Time
replace employment = 1 if Q10_1 == 1 | Q10_2 == 1
* Unemployed
replace employment = 2 if Q10_3 == 1 | Q10_4 == 1 | Q10_5 == 1
* Retired
replace employment = 3 if Q10_7 == 1
* Out of the Labor Force
replace employment = 4 if Q10_6 == 1 | Q10_8 == 1 | Q10_9 == 1

*********************** Creating renamed variables ***********************
* Generate age variable
gen age = Q32

* Generate medEXP variable
gen medEXP = Q9_cent50

* Generate educ variable
gen educ = Q36

* Consolidating educ_rev variable to limit multicolinearity
* 1 = Less than HS to some college
* 2 = Associate/Junior college
* 3 = BS/BA to Professional Degree
gen educ_3cat = .
replace educ_3cat = 1 if inrange(educ_rev, 1, 3)
replace educ_3cat = 2 if educ_rev == 4
replace educ_3cat = 3 if inrange(educ_rev, 5, 8)

*********************** Filling in missing demographic data ***********************

* Revised string and numeric variables
gen forward_race = race
bysort userid (month): replace forward_race = forward_race[_n-1] if forward_race == ""

gen race_rev = forward_race
gsort userid -month
* Ran 15 times
bysort userid (month): replace race_rev = race_rev[_n+1] if race_rev == ""

* Revised age variable
gen forward_age = age
bysort userid (month): replace forward_age = forward_age[_n-1] if forward_age == .

gen age_rev = forward_age
gsort userid -month
* Ran 15 times
bysort userid (month): replace age_rev = age_rev[_n+1] if age_rev == .

* Revised female variable
gen forward_female = female
bysort userid (month): replace forward_female = forward_female[_n-1] if forward_female == .

gen female_rev = forward_female
gsort userid -month
* Ran 15 times
bysort userid (month): replace female_rev = female_rev[_n+1] if female_rev == .

* Revised hispanic variable
gen forward_hispanic = hispanic
bysort userid (month): replace forward_hispanic = forward_hispanic[_n-1] if forward_hispanic == .

gen hispanic_rev = forward_hispanic
gsort userid -month
* Ran 15 times
bysort userid (month): replace hispanic_rev = hispanic_rev[_n+1] if hispanic_rev == .

* Revised married variable
gen forward_married = married
bysort userid (month): replace forward_married = forward_married[_n-1] if forward_married == .

gen married_rev = forward_married
gsort userid -month
* Ran 15 times
bysort userid (month): replace married_rev = married_rev[_n+1] if married_rev == .

* Revised married variable
gen forward_married = married
bysort userid (month): replace forward_married = forward_married[_n-1] if forward_married == .

gen married_rev = forward_married
gsort userid -month
* Ran 15 times
bysort userid (month): replace married_rev = married_rev[_n+1] if married_rev == .

* Revised educ variable
gen forward_educ = educ
bysort userid (month): replace forward_educ = forward_educ[_n-1] if forward_educ == .

gen educ_rev = forward_educ
gsort userid -month
* Ran 15 times
bysort userid (month): replace educ_rev = educ_rev[_n+1] if educ_rev == .

* Revised income variable
gen forward_income = income
bysort userid (month): replace forward_income = forward_income[_n-1] if forward_income == .

gen income_rev = forward_income
gsort userid -month
* Ran 15 times
bysort userid (month): replace income_rev = income_rev[_n+1] if income_rev == .

* Revised income categories
gen income_6cat = .
* Low Income (1): Less than $10,000 to $19,999
replace income_6cat = 1 if income_rev == 1 | income_rev == 2
* Lower-Middle Income (2): $20,000 to $39,999
replace income_6cat = 2 if income_rev == 3 | income_rev == 4
* Middle-Middle Income (3): $40,000 to $59,999
replace income_6cat = 3 if income_rev == 5 | income_rev == 6
* Upper-Middle Income (4): $60,000 to $99,999
replace income_6cat = 4 if income_rev == 7 | income_rev == 8
* Upper Income (5): $100,000 to $199,999
replace income_6cat = 5 if income_rev == 9 | income_rev == 10
* Highest Income (6) $200,000+
replace income_6cat = 6 if income_rev == 11

* High Income (5): $100,000 or more

* Revised ownhome variable
gen forward_ownhome = ownhome
bysort userid (month): replace forward_ownhome = forward_ownhome[_n-1] if forward_ownhome == .

gen ownhome_rev = forward_ownhome
gsort userid -month
* Ran 15 times
bysort userid (month): replace ownhome_rev = ownhome_rev[_n+1] if ownhome_rev == .

* Check
browse userid date year month STATE ownhome ownhome_rev income income_rev educ_rev married_rev hispanic_rev female_rev age_rev racecat_rev race_rev if inrange(year, 2013, 2023)

order obs userid date year month STATE STATEI medEXP PCE SPCE YFPCE EXPE age female hispanic race racecat income educ married ownhome Q45b l1m l3 l4 lmtype lmind l7bm l9 l11 l12 l12b, first
