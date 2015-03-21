---
title: "CodeBook"
output: html_document
---
 
 
##Getting and Cleaning Data - Cource Project##
 
 This project required 'data.table' and 'plyr' packages so please install them first
 
 
install.packages ("data.table")
library (data.table)

install.packages ("plyr")
library (plyr)

### Explanation of the data ###
Here I am first listing the different files which are provided in the dataset given in the project

        		
				
Activity_labels	- Labels for the various activitie              Variables # 6	
features_info	- Text Information	                        Variables # none
features.txt	- Names for the Features given in X_all file    Variables # 561	
				
Subject_all	subject_test		        Variables # 2947	
	        subject_train		        Variables # 7352	
				
X_all	        X_text                          Variables # 2947 Col -561
	        X_train		                Variables # 7352 Col -561
				
y_all	        y_test		                Variables # 2947	
	        y_train		                Variables # 7352	
				
As you can see the files link up, the three main files have the same number of rows (10299) once the test and train data are added together. and the features number (561) matches with the columns in the X_all file columns.

In the firsr stage we combine the test and train files to create a single file for each type with 10299 rows. We will also read the Activity and the features file in their own vectors

### Combining the data ###

Read and Combine the two parts of the subject_data
subject_data1 <- read.table ("file path/subject_test.txt")
subject_data2 <- read.table ("file path/subject_train.txt")
subject_data <- rbind (subject_data1, subject_data2)

Read and Combine the two parts of the X files
X_data1 <- read.table ("file path/X_test.txt")
X_data2 <- read.table ("file path/X_train.txt")
X_data <- rbind (X_data1, X_data2)

Read and Combine the two parts of the y files
y_data1 <- read.table ("file path/y_test.txt")
y_data2 <- read.table ("file path/y_train.txt")
y_data <- rbind (y_data1, y_data2)


### Subseting and giving correct names to the data ###


frist load the features in a vector 
features <- read.table ("file path/features.txt")

the names for the y_data file are in activity_labels.txt file which are
the 1 to 6 activity names. 
activity <- read.table ("file path/activity_labels.txt")



In the part 2 of the problem we are asked to extract only the mean and stard deviation values from the X_data file. For this we use the grep() command to filter the features list. The output of this file is a vector with column names which match the contains values of 'mean' and 'std'. 

Keep in mind to modify the command to remove the values of meanFreq which too will get filtered with grep(). The use the vector to subset the columns we need and then assign the right column names



mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])

now subset the desired columns
X_data <- X_data[, mean_and_std]

now correct the column names
names(X_data) <- features[mean_and_std, 2]


now we can assign the activity types by using the number to activity relation in the activity file and substituting it to the values in the y_data file. Also assign the lable to the last file remaining and combine all the vectors to make the full dataset.

### Combinig the different files to create one data file with right names ###

y_data [,1] <- activity[y_data[, 1], 2]
give name to y_data vecor
names(y_data) <- "activity"
give name to the vector subject_data as "subject"
names(subject_data) <- "subject"

combine all the three files by binding all the files in a single data set 
all_data <- cbind(X_data, y_data, subject_data)


### Exporting the mean of the given variables ###

The last part requires us to cacluate mean across all the variables. Make sure you dont calcualte mean of the last 2 columns which are for activities and subjects. Then export the file 


averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)


This will complete the exercise


Thanks
