# loading the feature label values in a data frame
feature_lbl_raw <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/features.txt")

# transposing the feature label values from rows to columns and excluding the first row.
# This is being done to use as column names on x_train and x_test datasets
feature_lbl <- t(feature_lbl_raw)[2,]

# loading x_train dataset into a dataframe and updating the column names using feature_lbl array created above
x_train <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/train/x_train.txt",col.names = feature_lbl)
head(x_train)


# loading x_test dataset into a dataframe and updating the column names using feature_lbl array created above
x_test <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/test/x_test.txt",col.names = feature_lbl)
head(x_test)

# Fetching columns that contain mean and std deviation values into a dataframe
mean_feature_lbl <- feature_lbl_raw[grep("mean",feature_lbl_raw$V2),]
std_feature_lbl <- feature_lbl_raw[grep("std()",feature_lbl_raw$V2),]

# Subssetting the train and test datasets to bring mean and std deviation columns only
train_mean_feature <- x_train[,c(mean_feature_lbl$V1)]
train_mean_std_feature <- cbind(train_mean_feature, x_train[,c(std_feature_lbl$V1)])
test_mean_feature <- x_test[,c(mean_feature_lbl$V1)]
test_mean_std_feature <- cbind(test_mean_feature, x_test[,c(std_feature_lbl$V1)])

head(train_mean_std_feature)
head(test_mean_std_feature)

#reading Activity IDs for train dataset
y_train <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/train/y_train.txt",col.names ="Activity_ID")

#Checking to make sure that activity ids range from 1 through 6
unique(y_train)

# counting no of records to ensure that it aligns with no of records in x_train dataset
nrow(y_train)

#reading Activity IDs for test dataset
y_test <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/test/y_test.txt",col.names ="Activity_ID")

#Checking to make sure that activity ids range from 1 through 6
unique(y_test)

# counting no of records to ensure that it aligns with no of records in x_test dataset
nrow(y_test)

#Fetching the activity id and desription into a dataframe
activity <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/activity_labels.txt",col.names = c("Activity_ID","Activity_Description"))
activity

# Merging activity description with activity id dataset
y_train_desc <- merge(activity,y_train)

#ensuring that names are in alignment with expectation
names(y_train_desc)

# counting no of rows in y_train_desc to ensure that records are not dropped after merging data
nrow(y_train_desc)

# merging activity description with activity id dataset
y_test_desc <- merge(activity,y_test)

#ensuring that names are in alignment with expectation
names(y_test_desc)

# counting no of rows in y_test_desc to ensure that records are not dropped after merging data
nrow(y_test_desc)

# loading subject_id from train dataset
subject_train <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/train/subject_train.txt",col.names="Subject_ID")

# ensuring that subject ids range from 1 through 30
unique(subject_train)

# Ensuring that no of records is in alignment with the y_train_Desc dataset
nrow(subject_train)

# loading subject_id from test dataset
subject_test <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/test/subject_test.txt",col.names="Subject_ID")

# ensuring that subject ids range from 1 through 30
unique(subject_test)

# Ensuring that no of records is in alignment with the y_test_Desc dataset
nrow(subject_test)

# merging subject id, activity id and y train datasets
train_output <- cbind(subject_train,y_train_desc,train_mean_std_feature)

# Ensuring that names are user friendly
names(train_output)

# Ensuring that no of rows ties with number received before to ensure that records are not being dropped
nrow(train_output)

# merging subject id, activity id and y test datasets
test_output <- cbind(subject_test,y_test_desc,test_mean_std_feature)

# Ensuring that names are user friendly
names(test_output)

# Ensuring that no of rows ties with number received before to ensure that records are not being dropped
nrow(test_output)

# Appending train and test records 
output <- rbind(train_output, test_output)

# calculating average for all y train and test values for each subject and activity
result <- aggregate(output[,4:82], by = output[,1:3], FUN = "mean")

library(plyr)

# ordering the output by subject and activity
tidy_dataset <- result[with(result,order(Subject_ID,Activity_ID)),]

# writing to a file in the shared drive
write.table(tidy_dataset,file="/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/tidy_data_set.txt", row.names = FALSE)
