// ==========================================================================

// SOC 4650/5650 - Lab 11 - Create spreadsheet for mapping

// ==========================================================================

// modified opening options

set more off
set linesize 80

// ==========================================================================

/* 
file name - 3_createCountyStroke.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Lab 11 - Clean stroke mortality data
	                                                                               
created - 24 Mar 2016

updated - 24 Mar 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file is the third of three subfiles for lab 11. This file merges
the county level stroke data with the county fips codes definitions.
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- countyFIPS.dta - county fips definitions
- strokeAll.dta - stroke mortality data
- lab11_master.do - master do-file that calls this sub-file
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. open data that will become master data
use countyFIPS.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2. merge data
merge 1:1 geoid using strokeAll.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 3. check merge
tabulate _merge
describe

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 4. drop merge variable to eliminate conflicts with ArcGIS
drop _merge

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 5. save data
save countyStroke.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 6. export data in excel format
export excel countyStroke.xlsx, firstrow(variables) replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 7. clear data from memory
clear

// ==========================================================================
// ==========================================================================
// ==========================================================================

// end
