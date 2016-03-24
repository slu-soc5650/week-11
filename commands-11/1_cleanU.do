// ==========================================================================

// SOC 4650/5650 - Week 11 Extended Example - 1_cleanU.do

// ==========================================================================

// modified opening options

set more off
set linesize 80

// ==========================================================================

/* 
file name - 1_cleanU.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Extended Example of Week 11 Concepts
	                                                                               
created - 24 Mar 2016

updated - 24 Mar 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file is the first of three subfiles for the extended example of
Week 11 concepts.
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- u.xlsx - example dataset downloaded from GitHub
- week11-extended.do - master do-file that calls this sub-file
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. import data
import excel u.xlsx, sheet("Sheet1") firstrow
save u.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2. documentation
label data "u.dta - data for Week 11 extended example"
notes _dta: Created by Chris on 24 Mar 2016 for illustrating the use of ///
	master do-files for cleaning, merging, and exporting data

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 3. clean data
label variable id "identification number"
rename u uScore 
label variable uScore "score of instrument u"

notes uScore: variable renamed from original name 'u' (CHRIS; 24 Mar 2016)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 4. save data
save u.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 5. clear data from memory
clear

// ==========================================================================
// ==========================================================================
// ==========================================================================

// end
