# GettingAndCleaningData_CourseProject

This project includes an R script (run_analysis.R) that reads the files stored under the Data folder and performs cleansing and data analysis.

The following steps are used:
Step 1 -- Read all files in R
Step 2 -- Create short-descriptive labels from the features.txt file
Step 3 -- Rename labels in both train and test data sets based on the short-descriptive labels created in step 2
Step 4-- Merge train and test data sets with the respective data related to activity type (data are included under y_train.txt and y_test.txt files)
Step 5 -- Merge train and test data sets with the respective data related to subject id (data are included under subject_train.txt and subject_test.txt files)
Step 6 -- Merge both train and test data created under Step 4 and Step 5 under one complete dataset
Step 7 -- Calculate standard deviation and mean and store in a new statistics data set
Step 8 -- Calculate average per subject and activity (label) and store under a new meanpergroup data set