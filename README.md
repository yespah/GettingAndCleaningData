# GettingAndCleaningData

Checks if data is present, then loads relevant data.

Uses rbind() and cbind() to merge the training and the test sets to create one data set.
Sets the column names from the descriptive files in the data set.

Uses filter() from dplyr library and grepl() to extract columns containing mean() and std() variables.

Uses activity_labels.txt to give descriptive activity names to activities in the data set
