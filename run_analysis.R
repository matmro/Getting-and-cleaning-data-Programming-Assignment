## Programming Assignment
## ======================

# setwd to be exlucded for solution
setwd("C:/Users/Matt/Studies/Specialization-Data-Science/03-Getting-and-cleaning-data/Programming-Assignment")

# required libraries
library(data.table)
library(dplyr)
library(tidyr)


## read in data, check content and dimensions (analogous for train and test)
## =========================================================================
#  Find out about dimensions and content of the individual datasets in order 
#  to properly fit them together: 
# 
#  Content: 
#  - features: contains column names for X_train dataset
#  - X_train: contains the actual data
#  - y_train: labels the activity on which data has been collected
#  - subject_train: labels the individual that performed an activity
#
#  Dimensions: 
#  I do not consider the datasets found in the data folder "Inertial Signs", 
#  since they are raw data which are not used in the later steps (for the sake 
#  of completeness, the "inertial" data sets have dimensions 7352 x 128 each). 

# dim 561 2
features <- read.table("./UCI HAR Dataset/features.txt")

# dim 7352 561
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt") 
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
# dim 7352 1
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")


## merge data (analogous for train and test)
## =========================================
#  Name the dataset columns and merge the sets

## train =====================
#  1. name the columns
names(X_train) <- make.names(features[, 2], unique = TRUE)
names(y_train) <- "TypeOfActivity"
names(subject_train) <- "Subject"
#  2. merge the datasets
DT_train <- cbind(y_train, subject_train)
DT_train <- cbind(DT_train, X_train[, 1:554])
#  3. remove unnecessary data
rm(X_train, subject_train, y_train)

## test ======================
#  1. name the columns 
names(X_test) <- make.names(features[, 2], unique = TRUE)
names(y_test) <- "TypeOfActivity"
names(subject_test) <- "Subject"
#  2. merge the datasets
DT_test <- cbind(y_test, subject_test)
DT_test <- cbind(DT_test, X_test[, 1:554])
#  3. remove unnecessary data
rm(X_test, subject_test, y_test)

## merge train and test =======
DT <- rbind(DT_train, DT_test)
rm(DT_train, DT_test, features)


## Step 2
## ======
# In this step I only extract measurements on mean and std. 
# For that purpose I use grep to extract the strings 'mean'
# and 'std' from column names. 
DT <- cbind(DT[,1:2],
            DT[, grep("mean", ignore.case = TRUE, names(DT))], 
            DT[, grep("std", ignore.case = TRUE, names(DT))])

## Step 3
## ======
## Using descriptive activity names to name the activities: 



















