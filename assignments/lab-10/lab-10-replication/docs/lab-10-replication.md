Lab 10 Replication Notebook
================
Christopher Prener, Ph.D.
(April 02, 2018)

Introduction
------------

This is the replication notebook for Lab 10 from the course SOC 4650/5650: Introduction to GISc.

Load Dependencies
-----------------

The following code loads the package dependencies for our analysis:

``` r
# tidyverse packages
library(dplyr)   # data wrangling
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)   # work with csv files

# other packages
library(here)    # file path management
```

    ## here() starts at /Users/chris/GitHub/SOC5650/LectureRepos/lecture-11/assignments/lab-10/lab-10-replication

``` r
library(sf)      # spatial data tools
```

    ## Linking to GEOS 3.6.1, GDAL 2.1.3, proj.4 4.9.3

Load Data
---------

We'll use data distributed with the `lecture-11` repository:

``` r
permits15 <- read_csv(here("data", "demoPermits", "permits2015.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   AppNum = col_double(),
    ##   Handle = col_double(),
    ##   AddrNum = col_double(),
    ##   AddrSuf = col_character(),
    ##   StDir = col_character(),
    ##   StName = col_character(),
    ##   StType = col_character(),
    ##   UnitNum = col_character(),
    ##   MainStrucType = col_double(),
    ##   IssueDate = col_character(),
    ##   EstProjectCost = col_character(),
    ##   AppDescription = col_character()
    ## )

``` r
permits16 <- read_csv(here("data", "demoPermits", "permits2016.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   AppNum = col_double(),
    ##   Handle = col_double(),
    ##   AddrNum = col_double(),
    ##   AddrSuf = col_character(),
    ##   StDir = col_character(),
    ##   StName = col_character(),
    ##   StType = col_character(),
    ##   UnitNum = col_logical(),
    ##   MainStrucType = col_double(),
    ##   IssueDate = col_character(),
    ##   EstProjectCost = col_character(),
    ##   AppDescription = col_character()
    ## )

``` r
city <- st_read(here("data", "MO_BOUNDARY_Counties", "St_Louis_City.shp"), 
                    stringsAsFactors = FALSE)
```

    ## Reading layer `St_Louis_City' from data source `/Users/chris/GitHub/SOC5650/LectureRepos/lecture-11/assignments/lab-10/lab-10-replication/data/MO_BOUNDARY_Counties/St_Louis_City.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 1 feature and 17 fields
    ## geometry type:  POLYGON
    ## dimension:      XY
    ## bbox:           xmin: -90.32052 ymin: 38.53185 xmax: -90.16657 ymax: 38.77443
    ## epsg (SRID):    NA
    ## proj4string:    +proj=longlat +ellps=GRS80 +no_defs

``` r
county <- st_read(here("data", "MO_BOUNDARY_Counties", "St_Louis_County.shp"), 
                    stringsAsFactors = FALSE)
```

    ## Reading layer `St_Louis_County' from data source `/Users/chris/GitHub/SOC5650/LectureRepos/lecture-11/assignments/lab-10/lab-10-replication/data/MO_BOUNDARY_Counties/St_Louis_County.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 1 feature and 17 fields
    ## geometry type:  POLYGON
    ## dimension:      XY
    ## bbox:           xmin: -90.73653 ymin: 38.3883 xmax: -90.11771 ymax: 38.89118
    ## epsg (SRID):    NA
    ## proj4string:    +proj=longlat +ellps=GRS80 +no_defs

Part 2
------

Question 1
----------

The following code uses the `rbind()` function from `base R` to combine our two shapefiles mapping the county boundaries for St. Louis City and County respectively:

``` r
counties <- rbind(city, county)
```

We can check to make sure these were bound appropriately by using the `glimpse()` function from `dplyr`:

``` r
glimpse(counties)
```

    ## Observations: 2
    ## Variables: 18
    ## $ STATEFP  <chr> "29", "29"
    ## $ COUNTYFP <chr> "510", "189"
    ## $ COUNTYNS <chr> "00767557", "00758549"
    ## $ GEOID    <chr> "29510", "29189"
    ## $ NAME     <chr> "St. Louis", "St. Louis"
    ## $ NAMELSAD <chr> "St. Louis city", "St. Louis County"
    ## $ LSAD     <chr> "25", "06"
    ## $ CLASSFP  <chr> "C7", "H1"
    ## $ MTFCC    <chr> "G4020", "G4020"
    ## $ CSAFP    <chr> "476", "476"
    ## $ CBSAFP   <chr> "41180", "41180"
    ## $ METDIVFP <chr> NA, NA
    ## $ FUNCSTAT <chr> "F", "A"
    ## $ ALAND    <chr> "160458044", "1315122130"
    ## $ AWATER   <chr> "10670040", "39385838"
    ## $ INTPTLAT <chr> "+38.6356988", "+38.6407022"
    ## $ INTPTLON <chr> "-090.2445816", "-090.4459541"
    ## $ geometry <sf_geometry [degree]> POLYGON ((-90.32052 38.5941..., POLY...

After binding them and ensuring that the data matched, we will export them:

``` r
dir.create(here("data", "cleanData"))
```

    ## Warning in dir.create(here("data", "cleanData")): '/Users/chris/GitHub/
    ## SOC5650/LectureRepos/lecture-11/assignments/lab-10/lab-10-replication/data/
    ## cleanData' already exists

``` r
st_write(counties, here("data", "cleanData", "StLouis_Regional_Counties.shp"), delete_dsn = TRUE)
```

    ## Deleting source `/Users/chris/GitHub/SOC5650/LectureRepos/lecture-11/assignments/lab-10/lab-10-replication/data/cleanData/StLouis_Regional_Counties.shp' using driver `ESRI Shapefile'
    ## Writing layer `StLouis_Regional_Counties' to data source `/Users/chris/GitHub/SOC5650/LectureRepos/lecture-11/assignments/lab-10/lab-10-replication/data/cleanData/StLouis_Regional_Counties.shp' using driver `ESRI Shapefile'
    ## features:       2
    ## fields:         17
    ## geometry type:  Polygon

### Question 2

The following code uses the `bind_rows()` function from `dplyr` to combine our two data tables containing demolition permit data:

``` r
permits <- bind_rows(permits15, permits16)
```

We can check to make sure these were bound appropriately by using the `glimpse()` function from `dplyr`:

``` r
glimpse(permits)
```

    ## Observations: 1,018
    ## Variables: 12
    ## $ AppNum         <dbl> 517050, 517240, 517484, 517683, 518415, 518541,...
    ## $ Handle         <dbl> 16497000010, 13996000435, 12674000020, 13957000...
    ## $ AddrNum        <dbl> 150, 4963, 4338, 4001, 5971, 1485, 5746, 5755, ...
    ## $ AddrSuf        <chr> NA, NA, NA, "-67", NA, "-89 R", "-54", NA, NA, ...
    ## $ StDir          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    ## $ StName         <chr> "VICTOR", "MANCHESTER", "CALIFORNIA", "CHOUTEAU...
    ## $ StType         <chr> "ST", "AV", "AV", "AV", "AV", "BLVD", "DR", "DR...
    ## $ UnitNum        <chr> "WHL BLK", NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ MainStrucType  <dbl> 20, 20, 1, 20, 1, 20, 20, 20, 1, 1, 1, 20, 1, 2...
    ## $ IssueDate      <chr> "1/15/2015 0:00:00", "1/22/2015 0:00:00", "1/13...
    ## $ EstProjectCost <chr> "$136000.00", "$125000.00", "$8200.00", "$21700...
    ## $ AppDescription <chr> "WRECK COMMERCIAL BUILDINGS INCL. 2509,2513,252...

After binding them and ensuring that the data matched, we will export them:

``` r
write_csv(permits, here("data", "cleanData", "demoPermits.csv"))
```
