# GettingAndCleaningData

Checks if data is present, then loads relevant data.

# 1. Merges the training and the test sets to create one data set.

merged_data <- rbind(test_data,train_data)
subject_data <- rbind(test_subject,train_subject)
activity <- rbind(test_activity,train_activity)
  # 4. Appropriately labels the data set with descriptive variable names.
  names(merged_data) <- features[,2]
  names(subject_data) <- "Subject"
  names(activity) <- "Activity"
# Connecting all columns
fully_merged <- cbind(subject_data, activity, merged_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)
filtered_features <- filter(features,(grepl("std()",names(merged_data))|grepl("mean()",names(merged_data))),!(grepl("meanFreq",names(merged_data))))
filtered_data <- merged_data[,filtered_features[,1]]

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
merged_data$Activity <- factor(merged_data$Activity,
                    levels = c(1,2,3,4,5,6),
                    labels = activity_labels[,2]) 
