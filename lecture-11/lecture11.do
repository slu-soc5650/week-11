// ==========================================================================

// OSC 4650/5650 - Lecture 11

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
	cd "/Users/`c(username)'/Documents/Working"
}

else if "`c(os)'" == "Windows" {
	cd "C:\Users\`c(username)'\Documents\Working"	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if source data exists

capture confirm file a.dta

if _rc==601 {
	display in red "This do-file requires that the source datasets be saved in your working folder."
	exit
}

capture confirm file b.dta

if _rc==601 {
	display in red "This do-file requires that the source datasets be saved in your working folder."
	exit
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using lecture11.txt, text replace

// ==========================================================================

/* 
file name - lecture11.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Replication of Lecture 11 Merge Example
	                                                                               
created - 24 Mar 2016

updated - 24 Mar 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file replicates the lecture example for merging data
*/

/* 
updates - 

*/

// ==========================================================================

/* 
superordinates  - 
- a.dta - example dataset downloaded from Blackboard
- b.dta - example dataset downloaded from Blackboard
*/

/* 
subordinates - 

*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. initial exploration of first dataset

use a.dta
describe
clear

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2. initial exploration of second dataset

use b.dta
describe
clear

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 3. re-open first dataset, will be master

use a.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 4. merge data
merge 1:1 id using b.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 5. check merge
tabulate _merge
describe

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 6. save merged data
save abFull.dta, replace

// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
