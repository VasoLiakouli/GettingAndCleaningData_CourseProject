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

# Step 1 - Read all data from relevant files in R
file_test <- read.table("X_test.txt",header=FALSE)
file_test_labels <- read.table("y_test.txt",header=FALSE)
file_test_subject <- read.table("subject_test.txt",header=FALSE)
file_train <- read.table("X_train.txt",header=FALSE)
file_train_labels <- read.table("y_train.txt",header=FALSE)
file_train_subject <- read.table("subject_train.txt",header=FALSE)
file_features <- read.table("features.txt",header=FALSE)
file_activitylabels <- read.table("activity_labels.txt",header=FALSE)

# Step 2 - Assign headers to activity related files
# Add header to file_activitylabels dataframe
names(file_activitylabels) <- c("activityid","activity")

# Add header to file_train_labels dataframe
names(file_train_labels) <- c("activityid")

# Add header to file_test_labels dataframe
names(file_test_labels) <- c("activityid")

# Create a vector with the names of the columns in the train and test data set
labels <- file_features[["V2"]]

# Assign appropriate names to the columns in file_test
names(file_test) <- labels

# Assign appropriate names to the columns in file_train
names(file_train) <- labels


# Step 3 -- Identify only measures related to standard deviation and mean from the full set of measures available in train and test files
# Extract only measurements with standard deviation and mean from labels 
measures <- labels[grep("[Mm][Ee][Aa][Nn]\\(\\)|[Ss][Tt][Dd]\\(\\)",labels)]


# Step 4 -- Extract only measurements that exist under labels (mean and standard deviation) from train and test files
test_full <- file_test[measures]
train_full <- file_train[measures]

# Step 5 -- Merge with activity file, subject file and activity labels file
# Merge test data with labels and subjects from the corresponding test files
test_full$activityid <- file_test_labels$activityid
test_full$subject <- file_test_subject$V1
test_data <- merge(test_full, file_activitylabels, by.x="activityid", by.y="activityid",all.x=TRUE,all.y=FALSE,sort=FALSE)

# Merge train data with labels and subjects from the corresponding test files
train_full$activityid <- file_train_labels$activityid
train_full$subject <- file_train_subject$V1
train_data <- merge(train_full, file_activitylabels, by.x="activityid", by.y="activityid",all.x=TRUE,all.y=FALSE,sort=FALSE)

# Step 6 -- Merge both train and test data created under Step 4 and Step 5 under one complete dataset
# Merge test and train data under one data set
full_data <- rbind(test_data,train_data)

# Step 7 -- Calculate average per subject and activity (label) and store under a new meanpergroup data set
# Create new data set with average per activity and subject
# Load data.table library
library(data.table)
full_data_table <- as.data.table(full_data)
meanpergroup <- full_data_table[ , lapply(.SD, mean) , by=c("activity", "subject")]

write.table(meanpergroup, file = "meanpergroup.txt",  row.names = FALSE, col.names = TRUE)
