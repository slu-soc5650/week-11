// ==========================================================================

// SOC 4650/5650 - Lab 11 - Clean County FIPS

// ==========================================================================

// modified opening options

set more off
set linesize 80

// ==========================================================================

/* 
file name - 1_cleanCounty.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Lab 11 - Clean County FIPS data
	                                                                               
created - 24 Mar 2016

updated - 24 Mar 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file is the first of three subfiles for lab 11. This file cleans
the county FIPS code data.
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- countyFIPS.xlsx - county FIPS code definitions
- lab11_master.do - master do-file that calls this sub-file
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. import data
import excel countyFIPS.xlsx, sheet("Sheet1") firstrow
save countyFIPS.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2. documentation
label data "countyFIPS.dta - data for Week 11 lab"
notes _dta: Created by Chris on 24 Mar 2016 for lab 11

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 3. clean data
rename State state
label variable state "state name"
notes state: variable renamed from original name 'State' (CHRIS; 24 Mar 2016)

rename County county
label variable county "county name"
notes county: variable renamed from original name 'County' (CHRIS; 24 Mar 2016)

generate geoid = string(FIPSCode, "%05.0f")
label variable geoid "county fips code"
notes geoid: variable derived from FIPSCode with leading zero added; ///
	FIPSCode subsequently dropped (CHRIS; 24 Mar 2016)

drop FIPSCode

order geoid state county

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 4. save data
save countyFIPS.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 5. clear data from memory
clear

// ==========================================================================
// ==========================================================================
// ==========================================================================

// end
