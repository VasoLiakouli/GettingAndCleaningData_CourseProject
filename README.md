# GettingAndCleaningData_CourseProject

This project includes an R script (run_analysis.R) that reads the files stored under the Data folder and performs cleansing and data analysis.

The following steps are used:

Step 1 -- Read all relevant files for test and train data in R

Step 2 -- Add headers in activity labels related files to use later in merges

Step 3 -- Identify only measures related to standard deviation and mean from the full set of measures available in train and test files

Step 4 -- Retrieve only relevant measures from test and train data

Step 5 -- Merge train and test data sets with the respective data related to activity type and subject id (data are included under y_train.txt, y_test.txt and subject_train.txt,  subject_test.tx files respectively). Merge them also with the activity description file to retrieve activity description within the data sets

Step 6 -- Merge both train and test data created under Step 4 and Step 5 under one complete dataset

Step 7 -- Calculate average per subject and activity (label) and store under a new meanpergroup data set

