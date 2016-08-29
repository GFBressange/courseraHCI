## merging training and test sets to a data file called "uciharDataset".
## the working directory is set to be "UCI HAR Dataset" containing activiy_labels.txt, 
## features.txt, features_info.txt, README.txt and the "test" and "train" subdirectories.

## reading test files
testSubjectsIds <- read.csv("./test/subject_test.txt", header = FALSE)
testActivityIds <- read.csv("./test/Y_test.txt", header = FALSE)
testMeasurements <- read.table("./test/X_test.txt", header = FALSE)

## merging test files
datatest <-  data.frame(testSubjectsIds, testActivityIds, testMeasurements)

## reading train files
trainSubjectsIds <- read.csv("./train/subject_train.txt", header = FALSE)
trainActivityIds <- read.csv("./train/Y_train.txt", header = FALSE)
trainMeasurements <- read.table("./train/X_train.txt", header = FALSE)

## merging train files
datatrain <- data.frame(trainSubjectsIds, trainActivityIds, trainMeasurements)

## merging datatest and datatrain datasets in the data frame dataset
dataset <- rbind(datatest, datatrain)

## reading names of the 561 variables
variablesNames <- read.table("features.txt", header = FALSE, sep = " ", stringsAsFactors = FALSE)

## Attributing names to variables
## It would be better to keep the measurements variables from 1 to 561 and push
## Subject and Activity variables at the end: 562 and 563
colnames(dataset) <- c("Subject", "Activity", variablesNames[, 2])

## Subsetting only the measurements on the mean and standard deviation for each measurement
list <- colnames(dataset)               # search for the variables whose names contains Mean, mean
good <- grep("[Mm]ean|[Ss]td",list)     # or Std, std.
listgood <- list[good]
dataset <- dataset[ ,c("Subject", "Activity", listgood)]        # subsetting keeping only mean and 
                                                                # standard deviation variables

## reading activity labels
activityLabels <- read.csv("activity_labels.txt", header = FALSE)

dataset$Activity <- as.factor(dataset$Activity) # transform Activity variable as a factor
# may be better:
# dataset <- transform(dataset, Activity = factor(Activity))
temp <- read.csv("activity_labels.txt", header = FALSE, sep = " ")

## Attributing names to Activities
colnames(temp) <- c("ActivityId", "ActivityName")
listActivities <- temp$ActivityName
levels(dataset$Activity) <- listActivities # change factor levels names of the Activity factor

## Creating a second independent tidy data set with the average of each variable for each activity 
## and each subject
library(dplyr)
tidydataset <- dataset %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
