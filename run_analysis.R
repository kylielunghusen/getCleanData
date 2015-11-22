# read files into R
xTest <- read.table("X_test.txt",header=FALSE)
xTrain <- read.table("X_train.txt",header=FALSE)
yTest <- read.table("Y_test.txt",header=FALSE)
yTrain <- read.table("Y_train.txt",header=FALSE)
subjectTest <- read.table("subject_test.txt",header=FALSE)
subjectTrain <- read.table("subject_train.txt",header=FALSE)
features <- read.table("features.txt",header=FALSE,colClasses="character")
activityLabels <- read.table("activity_labels.txt",header=FALSE,colClasses="character")

# clip together test and train data
subject <- rbind(subjectTest,subjectTrain)
x <- rbind(xTest,xTrain)
y <- rbind(yTest,yTrain)

# convert y to vector and y codes to names
y <- activityLabels[,2][y[,1]]

# give column names to x, subset x to only include mean/std cols
names(x) <- features[,2]
x <- x[, grep("mean|std", names(x))]

# clip together subject, activity, features into a single dataset
fullFrame <- cbind(subject,y,x)

# create column names and remove non-standard characters
names(fullFrame) <- c("Subject","Activity",names(x))
names(fullFrame) <- gsub(".","",make.names(names(fullFrame)),fixed=TRUE)

# group by subject and activity
grouped <- group_by(fullFrame, Subject, Activity)

# take the mean of each feature for each subject/activity pair
finalFrame <- summarise_each(grouped, funs(mean))

# Write the tidy data file to R working directory
write.table(finalFrame, file = "UCIGetCleanTidyData.txt",row.names = FALSE)
