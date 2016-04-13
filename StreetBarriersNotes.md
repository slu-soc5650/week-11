# Street Barriers Project
## iPod Touch Accuracy Testing

### Morrissey Round 1
*Initial Notes:* Taylor collected data on Friday, April 8th between 12:38 and 2:04pm. Weather was in mid-50s and partly cloudy. GCP located at the northeast corner of Morrissey Hall. 

#### 12 Apr 2016
*Step 1:* Raw data exported from FileMaker Pro to CSV, then imported into ArcGIS as point data. Originally projected using NAD 1983, but converted to NAD 1983 Missouri State Place East (Meters) for further manipulation. Project tool used for conversion; original NAD 1983 geographic coordinate system feature retained.

*Step 2:* A ground control point feature class was also created by referencing the ortho imagery. For this test, the relevant ortho tile was 053-080 (2015 St. Louis regional overflight). A new feature class was created in ArcGIS to represent this point. It was projected in NAD 1983 Missouri State Place East (Meters).

*Step 3:* Point distance tool used to calculate a table with difference in distance between the sample data measured in meters (input feature) and the ground control point (near feature). Output table saved to geodatabase.

*Step 4:* Data exported as a .dfb file for cleaning and analysis in Stata; .dbf file opened in Microsoft Excel and saved as a .xlsx file

#### 13 Apr 2016
*Step 6:* Calculate root mean squared error in Stata
Formula:
$$ RMSE = \sqrt { \frac { 1 }{ N } \sum \_{ i=1 }\^{ N }{ (x\_{ i }-{ \hat { x }  }\_{ i })^{ 2 } }  }  $$
where $$ (x\_{ i }-{ \hat { x }  }\_{ i }) $$
is the distance between the observation's location and the ground control point. These are the data points that were calculated by ArcGIS using the point distance tool. These values are represented by the ```DISTANCE``` variable.

Stata code:
```Stata
// import data
import excel "Morrissey1.xlsx", sheet("Morrissey1") firstrow

// calculate RMSE
generate distanceSq = DISTANCE^2
summarize distanceSq
display sqrt(r(sum)/_N)
```

The resulting value is 235.62 meters of error between observed and predicted values. This is high, but there are a couple of extreme outliers: 


```Stata
. list DISTANCE if DISTANCE > 531

     +-----------+
     |  DISTANCE |
     |-----------|
 27. | 1180.2431 |
 28. | 1180.2431 |
     +-----------+
```

Two things to note - there are only two values that were over 530 meters (the 95th percentile of the distribution). They are also identical. Need to go back and clean these data so that duplicate values are eliminated. This should be done in Stata using the ```duplicates``` command. Once the duplicate values are cleaned, we should repeat this process.

*Step 7:* Calculate root mean squared error with extreme outliers removed.

```Stata
// calculate RMSE without extreme outliers
summarize distanceSq if DISTANCE < 535
display sqrt(r(sum)/_N)
```

The resulting value is 109.48 meters of error - significantly better than the initial estimate but still problematically large.