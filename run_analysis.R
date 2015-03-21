#This Program is written for the Cource Project or Getting and Cleaning Data course from Coursera


## Problem 1 (Merges the training and the test sets to create one data set.)

install.packages ("data.table")
library (data.table)


install.packages ("plyr")
library (plyr)


## Read and Combine the two parts of the subject_data
subject_data1 <- read.table ("/UCI HAR Dataset/test/subject_test.txt")
subject_data2 <- read.table ("/UCI HAR Dataset/train/subject_train.txt")
subject_data <- rbind (subject_data1, subject_data2)

## Read and Combine the two parts of the X files
X_data1 <- read.table ("/UCI HAR Dataset/test/X_test.txt")
X_data2 <- read.table ("/UCI HAR Dataset/train/X_train.txt")
X_data <- rbind (X_data1, X_data2)

## Read and Combine the two parts of the y files
y_data1 <- read.table ("/UCI HAR Dataset/test/y_test.txt")
y_data2 <- read.table ("/UCI HAR Dataset/train/y_train.txt")
y_data <- rbind (y_data1, y_data2)

## you will see that each of these dataset have 10299 objects
str (subject_data)
str (X_data)
str (y_data)


## Problem 2 (Extracts only the measurements on the mean and standard deviation for each measurement.) 

## We now need to Extract only the measurements on the mean and standard deviation for each measurement.

## frist load the features in a vector 
features <- read.table ("/UCI HAR Dataset/features.txt")

# now match mean or std in their names and extract those variables 

mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])

## now subset the desired columns
X_data <- X_data[, mean_and_std]

## now correct the column names
names(X_data) <- features[mean_and_std, 2]


## Problem 3 (Uses descriptive activity names to name the activities in the data set)

## the names for the y_data file are in activity_labels.txt file which are
## the 1 to 6 activity names. 
activity <- read.table ("/UCI HAR Dataset/activity_labels.txt")

## This command will replace the numbers in the y_data with the activity name by
## substituting the using the value of y in the row 1 of activity file

y_data [,1] <- activity[y_data[, 1], 2]
## give name to y_data vecor
names(y_data) <- "activity"


## Problem 4 (Appropriately labels the data set with descriptive variable names)

## give name to the vector subject_data as "subject"
names(subject_data) <- "subject"

# combine all the three files by binding all the files in a single data set 
##the names are already given to all the three files
all_data <- cbind(X_data, y_data, subject_data)



## Problem 5 (From the data set in step 4, creates a second, independent tidy data set with the averages) 

# We will take means of Col 1- 66 
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)

## average_data.txt file now should be saved


