
**importing DTA datset 

use "C:\Users\HP\OneDrive\Desktop\AMREC TRAINING\STIdata.dta"

** importing dataset csv

insheet using "C:\Users\HP\OneDrive\Desktop\STIData.csv"
clear all


**importing excel dataset

import excel "C:\Users\HP\OneDrive\Desktop\STIData.xls",sheet( )firstrow

**describing dataset

edit
describe
codebook
list 
set more off
clear all
**set directory 
cd "C:\Users\HP\OneDrive\Desktop\STIData.csv" 
clear all

**	DTA DATA
use "C:\Users\HP\OneDrive\Desktop\AMREC TRAINING\STIdata.dta"

**DATA CLEANING 

**Cheaking data ranges (sorting)
sort a1age
gsort-a1age **descending 
gsort a1age
codebook a1age
summarize a1age


**checking inconsistencies 
codebook casestatus 
list idnumber if casestatus == 3
browse if idnumber == 31 | idnumber == 1

**replacing 

replace casestatus = 1 if idnumber ==31 | idnumber ==1

browse if idnumber == 31 | idnumber == 1
codebook casestatus

**Handling missing values 
codebook sex 
tab sex , missing 
list idnumber if sex == ""
replace sex = "Male" if idnumber==48
replace sex = "Female" if idnumber == 213
codebook n2sexdebut
list idnumber if n2sexdebut ==.
replace n2sexdebut=19 if idnumber == 10
replace n2sexdebut=20 if idnumber == 7 | idnumber == 8| idnumber ==123 |idnumber==185
replace n2sexdebut=31 if idnumber == 217


**Duplicate values data
duplicates list idnumber 
duplicates report idnumber
browse if idnumber ==51
drop if idnumber == 51 & a1age == 23
browse if idnumber ==51

save STIDTA.tda
save STIDATA2,replace

** DATA MANAGEMENT 
*Manipulating data
browse a1age
**Generating new variables 
generate agecat =.
replace agecat = 1 if a1age >=16 & a1age <= 30
replace agecat=2 if a1age >=31 & a1age <= 45
replace agecat=3 if a1age >=46 & a1age <= 60
replace agecat=4 if a1age > 60

**label define 
label define agecat 1 "16-30" 2 "31-45" 3 "46-60" 4 "above 60" ,modify
label values agecat agecat
tab agecat

clear all
** importing excel data
import excel "C:\Users\HP\OneDrive\Desktop\AMREC TRAINING\STIData.xls",sheet (STIData) firstrow 
**using gen command 
generate bmi = Weight/(Height/100)^2
generate bmi2 = round(bmi,.01)
generate bmicat =.
replace bmicat = 1 if bmi < 18
replace bmicat =2 if bmi >= 18 & bmi <=24.9
replace bmicat =3 if bmi >=25 & bmi <= 30
replace bmicat =4 if bmi > 30
label define bmicat 1 "<18" 2 "18-24.9" 3 "25-30" 4 ">30"
label values bmicat bmicat
clear all

**using extended command (egen)
*used when using data formular 
*example
use "C:\Users\HP\OneDrive\Desktop\AMREC TRAINING\STIdata.dta"
clear all

use "C:\Users\HP\OneDrive\Desktop\AMREC TRAINING\STIdata.dta"

**Generate meanage(a1age)
egen meanage = mean(a1age)

**confirm :
list meanage
egen meanage1 = round(meanage, .01)
list meanage1
browse meanage1

**merging levels in a variable 
**in stiunclean =using occupation 
/*confirm levels codebook */

codebook a2occupation


/**generate occup_new*/
drop occup_new

gen occup_new_n = 0 if a2occupation == "1 unemployed" | a2occupation == "4 student"
replace occup_new =1 if a2occupation == "2 informal" | a2occupation == "3 formal"
codebook occup_new
br occup_new

/**Adding labels*/

/*we use label define 
e.g occup_new  */
label define occup_new 0 "unemployment"  1 "employed "
clear all


**converting variable types e.g changing from string to numeric 
** we use encode command , example 
encode sex ,gen(gend_num)
codebook gend_num
list gend_num
browse gend_num


** combining data set 
**assigment ...generate edu_level, i) label education ,1-primary ,2-secondary ....ii) merge 1 and 2 to 3 


**1.merging 
import excel "C:\Users\HP\OneDrive\Documents\dataset1.xlsx", sheet("Sheet1") firstrow
save "C:\Users\HP\OneDrive\Documents\dataset_1.dta
clear all

import excel "C:\Users\HP\OneDrive\Documents\dataset 2.xlsx", sheet("Sheet1") firstrow
save  "C:\Users\HP\OneDrive\Documents\datase_2.dta
 clear all
 
 import excel "C:\Users\HP\OneDrive\Documents\dataset 3.xlsx", sheet("Sheet1") firstrow
save "C:\Users\HP\OneDrive\Documents\datase_3.dta
clear all
** merging using data1.dta & dataset 2 .dta
use "C:\Users\HP\OneDrive\Documents\dataset_1.dta
import excel "C:\Users\HP\OneDrive\Documents\dataset 2.xlsx", sheet("Sheet1") firstrow clear
save  "C:\Users\HP\OneDrive\Documents\datase2.dta
**merge 1:1 
merge 1:1 id using dataset2.dta
save m12.dta

**one to many or many to one 
** using dataset1 and dataset3
use "C:\Users\HP\OneDrive\Documents\datase_2.dta
clear all
use "C:\Users\HP\OneDrive\Documents\dataset_1.dta
merge 1:m id using dataset_3
clear all


import excel "C:\Users\HP\OneDrive\Documents\data1.xlsx", sheet("Sheet1") firstrow
save  "C:\Users\HP\OneDrive\Documents\data1.dta
clear all

import excel import excel "C:\Users\HP\OneDrive\Documents\data2.xlsx", sheet("Sheet1") firstrow.xlsx", sheet("Sheet1") firstrow
save "C:\Users\HP\OneDrive\Documents\data2.dta
clear all

import excel "C:\Users\HP\OneDrive\Documents\data3.xlsx", sheet("Sheet1") firstrow
save "C:\Users\HP\OneDrive\Documents\data3 
clear all

 /**Appending(adding no. of observations )
 /** Example : 

 
 /** ANALYSIS IN STATA **/
 **DESCRIPTIVE ANALYSIS 
 **(univariate and bivariate analysis )
 **MULTIVARIATE ANALYSIS 
 ** create tables 
 *visualization (graph)
 */
 *Data set : STIdata_unclean 
 *i)For continous variable */

 
 **load STIdata unclean 
 clear all
 **Descriptive of Age ,height ,durationoillness
summarize a1age height durationofillness

**descriptive of categorical data 
*i) single variable :sex 
tab sex
tab education 

** Two variables (sex and casestatus)
tab sex casestatus 
tab sex casestatus , r 

**Visualizing 
*continous e.g line graph ,histogram ,bargraph, boxplot 
**categorical e.g pie chart 
* i) Histogram (height)
hist height 
*box plot(height and sex)
graph box height,over(sex) 
*scatter plot
scatter height a1age
**line of best fit
scatter height a1age||lfit height a1age

*categorical:piechart 
graph pie , over(casestatus)
graph pie,over(casestatus ) plabel(_all percent)


**Test of hypothesis 
**count variables (continoyus & Discrete )e.g Age,height,weight
** use t-test ,Anova


**Example using STI-data
clear all

**case 1 one variable 
mean a1age
mean height 
ttest a1age == 45

** case 2 two variables (a1age and height )
/** e.g Ho:mean of age = mean of height 
Ha: mean of age =!  mean of height*/
ttest a1age=height 

**case 3 :a1age by sex ( comparing mean age of male and mean age of female )
/*Ho:mean age of male = mean age of female 
Ha: mean age of male !=mean age of female */

ttest a1age ,by(sex)

*CATEGORICAL VARIABLE
**Chi-square test 
*Example (sex and casestatus)
/**H0: sex and casestatus not related 
Ha:sex and casestatus related */

tab sex casestatus ,chi2

**REGRESSION 
regress height a1age 

**LOGISTIC REGRESSION 
/* Binary -outcome var takes 1 or 0
i.e success or failure */
logit 

/*Modelling prevalence of STI predictor variables (sex,age maritalstatus,occupation,number of sex patners ),,.and outcome (casestatus )*/

**1.STIpn(casestatus)
gen stipn=1 if casestatus ==1
replace stipn =0 if stipn==.
label define stipnlb 0 "0negative" 1 "1positive"

**2.sexn.
gen sexn=0 if sex =="Female"
replace sexn=1 if sexn==.
label define sexnlb 0 "Female" 1 "Male"
label values sexn sexnlb
tab sexn stipn,r

**Age category 

gen agecat =0 if a1age > 40
replace agecat =1 if agecat ==.
label define agecatlb 0 "old" 1 "Young"
label values agecat agecatlb
tab agecat stipn , r 


**marital status
drop murs
gen murs = 1  if a5maritalstatus == "1 single"
replace murs = 2 if a5maritalstatus == "2 married"
replace murs = 3 if a5maritalstatus == "3 co-habiting"
replace murs = 4 if a5maritalstatus == "4 divorce"
replace murs = 5 if a5maritalstatus == "5 widowed"
replace murs = 0 if a5maritalstatus == ""
label define murslb 1 "1 single" 2 "2 married" 3 "3 co-habiting" 4 "4 divorcee" 5 "5 widowed"
label values murs murslb
tab murs stipn,r


** use of condoms
drop usec
gen usec = 1 if n12usecondom == "1 yes"
replace usec = 2 if n12usecondom == "2 No"
replace usec = 3 if n12usecondom == "2 no"
label define useclb 1 "1 yes" 2 "2 No" 3 "2 no"
label values usec useclb
tab usec stipn,r




**fitting logistic model

logit stipn sexn agecat sexpartner1year  
logit stipn i.sexn i.agecat i.sexpartner1year 

*reference point 

*log odds 
logit stipn i.sexn i.agecat i.sexpartner1year i.b3.education 
**changing from log odss to odds ratio 
logit stipn i.sexn i.agecat i.sexpartner1year i.b3.education ,or




















 

