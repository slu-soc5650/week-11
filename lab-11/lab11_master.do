// ==========================================================================

// SOC 4650/5650 - Lab 11 - MASTER

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

capture confirm file countyFIPS.xlsx

if _rc==601 {
	display in red "This do-file requires that the source data be saved in your working folder."
	exit
}

capture confirm file strokeAll.xlsx

if _rc==601 {
	display in red "This do-file requires that the source data be saved in your working folder."
	exit
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using week11-extended.txt, text replace

// ==========================================================================

/* 
file name - lab11_master.do

project name - SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Lab 11 - Master File
	                                                                               
created - 24 Mar 2016

updated - 24 Mar 2016
                                                                                
author - CHRIS
*/                                                                              
                                                                         

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file is the master file for lab 11, which maps stroke mortality
rates for the united states
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- countyFIPS.xlsx - county fips code definitions
- strokeAll.xlsx - stroke mortality data
*/

/* 
subordinates - 
This do-file calls the following three sub-files:
	- 1_cleanCounty.do
	- 2_cleanStroke.do
	- 3_createCountyStroke.do
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. clean countyFIPS.xlsx
do 1_cleanCounty.do

// 2. clean strokeAll.xlsx
do 2_cleanStroke.do

// 3. merge and export data
do 3_createCountyStroke.do

// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
