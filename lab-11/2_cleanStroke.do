// ==========================================================================

// SOC 4650/5650 - Lab 11 - Clean Stroke Mortality

// ==========================================================================

// modified opening options

set more off
set linesize 80

// ==========================================================================

/* 
file name - 2_cleanStroke.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Lab 11 - Clean stroke mortality data
	                                                                               
created - 24 Mar 2016

updated - 24 Mar 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file is the second of three subfiles for lab 11. This file cleans
the county stroke mortality data from the CDC.
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- strokeAll.xlsx - raw stroke mortality data
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
import excel strokeAll.xlsx, sheet("Sheet1") firstrow
save strokeAll.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2. documentation
label data "strokeAll.dta - data for Week 11 lab"
notes _dta: Created by Chris on 24 Mar 2016 for lab 11

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 3. clean data
rename StrokeDeathRates strokeMortality
label variable strokeMortality "stroke mortality rate"
notes strokeMortality: variable renamed from original name ///
	'StrokeDeathRates' (CHRIS; 24 Mar 2016)

generate geoid = string(FIPSCode, "%05.0f")
label variable geoid "county fips code"
notes geoid: variable derived from FIPSCode with leading zero added; ///
	FIPSCode subsequently dropped (CHRIS; 24 Mar 2016)

drop FIPSCode

order geoid strokeMortality

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 4. save data
save strokeAll.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 5. clear data from memory
clear

// ==========================================================================
// ==========================================================================
// ==========================================================================

// end
