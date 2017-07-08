## CodeBook for the _Getting and Cleaning data_ project


*Data set feature* 
--------------------
Data set characteristic: table in TXT file  
Value characteristic: averages  
Identifiers: subject, activity  
Number of variables:  81
Number of observations: 181  

# Identifiers

* `subject` - anonymized ID for a person 1-30
* `activity` - descriptive name of the activity measured
    + `WALKING`
    + `WALKING_UPSTAIRS`
    + `WALKING_DOWNSTAIRS`
    + `SITTING`
    + `STANDING`
    + `LAYING`


# Measurements

The description of the variables is taken from `features_info.txt` file from the source dataset.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation  

_Further variables of omitted for only `mean` and `std` are taken into processing in this project._

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
  
gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  
  
# Data transformations

ZIP file source: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

1. I use `./train/X_train.txt` and `./test/X_test.txt` files to get measured data. I only subset columns
that contains "mean" or "std" in the header.
2. The two sources are merged with _subjects_ from `subject_train.txt` and `subject_test.txt`, respectively, and with 
_activities_ from `y_train.txt` and `y_test.txt` respectively. 
3. Both files are rbind() together into the _master_ dataframe.
4. `activity` variable is replaced by human-readable labels with descriptive names based on `activity_labels.txt`.
5. _Output_ dataframe is created by calculating mean grouped by _subject_ and _activity_.
6. The _output_ dataframe is written to the output TXT file and stored in the working directory.







