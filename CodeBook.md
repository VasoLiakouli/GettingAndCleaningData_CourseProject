The dataset includes the following files:
=========================================

- 'CodeBook.md'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'data_labels.txt': activity labels with the simplified activity label used in the R script.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


Transformations used: 
======
- Created a set of descriptive names for all activities and stored under labels vector
- Created a new data frame for train and test data including the subject id and activity type from the corresponding files
- Renamed the column names for the train and test data sets in order to use the descriptive names 
- Merged under one full data set the train and test data sets
- Calculated average and standard deviation for all activities
- Calculated average for all activities per activity type and subject

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws
