# First we will read all relevant data from our data files
file_test <- read.table("X_test.txt",header=FALSE)
file_test_labels <- read.table("y_test.txt",header=FALSE)
file_test_subject <- read.table("subject_test.txt",header=FALSE)
file_train <- read.table("X_train.txt",header=FALSE)
file_train_labels <- read.table("y_train.txt",header=FALSE)
file_train_subject <- read.table("subject_train.txt",header=FALSE)
file_features <- read.table("features.txt",header=FALSE)

# Create a vector with the names of the columns in the train and test data set
labels <- file_features[["V2"]]

# Make label names lower and remove spaces and special characters
labels <- tolower(labels)
labels <- gsub("[^A-Za-z]+","",labels)

# Assign appropriate names to the columns in file_test
names(file_test) <- labels

# Merge test data with labels and subjects from the corresponding test files
test_full <- file_test
test_full$label <- file_test_labels$V1
test_full$subject <- file_test_subject$V1

# Assign appropriate names to the columns in file_test
names(file_train) <- labels

# Merge train data with labels and subjects from the corresponding test files
train_full <- file_train
train_full$label <- file_train_labels$V1
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
meanpergroup <- full_data_table[ , lapply(.SD, mean) , by=c("label", "subject")]

write.table(full_data, file = "full_data.txt",  row.names = FALSE, col.names = TRUE)
