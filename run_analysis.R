# First we will read all relevant data from our data files
if (!file.exists("X_test.txt")) {
  cat("The file X_test.txt does not exist under the working folder")
  stop("Missing file")
} 
if (!file.exists("y_test.txt")) {
  cat("The file y_test.txt does not exist under the working folder")
  stop("Missing file")
} 
if (!file.exists("subject_test.txt")) {
  cat("The file subject_test.txt does not exist under the working folder")
  stop("Missing file")
} 
if (!file.exists("X_train.txt")) {
  cat("The file X_train.txt does not exist under the working folder")
  stop("Missing file")
} 
if (!file.exists("y_train.txt")) {
  cat("The file y_train.txt does not exist under the working folder")
  stop("Missing file")
} 
if (!file.exists("subject_train.txt")) {
  cat("The file subject_train.txt does not exist under the working folder")
  stop("Missing file")
} 
if (!file.exists("features.txt")) {
  cat("The file features.txt does not exist under the working folder")
  stop("Missing file")
} 
if (!file.exists("activity_labels.txt")) {
  cat("The file activity_labels.txt does not exist under the working folder")
  stop("Missing file")
} 

file_test <- read.table("X_test.txt",header=FALSE)
file_test_labels <- read.table("y_test.txt",header=FALSE)
file_test_subject <- read.table("subject_test.txt",header=FALSE)
file_train <- read.table("X_train.txt",header=FALSE)
file_train_labels <- read.table("y_train.txt",header=FALSE)
file_train_subject <- read.table("subject_train.txt",header=FALSE)
file_features <- read.table("features.txt",header=FALSE)
file_activitylabels <- read.table("activity_labels.txt",header=FALSE)

# Add header to file_activitylabels dataframe
names(file_activitylabels) <- c("activityid","activity")

# Add header to file_train_labels dataframe
names(file_train_labels) <- c("activityid")

# Add header to file_test_labels dataframe
names(file_test_labels) <- c("activityid")

# Merge file_test_labels with file_activitylabels based on activityid to get the description of the activity
test_activities <- merge(file_test_labels, file_activitylabels, by.x="activityid", by.y="activityid")

# Merge file_train_labels with file_activitylabels based on activityid to get the description of the activity
train_activities <- merge(file_train_labels, file_activitylabels, by.x="activityid", by.y="activityid")

# Create a vector with the names of the columns in the train and test data set
labels <- file_features[["V2"]]

# Make label names lower and remove spaces and special characters
labels <- tolower(labels)
labels <- gsub("[^A-Za-z]+","",labels)

# Assign appropriate names to the columns in file_test
names(file_test) <- labels

# Merge test data with labels and subjects from the corresponding test files
test_full <- file_test
test_full$activity <- test_activities$activity
test_full$subject <- file_test_subject$V1

# Assign appropriate names to the columns in file_test
names(file_train) <- labels

# Merge train data with labels and subjects from the corresponding test files
train_full <- file_train
train_full$activity <- train_activities$activity
train_full$subject <- file_train_subject$V1

# Merge test and train data under one data set
full_data <- rbind(test_full,train_full)


# Calculate Standard Deviation of all columns and store in new dataframe
standarddev <- sapply(full_data[labels], sd)
meanval <- sapply(full_data[labels], mean)
statistics <- data.frame(labels,standarddev,meanval)
names(statistics) <- c("measurement","standarddeviation","meanvalue")

# Create new data set with average per activity and subject
# Load data.table library
library(data.table)
full_data_table <- as.data.table(full_data)
meanpergroup <- full_data_table[ , lapply(.SD, mean) , by=c("activity", "subject")]

write.table(meanpergroup, file = "meanpergroup.txt",  row.names = FALSE, col.names = TRUE)
