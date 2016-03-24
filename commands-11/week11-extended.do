// ==========================================================================

// SOC 4650/5650 - Week 11 Extended Example - MASTER

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

capture confirm file u.xlsx

if _rc==601 {
	display in red "This do-file requires that the source data be saved in your working folder."
	exit
}

capture confirm file v.xlsx

if _rc==601 {
	display in red "This do-file requires that the source data be saved in your working folder."
	exit
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using week11-extended.txt, text replace

// ==========================================================================

/* 
file name - week11-exteded.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Extended Example of Week 11 Concepts
	                                                                               
created - 24 Mar 2016

updated - 24 Mar 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file is the master file for the extended example of concepts 
from Week 11
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- a.xlsx - example dataset downloaded from GitHub
- b.xlsx - example dataset downloaded from GitHub
*/

/* 
subordinates - 
This do-file calls the following three sub-files:
	- 1_cleanU.do
	- 2_cleanV.do
	- 3_createUV.do
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. clean a.xlsx
do 1_cleanU.do

// 2. clean b.xlsx
do 2_cleanV.do

// 3. merge and export data
do 3_createUV.do

// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
