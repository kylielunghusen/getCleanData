# Course Project for Getting and Cleaning Data - Code Book

This tidy dataset is based on data from a UCI project using inertial sensors to record human activity. The original study is described here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The README and associated files for the study can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For the sake of accuracy and efficiency, the readme will be quoted here where relevant, rather than paraphrased.

## Study Design and Data Processing
In summary:

30 subjects

6 activities

561 features (different types of movement captured by the smartphone)

10299 instances (each subject carried out each activity more than once)

### Collection of the raw data
Quote from the UCI HAR README file:
>The experiments have been carried out with a group of 30 volunteers within an
> age bracket of 19-48 years. Each person performed six activities (WALKING,
> WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a
> smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer
> and gyroscope, we captured 3-axial linear acceleration and 3-axial angular
> velocity at a constant rate of 50Hz. The experiments have been video-recorded
> to label the data manually. The obtained dataset has been randomly partitioned
> into two sets, where 70% of the volunteers was selected for generating the
> training data and 30% the test data. 

### Pre-processing of the raw data
Quote from the UCI HAR README file:
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying
> noise filters and then sampled in fixed-width sliding windows of 2.56 sec and
> 50% overlap (128 readings/window). The sensor acceleration signal, which has
> gravitational and body motion components, was separated using a Butterworth
> low-pass filter into body acceleration and gravity. The gravitational force is
> assumed to have only low frequency components, therefore a filter with 0.3 Hz
> cutoff frequency was used. From each window, a vector of features was obtained
> by calculating variables from the time and frequency domain. See
> 'features_info.txt' for more details. 

### Notes on the raw data:
#### Location of raw data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#### Contents of the raw data folder
Quote from the UCI HAR README file:
> The dataset includes the following files:
> 
> - 'README.txt'
> 
> - 'features_info.txt': Shows information about the variables used on the feature vector.
> 
> - 'features.txt': List of all features.
> 
> - 'activity_labels.txt': Links the class labels with their activity name.
> 
> - 'train/X_train.txt': Training set.
> 
> - 'train/y_train.txt': Training labels.
> 
> - 'test/X_test.txt': Test set.
> 
> - 'test/y_test.txt': Test labels.
> 
> The following files are available for the train and test data. Their descriptions are equivalent. 
> 
> - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
> 
> - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
> 
> - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
> 
> - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Data from the Inertial Signals folders were not used in creating the tidy data. More information is available in [README.md](https://github.com/kylielunghusen/getCleanData/blob/master/README.md) in this repo.

## Creating the tidy data file

### Guide to creating the tidy data file
1. Download the dataset from:
  * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the dataset
3. Put the following files into R's working directory:
  * X_test.txt
  * X_train.txt
  * Y_test.txt
  * Y_train.txt
  * subject_test.txt
  * subject_train.txt
  * features.txt
  * activity_labels.txt
4. Ensure the dplyr package is installed: 
  * `> install.packages("dplyr")`
  * `> library(dplyr)`
5. Run R script: `> source("run_analysis.R")`
6. Script will create a tidy data file: `UCIGetCleanTidyData.txt`

### Script-driven processing of the data
* Files are read into R. 
* Test and train data are clipped together for each of the X (representing features), Y (representing activities) and Subject data sets.
* Y data is converted from integer codes to Activity Labels
* Features data is used as column names for the X data
* Based on column names, X data is trimmed to only contain mean and std Feature columns
* Subject, Activity (Y) and Features (X) columns are clipped together
* Column names are cleaned up to remove non-standard characters
* For each Subject/Activity combination, Feature data is grouped/condensed to the mean of its values in each column 

See README.md for more detail of how the run_analysis.R script works

## Description of variables in the tidy dataset

### Dimensions
* 180 rows (30 subjects, each of whom does 6 activities)
* 81 columns (all of the feature measurements that have "mean" or "std" in the name)

### Summary of the data
```
Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':	180 obs. of  81 variables:
 $ Subject                     : int  1 1 1 1 1 1 2 2 2 2 ...
 $ Activity                    : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...
 $ tBodyAccmeanX               : num  0.222 0.261 0.279 0.277 0.289 ...
 $ tBodyAccmeanY               : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
 $ tBodyAccmeanZ               : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
 $ tBodyAccstdX                : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
 $ tBodyAccstdY                : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
 $ tBodyAccstdZ                : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
 $ tGravityAccmeanX            : num  -0.249 0.832 0.943 0.935 0.932 ...
 $ tGravityAccmeanY            : num  0.706 0.204 -0.273 -0.282 -0.267 ...
 $ tGravityAccmeanZ            : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
 $ tGravityAccstdX             : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
 $ tGravityAccstdY             : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
 $ tGravityAccstdZ             : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
 $ tBodyAccJerkmeanX           : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
 $ tBodyAccJerkmeanY           : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
 $ tBodyAccJerkmeanZ           : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
 $ tBodyAccJerkstdX            : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
 $ tBodyAccJerkstdY            : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
 $ tBodyAccJerkstdZ            : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
 $ tBodyGyromeanX              : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
 $ tBodyGyromeanY              : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
 $ tBodyGyromeanZ              : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
 $ tBodyGyrostdX               : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
 $ tBodyGyrostdY               : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
 $ tBodyGyrostdZ               : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
 $ tBodyGyroJerkmeanX          : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
 $ tBodyGyroJerkmeanY          : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
 $ tBodyGyroJerkmeanZ          : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
 $ tBodyGyroJerkstdX           : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
 $ tBodyGyroJerkstdY           : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
 $ tBodyGyroJerkstdZ           : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
 $ tBodyAccMagmean             : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
 $ tBodyAccMagstd              : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
 $ tGravityAccMagmean          : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
 $ tGravityAccMagstd           : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
 $ tBodyAccJerkMagmean         : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
 $ tBodyAccJerkMagstd          : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
 $ tBodyGyroMagmean            : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
 $ tBodyGyroMagstd             : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
 $ tBodyGyroJerkMagmean        : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
 $ tBodyGyroJerkMagstd         : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
 $ fBodyAccmeanX               : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
 $ fBodyAccmeanY               : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
 $ fBodyAccmeanZ               : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
 $ fBodyAccstdX                : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
 $ fBodyAccstdY                : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
 $ fBodyAccstdZ                : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
 $ fBodyAccmeanFreqX           : num  -0.1588 -0.0495 0.0865 -0.2075 -0.3074 ...
 $ fBodyAccmeanFreqY           : num  0.0975 0.0759 0.1175 0.1131 0.0632 ...
 $ fBodyAccmeanFreqZ           : num  0.0894 0.2388 0.2449 0.0497 0.2943 ...
 $ fBodyAccJerkmeanX           : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
 $ fBodyAccJerkmeanY           : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
 $ fBodyAccJerkmeanZ           : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
 $ fBodyAccJerkstdX            : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
 $ fBodyAccJerkstdY            : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
 $ fBodyAccJerkstdZ            : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
 $ fBodyAccJerkmeanFreqX       : num  0.132 0.257 0.314 -0.209 -0.253 ...
 $ fBodyAccJerkmeanFreqY       : num  0.0245 0.0475 0.0392 -0.3862 -0.3376 ...
 $ fBodyAccJerkmeanFreqZ       : num  0.02439 0.09239 0.13858 -0.18553 0.00937 ...
 $ fBodyGyromeanX              : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
 $ fBodyGyromeanY              : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
 $ fBodyGyromeanZ              : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
 $ fBodyGyrostdX               : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
 $ fBodyGyrostdY               : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
 $ fBodyGyrostdZ               : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
 $ fBodyGyromeanFreqX          : num  -0.00355 0.18915 -0.12029 0.01478 -0.10045 ...
 $ fBodyGyromeanFreqY          : num  -0.0915 0.0631 -0.0447 -0.0658 0.0826 ...
 $ fBodyGyromeanFreqZ          : num  0.010458 -0.029784 0.100608 0.000773 -0.075676 ...
 $ fBodyAccMagmean             : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
 $ fBodyAccMagstd              : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
 $ fBodyAccMagmeanFreq         : num  0.0864 0.2367 0.2846 0.1906 0.1192 ...
 $ fBodyBodyAccJerkMagmean     : num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
 $ fBodyBodyAccJerkMagstd      : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
 $ fBodyBodyAccJerkMagmeanFreq : num  0.2664 0.3519 0.4222 0.0938 0.0765 ...
 $ fBodyBodyGyroMagmean        : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
 $ fBodyBodyGyroMagstd         : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
 $ fBodyBodyGyroMagmeanFreq    : num  -0.139775 -0.000262 -0.028606 0.268844 0.349614 ...
 $ fBodyBodyGyroJerkMagmean    : num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
 $ fBodyBodyGyroJerkMagstd     : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...
 $ fBodyBodyGyroJerkMagmeanFreq: num  0.176 0.185 0.334 0.191 0.19 ...
 - attr(*, "vars")=List of 1
  ..$ : symbol Subject
 - attr(*, "drop")= logi TRUE
 ```

### Variables present in the dataset

#### Variable 1: Subject

Thirty subjects took part in the study. Each one is identified by a number from 1 to 30. Each one appears six times in the Subject column of the tidy dataset, once for each activity in the second column.

* Class: int
* Unique values: 30 (the integers 1 to 30)
* Units: None

#### Variable 2: Activity

Six activities were performed by each of the subjects. Video was recorded so that the sensor signals could be manually matched with the activity types. Each activity was performed multiple times by each subject, and the tidy dataset contains the average of these multiples.

* Class: factor
* Levels: 6
* Values: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS

#### Variables 3-79: the movement measurements (features)

The accelerometer and gyroscope in the Samsung Galaxy S II capture many different types of movement. To quote features_info.txt from the UCI HAR folder:
```
Feature Selection 

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
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
```

The subset of variables whose mean values were used in the tidy data file for this Getting and Cleaning Data project:
* tBodyAccmeanX
* tBodyAccmeanY
* tBodyAccmeanZ
* tBodyAccstdX
* tBodyAccstdY
* tBodyAccstdZ
* tGravityAccmeanX
* tGravityAccmeanY
* tGravityAccmeanZ
* tGravityAccstdX
* tGravityAccstdY
* tGravityAccstdZ
* tBodyAccJerkmeanX
* tBodyAccJerkmeanY
* tBodyAccJerkmeanZ
* tBodyAccJerkstdX
* tBodyAccJerkstdY
* tBodyAccJerkstdZ
* tBodyGyromeanX
* tBodyGyromeanY
* tBodyGyromeanZ
* tBodyGyrostdX
* tBodyGyrostdY
* tBodyGyrostdZ
* tBodyGyroJerkmeanX
* tBodyGyroJerkmeanY
* tBodyGyroJerkmeanZ
* tBodyGyroJerkstdX
* tBodyGyroJerkstdY
* tBodyGyroJerkstdZ
* tBodyAccMagmean
* tBodyAccMagstd
* tGravityAccMagmean
* tGravityAccMagstd
* tBodyAccJerkMagmean
* tBodyAccJerkMagstd
* tBodyGyroMagmean
* tBodyGyroMagstd
* tBodyGyroJerkMagmean
* tBodyGyroJerkMagstd
* fBodyAccmeanX
* fBodyAccmeanY
* fBodyAccmeanZ
* fBodyAccstdX
* fBodyAccstdY
* fBodyAccstdZ
* fBodyAccmeanFreqX
* fBodyAccmeanFreqY
* fBodyAccmeanFreqZ
* fBodyAccJerkmeanX
* fBodyAccJerkmeanY
* fBodyAccJerkmeanZ
* fBodyAccJerkstdX
* fBodyAccJerkstdY
* fBodyAccJerkstdZ
* fBodyAccJerkmeanFreqX
* fBodyAccJerkmeanFreqY
* fBodyAccJerkmeanFreqZ
* fBodyGyromeanX
* fBodyGyromeanY
* fBodyGyromeanZ
* fBodyGyrostdX
* fBodyGyrostdY
* fBodyGyrostdZ
* fBodyGyromeanFreqX
* fBodyGyromeanFreqY
* fBodyGyromeanFreqZ
* fBodyAccMagmean
* fBodyAccMagstd
* fBodyAccMagmeanFreq
* fBodyBodyAccJerkMagmean
* fBodyBodyAccJerkMagstd
* fBodyBodyAccJerkMagmeanFreq
* fBodyBodyGyroMagmean
* fBodyBodyGyroMagstd
* fBodyBodyGyroMagmeanFreq
* fBodyBodyGyroJerkMagmean
* fBodyBodyGyroJerkMagstd
* fBodyBodyGyroJerkMagmeanFreq

## Sources:
* Hadley Wickham's Tidy Data paper:
  * http://vita.had.co.nz/papers/tidy-data.html
* UCI HAR dataset page:
  * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
