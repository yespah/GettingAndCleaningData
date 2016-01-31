if (!file.exists("UCI HAR Dataset")){
  zipurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(zipurl, destfile = "UCI_HAR.zip", method = "curl")
  unzip("UCI_HAR.zip")
  rm("UCI_HAR.zip")
}


test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
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
# Adding Subject and Activity column
filtered_data <- cbind(subject_data, activity, filtered_data)
# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
filtered_data$Activity <- factor(filtered_data$Activity,
                    levels = c(1,2,3,4,5,6),
                    labels = activity_labels[,2]) 
# 4. Appropriately labels the data set with descriptive variable names.
  # See labeling above in #1 and desciption in features_list.txt

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- filtered_data %>% group_by(Subject) %>%  group_by(Activity) %>% summarise_each(funs(mean))
