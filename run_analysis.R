# Step 0. Cleans and prepares the environment, download and aunzip the untidy data and finally sets the working directory for R.

rm(list=ls()) # Clean the environment in R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" ### Setting the source for the data file from the web
filezip <- file.path(getwd(), "UCIHARdataset.zip")
download.file(fileUrl, filezip) # Dowanload the zip file with the data. In case you work under Mac OS, you should try >- download.file(fileUrl, filezip, method = "curl")							 
date.download <- system.time ### Register the time of download
unzip(filezip, exdir = getwd()) # Unzip the data
setwd(as.character(paste(getwd(), "UCI HAR Dataset", sep="/"))) # Defines the working directory
getwd() # Check which is the working directory


# Step 1. Merges the training and the test sets to create one data set.

trainX <- read.table("./train/X_train.txt", quote="\"", comment.char="")
trainY <- read.table("./train/y_train.txt", quote="\"", comment.char="")
trainSubject <- read.table("./train/subject_train.txt", quote="\"", comment.char="")

testX <- read.table("./test/X_test.txt", quote="\"", comment.char="")
testY <- read.table("./test/y_test.txt", quote="\"", comment.char="") 
testSubject <- read.table("./test/subject_test.txt", quote="\"", comment.char="")

dataX <- rbind(trainX, testX) # Merge the data with measurements
dataY <- rbind(trainY, testY) # Merge the data with labels
dataSubj <- rbind(trainSubject, testSubject) # Merge the data with observations identification

#########################################################################################

# Step 2. Extracts only the measurements on the mean and standard deviation for
# each measurement. 

features <- read.table("./features.txt")
meanStdfeatures <- grep("mean\\(\\)|std\\(\\)", features[, 2]) # Identificates which are the desired measurements. In this case, means and standard deviations

dataX <- dataX[, meanStdfeatures] # Extraction of the pretended data.

#Changing names
names(dataX) <- gsub("\\(\\)", "", features[meanStdfeatures, 2]) # remove "()"
names(dataX) <- gsub("mean", "Mean", names(dataX)) # capitalize M
names(dataX) <- gsub("std", "Std", names(dataX)) # capitalize S
names(dataX) <- gsub("-", "", names(dataX)) # remove "-" in column names 

#########################################################################################

# Step 3. Uses descriptive activity names to name the activities in 
# the data set

activity <- read.table("./activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) # remove "-" in activities names
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) # capitalize the 8th letter of the composed name activity walking Upstairs
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) # capitalize the 8th letter of the composed name activity: walking Downstairs
activityNames <- activity[dataY[, 1], 2]
dataY[, 1] <- activityNames #Replace the codified data in the lavels dataset (dataY) with its corresponding name activities
names(dataY) <- "activity"

#########################################################################################

# Step 4. Appropriately labels the data set with descriptive activity names. 
names(dataSubj) <- "subject"
FinalData <- cbind(dataX, dataY, dataSubj)
write.table(FinalData, "merged_data.txt") # write out the 1st dataset

#########################################################################################

# Step 5
# Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject
#########################################################################################

# Extracting only averages columns with the use of the plyr packages
install.packages(plyr)
library(plyr)

Avrg_data <- ddply(FinalData, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)

##################################################################################################################################
##################################################################################################################################

