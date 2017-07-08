
# Check if the source files exists in the working directory
# Download original data for the analysis in case they don't exist
if (!dir.exists(paste0(getwd(), "/UCI HAR Dataset"))) {
    message("Downloading source data...")
    filePath <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(filePath, destfile = "dataset.zip", method = "curl")   # download a zipped file fromt he source
    unzip("dataset.zip")    # unpack the file into directories and files
    unlink("dataset.zip")   # deletes the ZIP file saving space
    message("Source data downloaded!")
}

# Load descriptive data
message("I am cleaning your messy data. Give me a second...")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
columnsToLoad <- grep(".*(mean|std).*", features$V2, value = FALSE)
columnNames <- features[columnsToLoad, 2]

# Load training dataset
training_set <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                           stringsAsFactors = FALSE)[columnsToLoad]
colnames(training_set) <- columnNames
training_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                               stringsAsFactors = FALSE, col.names = "subject")
training_activities <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                                  stringsAsFactors = FALSE, col.names = "activity")
training_setComplete <- cbind(training_subject, training_activities, training_set)

#Load testing dataset
testing_set <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                          stringsAsFactors = FALSE)[columnsToLoad]
colnames(testing_set) <- columnNames
testing_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                              stringsAsFactors = FALSE, col.names = "subject")
testing_activities <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                                 stringsAsFactors = FALSE, col.names = "activity")
testing_setComplete <- cbind(testing_subject, testing_activities, testing_set)

#Merge datasets and lable activities
message("Looks good! I am writing the final dataset to the output file...")
output_data <- rbind(training_setComplete, testing_setComplete)
output_data$activity <- factor(output_data$activity, 
                               levels = activity_labels$V1, labels = activity_labels$V2)

#write into external file
write.table(output_data, file = "tidy-output.txt", row.names = FALSE, quote = FALSE)
message("Your 'tidy-output.txt' is ready in your working directory.")
