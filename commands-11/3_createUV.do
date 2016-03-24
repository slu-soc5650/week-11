// ==========================================================================

// SOC 4650/5650 - Week 11 Extended Example - 1_createUV.do

// ==========================================================================

// modified opening options

set more off
set linesize 80

// ==========================================================================

/* 
file name - 1_cleanV.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Extended Example of Week 11 Concepts
	                                                                               
created - 24 Mar 2016

updated - 24 Mar 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file is the third of three subfiles for the extended example of
Week 11 concepts.
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- u.dta - example data created by 1_cleanU
- v.dta - example data created by 2_cleanV
- week11-extended.do - master do-file that calls this sub-file
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. open data that will become master data
use u.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2. merge data
merge 1:1 id using v.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 3. check merge
tabulate _merge
describe

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 4. drop merge variable to eliminate conflicts with ArcGIS
drop _merge

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 5. save data
save uvFull.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 6. export data in excel format
export excel uvFull.xlsx, firstrow(variables) replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 7. clear data from memory
clear

// ==========================================================================
// ==========================================================================
// ==========================================================================

// end
