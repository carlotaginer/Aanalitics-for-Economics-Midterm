clear all
use https://bigblue.depaul.edu/jlee141/econdata/cps_data/cepr_march_2018.dta
keep if perno == 1
keep if hrwage > 0 | hrwage < 100
keep if age >= 25 & age <= 35
keep if phipval > 0 
set seed 2076976
gen select = rnormal(0,1)
sort select 
keep if _n <= 1000

//Model 1
regress phipval incp_wag
//Model 2
gen l_incp_wag = ln(incp_wag)
regress phipval incp_wag
//Model 3
gen l_phipval = ln(phipval)
regress phipval incp_wag

//Model 4
regress l_phipval l_incp_wag

//Q2
regress l_phipval l_incp_wag i.wbho

//Q3
regress l_phipval l_incp_wag wbho
test wbho
//Q4
regress phipval c.incp_wag##c.incp_wag
margins, dydx( incp_wag) at(incp_wag = (50000(10000)60000))
//////Part II////

clear all
use https://bigblue.depaul.edu/jlee141/econdata/cps_data/cepr_march_2018.dta
keep if age >= 25 & age <= 35
set seed 2076976
gen select = rnormal(0,1)
sort select 
gen income = incp_wag / 10000 
drop if income == . 
keep if _n <= 2000

//Q1
regress married income

//Q4
margins, dydx( income) at( income=(10))


////Part ii
logistic married income

logistic married income female

logistic married i.wbhao

//Model 1
logistic married age
//Model 2
logistic married i.forborn
//Model 3
logistic married i.hprsmort
//Model 4
logistic married i.famtyp
//Model 5
logistic married i.fchild
//Model 6
logistic married i.lfstat

///lAST MODEL
gen incp_wag2 = incp_wag*incp_wag
logistic married incp_wag incp_wag2 age i.famtyp
