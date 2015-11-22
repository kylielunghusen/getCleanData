# Course Project for Getting and Cleaning Data - README

## Files

1. run_analysis.R - the script for creating the tidy dataset

2. README.md - this file. Explains the script and associated files

3. CodeBook.md - contains information about the variables in the tidy dataset

4. UCIGetCleanTidyData.R - tidy data file, as submitted on Coursera project page

## Raw Data
* The raw data from which this tidy dataset is derived can be found at the following location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* README for the raw data is in README.txt in the UCI HAR zip file, and also here:
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names

* More information about the features data is in features_info.txt in the UCI HAR zip file.

* More information about the data used to create the tidy data file is in [CodeBook.md](https://github.com/kylielunghusen/getCleanData/blob/master/CodeBook.md) in this repo.

## How to run the script

### Command:
`> source("run_analysis.R")`

###Functionality:
Necessary files are read into R:
```
xTest <- read.table("X_test.txt",header=FALSE)
xTrain <- read.table("X_train.txt",header=FALSE)
yTest <- read.table("Y_test.txt",header=FALSE)
yTrain <- read.table("Y_train.txt",header=FALSE)
subjectTest <- read.table("subject_test.txt",header=FALSE)
subjectTrain <- read.table("subject_train.txt",header=FALSE)
```
Some of the files must be coerced to character class when read:
```
features <- read.table("features.txt",header=FALSE,colClasses="character")
activityLabels <- read.table("activity_labels.txt",header=FALSE,colClasses="character")
```
Bind together by rows the test and train data for each of the X, Y and subject datasets. This fulfils project requirement: "Merges the training and the test sets to create one data set.":
```
subject <- rbind(subjectTest,subjectTrain)
x <- rbind(xTest,xTrain)
y <- rbind(yTest,yTrain)
```
Convert Y data from a single-column data frame of integer codes to a vector of activity labels. This fulfiles project requirement: "Uses descriptive activity names to name the activities in the data set":
```
y <- activityLabels[,2][y[,1]] # convert y to vector and y codes to names
```
The values in the second column of the features data frame are used as column names for the X dataset:
```
names(x) <- features[,2] # give column names to x
```
X data is subsetted to only contain columns with "mean" or "std" in the name. This fulfils project requirement: "Extracts only the measurements on the mean and standard deviation for each measurement.":
```
x <- x[, grep("mean|std", names(x))] # shrink x to only include mean/std cols
```
Bind together by columns the subject, Y and X datasets:
```
fullFrame <- cbind(subject,y,x) # clip together subject, activity, mean/std cols
```
Give names to all columns, and remove non-standard characters such as brackets and hyphens. This fulfils project requirement: "Appropriately labels the data set with descriptive variable names.":
```
names(fullFrame) <- c("Subject","Activity",names(x)) # create column names
names(fullFrame) <- gsub(".","",make.names(names(fullFrame)),fixed=TRUE)
```
Group the data by subject and activity. Each combination has multiple rows:
```
grouped <- group_by(fullFrame, Subject, Activity)
```
For each combination of subject and activity, take the mean of all values in each column, leaving a single row per combination. This fulfils project requirement: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.":
```
finalFrame <- summarise_each(grouped, funs(mean))
```
Write the tidy data file to R working directory. This is the file that is uploaded to the Coursera project page:
```
write.table(finalFrame, file = "UCIGetCleanTidyData.txt",row.names = FALSE)
```

## How to read the tidy data file into R
`> read.table(file = "UCIGetCleanTidyData.txt", header = TRUE)`

## Notes

The script assumes that all files are in same directory.

Dplyr package must be installed before running the script.

Files used by the script:
* X_test.txt - features data for test set
* X_train.txt - features data for train set
* Y_test.txt - activities data for test set
* Y_train.txt - activities data for train set
* subject_test.txt - subject data for test set
* subject_train.txt - subject data for train set
* features.txt - list of all features, used as column names for the X data
* activity_labels.txt - list of activities, corresponds to the integer codes in the Y data
	
The files fit together in the following way (before being subsetted and summarised):
* subject_test.txt and subject_train.txt have a total 10299 values, which make up the first column
* Y_test.txt and Y_train.txt have a total 10299 values, which make up the second column
* X_test.txt and X_train.txt make a frame 10299 x 561, which make up the third to 563rd columns
* features.txt makes a frame 561 x 2, of which the second column forms the column names for the X_test and X_train data
* columns 1 and 2 are named manually - "Subject" and "Activity"
* activity_labels.txt makes a frame 6 x 2, of which the second column's six unique values replace the integers 1 to 6 in the Activity data

The files in the Inertial Signals folders are excluded for efficiency, because none of them contain "mean" or "std" data, so even if included they would only be removed again during the subsetting phase.

The variables are given descriptive names by matching the 561 features listed in features.txt with the 561 columns in X_text.txt and X_train.txt, and non-standard characters are removed using the gsub() and make.names() functions. The names are descriptive because instead of just column numbers, they signify the measured components of each feature (t/f for time/frequency, body/gravity for the motion components, acc/gyro for the sensor signals etc).

In the absence of clarification, all feature names containing "mean" or "std" have been chosen (eg "meanFreq" counts as "mean"), on the grounds that it's better to err on the side of providing too much information rather than not enough. The hypothetical user of the tidy data file can ignore any data they don't want, but can't use data that hasn't been provided.

As per David Hood (https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment) and Hadley Wickham (http://vita.had.co.nz/papers/tidy-data.html), both long and wide forms are considered tidy. Wide form has been chosen here, simply for personal preference as a 3NF data analyst.

Original data has errors causing non-unique column names. Chosen method of avoiding this problem was to cull mean/std via grep before running dplyr.

When the result is viewed simply as a text file, it does not look ‘tidy’ to the human eye, but as data it is tidy by definition because it meets the requirements laid out by Hadley Wickham:
* Each variable forms a column
* Each observation forms a row
* The data set contains information on only one observational unit of analysis (human movement)

