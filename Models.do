cd "C:\Users\coule\OneDrive - Bentley University\Fall 2024\EC431\Stata data"
use "SCE 2013-2023 Merged Final"

* Set time series
tsset userid date

**************************** Summary Statistics ****************************

* Summary Statistics with weights
summarize EXPE oERROR PCE SPCE age_rev female_rev racecat_rev hispanic_rev educ_3cat employment income_6cat married_rev covid [w=weight] if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51)

**************************** Histogram of Expectation Error ****************************

* Relative frequency distribution of covid cases per 100,000 county level
histogram rawEXPE, fraction width(1)

**************************** Pairwise Correlation and VIF ****************************

*Check for correlation matrix of the X variables
pwcorr EXPE PCE SPCE age_rev female_rev hispanic_rev racecat_rev educ_rev income_rev married_rev

*Check the Variance Inflation Factors – VIF
estat vif

**************************** Linear Regression Models ****************************

* Revised Model with only lagged PCE variables and revised educ variable and robust standard errors to account for heteroskadicity ib(6).income_rev
tsset userid date
reg EXPE l.PCE l.SPCE ib(3).income_6cat##age_rev female_rev hispanic_rev i.racecat_rev ib(2).educ_3cat i.employment married_rev if inrange(age_rev, 18, 99), robust 
reg EXPE l.PCE l.SPCE age_rev c.age_rev#c.age_rev ib(3).income_6cat female_rev hispanic_rev i.racecat_rev i.educ_3cat i.employment married_rev covid if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51), robust

* Fixed Effects Regression Model
reg EXPE l.PCE l.SPCE age_rev ib(3).income_6cat female_rev hispanic_rev i.racecat_rev i.educ_3cat i.employment married_rev covid if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51) & inrange(year, 2013, 2023), robust

* Plotting residuals to test for autocorrelation
predict residual if e(sample), re
twoway (connected residual year) if inrange(year, 2013, 2023)

* Wooldridge test for autocorrelation
gen lPCE = l.PCE
gen lSPCE = l.SPCE
xtserial EXPE lPCE lSPCE age_rev female_rev hispanic_rev racecat_rev educ_3cat income_rev married_rev

* Breusch-Pagan test for heteroskadicity
estat hettest, iid

* Multivariate regression on expectation error with individual and date fixed effects
xtreg EXPE l.PCE l.SPCE i.date, fe i(userid)

**************************** Probability models ****************************

* Find average of accurate predictions for determining model prediction success
quietly logit dERROR l.PCE l.SPCE age_rev ib(3).income_6cat female_rev hispanic_rev i.racecat_rev i.educ_3cat i.employment married_rev covid if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51) & inrange(year, 2013, 2023), robust
sum dERROR if e(sample)

* Logit regression with marginal effects
logit dERROR l.PCE l.SPCE age_rev ib(3).income_6cat female_rev hispanic_rev i.racecat_rev i.educ_3cat i.employment married_rev covid if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51) & inrange(year, 2013, 2023), robust
margins, dydx(*)

* Probit regression with marginal effects
probit dERROR l.PCE l.SPCE age_rev ib(3).income_6cat female_rev hispanic_rev i.racecat_rev i.educ_3cat i.employment married_rev covid if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51) & inrange(year, 2013, 2023), robust
margins, dydx(*)

* Determining how well the model predicts against the mean from correctly classified, sensitivity, and specificity
quietly dERROR l.PCE l.SPCE age_rev ib(3).income_6cat female_rev hispanic_rev i.racecat_rev i.educ_3cat i.employment married_rev covid if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51) & inrange(year, 2013, 2023), robust
estat clas, cutoff(.2554572)

* Determining how well the model predicts against the mean from correctly classified, sensitivity, and specificity
quietly probit dERROR l.PCE l.SPCE age_rev ib(3).income_6cat female_rev hispanic_rev i.racecat_rev i.educ_3cat i.employment married_rev covid if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51) & inrange(year, 2013, 2023), robust
estat clas, cutoff(.2554572)

**************************** Multinomial Logit ****************************

* Multinomial Logit model on oERROR
mlogit oERROR l.PCE l.SPCE age_rev ib(3).income_6cat female_rev hispanic_rev i.racecat_rev i.educ_3cat i.employment married_rev covid if inrange(age_rev, 18, 99) & inrange(STATEI, 1, 51) & inrange(year, 2013, 2023), baseoutcome(1)

* Predict outcomes for each group
margins, dydx(*) predict(outcome(1)) predict(outcome(2)) predict(outcome(3))

* Predict probability for every person in dataset
predict prob1 prob2 prob3 if e(sample)

