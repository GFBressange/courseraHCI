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
colnames(dataset) <- c("Subject", "Activity", variablesNames[, 2])

## Subsetting only the measurements on the mean and standard deviation 
## for each measurement. Search for the variables whose names contains Mean, mean 
## or Std, std.
list <- colnames(dataset)               
good <- grep("[Mm]ean|[Ss]td",list)     
listgood <- list[good]

## subsetting keeping only mean and standard deviation variables
dataset <- dataset[ ,c("Subject", "Activity", listgood)] 

## renaming activities variables
dataset[,2] <- gsub("1", "Walking", dataset[,2])
dataset[,2] <- gsub("2", "Walking.Up", dataset[,2])
dataset[,2] <- gsub("3", "Walking.Down", dataset[,2])
dataset[,2] <- gsub("4", "Sitting", dataset[,2])
dataset[,2] <- gsub("5", "Standing", dataset[,2])
dataset[,2] <- gsub("6", "Laying", dataset[,2])

## transform Activity variable as a factor
dataset$Activity <- as.factor(dataset$Activity) 

## renaming the measurements variables with descriptive names
colnames(dataset) <- gsub("^t", "time.domain.signal.",colnames(dataset))
colnames(dataset) <- gsub("^f", "frequency.domain.signal.",colnames(dataset))
colnames(dataset) <- gsub("Acc", ".acceleration",colnames(dataset))
colnames(dataset) <- gsub("-X", ".along.X.direction",colnames(dataset))
colnames(dataset) <- gsub("-Y", ".along.Y.direction",colnames(dataset))
colnames(dataset) <- gsub("-Y", ".along.Z.direction",colnames(dataset))
colnames(dataset) <- gsub("-meanFreq", ".mean.frequency",colnames(dataset))
colnames(dataset) <- gsub("gravityMean", "gravity.mean",colnames(dataset))
colnames(dataset) <- gsub("JerkMean", ".noise.mean",colnames(dataset))
colnames(dataset) <- gsub("-mean", ".mean",colnames(dataset))
colnames(dataset) <- gsub("-std", ".standard.deviation",colnames(dataset))
colnames(dataset) <- gsub("Gyro", ".gyroscopic",colnames(dataset))
colnames(dataset) <- gsub("Mag", "magnitude",colnames(dataset))
colnames(dataset) <- gsub("BodyBody", "body.to.body",colnames(dataset))
colnames(dataset) <- gsub("tBody", "time.domain.signal.body",colnames(dataset))
colnames(dataset) <- gsub("Jerk", ".noise",colnames(dataset))
colnames(dataset) <- gsub("Mean", ".mean",colnames(dataset))

## Creating a second independent tidy data set with the average of each variable for each activity 
## and each subject
library(dplyr)
tidydataset <- dataset %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
