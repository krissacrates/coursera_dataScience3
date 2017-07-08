###################################################################
#
#
#   R code: run_analysis.R
#
#   Coursera programming assignment
#   Getting and Cleaning data
#   2017-07-08
#
# Task
# The original data set consists of training and test data with additional descriptive tables. 
# The task is to merge both data sets while only using _mean_ and _standard deviation_ variables. 
# Tag variables and activities appropriately and provide averages of variables per subjects 
# and activities in the tidy output table.
#
# Solution
#
# 1. Check if the source data for the analysis exists in the working directory. 
#    If not, download the ZIP file with the source data and unzip.
# 2. Load the descriptive data from supplementary tables (features, activity labels) 
#    and prepare them for use.
# 3. Load the training dataset with subsetted columns that are of interest (mean and std). 
#    Merge with subject and activities properly.
# 4. Repeat the process in 3. with test dataset.
# 5. Merge complete training and test datasets into in data frame.
# 6. Create a new data frame with the averages for each subject and activity.
# 7. Write the final table to the txt file and store it in the working directory.
#
#
##################################################################



## 1.  Check if the source files exists in the working directory
# Download original data for the analysis in case they don't exist
if (!dir.exists(paste0(getwd(), "/UCI HAR Dataset"))) {
    message("Downloading source data...")
    filePath <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(filePath, destfile = "dataset.zip", method = "curl")   # download a zipped file fromt he source
    unzip("dataset.zip")    # unpack the file into directories and files
    unlink("dataset.zip")   # deletes the ZIP file saving space
    message("Source data downloaded!")
}

# Prepare `dplyr` package to use
if (!require(dplyr)) install.packages(dplyr)
library(dplyr)


## 2. Load descriptive data
message("I am cleaning your messy data. Give me a second...")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
columnsToLoad <- grep(".*(mean|std).*", features$V2, value = FALSE)
columnNames <- features[columnsToLoad, 2]

## 3. Load training dataset
training_set <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                           stringsAsFactors = FALSE)[columnsToLoad]
colnames(training_set) <- columnNames
training_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                               stringsAsFactors = FALSE, col.names = "subject")
training_activities <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                                  stringsAsFactors = FALSE, col.names = "activity")
training_setComplete <- cbind(training_subject, training_activities, training_set)

## 4. Load testing dataset
testing_set <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                          stringsAsFactors = FALSE)[columnsToLoad]
colnames(testing_set) <- columnNames
testing_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                              stringsAsFactors = FALSE, col.names = "subject")
testing_activities <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                                 stringsAsFactors = FALSE, col.names = "activity")
testing_setComplete <- cbind(testing_subject, testing_activities, testing_set)

## 5. Merge datasets and label activities
message("Looks good! I am preparing your output file...")
master.df <- rbind(training_setComplete, testing_setComplete)
master.df$activity <- factor(master.df$activity, 
                               levels = activity_labels$V1, labels = activity_labels$V2)
master.df$subject <- as.factor(master.df$subject)

## 6. Create output file with averages
outputFile <- master.df %>% 
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

## 7. write into external file
write.table(outputFile, file = "tidy-output.txt", row.names = FALSE, quote = FALSE)
message("Your 'tidy-output.txt' is ready in your working directory. That's it!")


# End of Code
