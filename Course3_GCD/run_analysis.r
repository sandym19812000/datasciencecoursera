feature_lbl_raw <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/features.txt")
feature_lbl <- t(feature_lbl_raw)[2,]

x_train <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/train/x_train.txt",col.names = feature_lbl)
head(x_train)

x_test <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/test/x_test.txt",col.names = feature_lbl)
head(x_test)


mean_feature_lbl <- feature_lbl_raw[grep("mean",feature_lbl_raw$V2),]
std_feature_lbl <- feature_lbl_raw[grep("std()",feature_lbl_raw$V2),]

train_mean_feature <- x_train[,c(mean_feature_lbl$V1)]
train_mean_std_feature <- cbind(train_mean_feature, x_train[,c(std_feature_lbl$V1)])

test_mean_feature <- x_test[,c(mean_feature_lbl$V1)]
test_mean_std_feature <- cbind(test_mean_feature, x_test[,c(std_feature_lbl$V1)])


head(train_mean_std_feature)
head(test_mean_std_feature)

y_train <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/train/y_train.txt",col.names ="Activity_ID")
unique(y_train)
nrow(y_train)

y_test <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/test/y_test.txt",col.names ="Activity_ID")
unique(y_test)
nrow(y_test)


activity <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/activity_labels.txt",col.names = c("Activity_ID","Activity_Description"))
activity

y_train_desc <- merge(activity,y_train)
names(y_train_desc)
nrow(y_train_desc)

y_test_desc <- merge(activity,y_test)
names(y_test_desc)
nrow(y_test_desc)


subject_train <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/train/subject_train.txt",col.names="Subject_ID")
unique(subject_train)
nrow(subject_train)

subject_test <- read.table("/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/UCI HAR Dataset/test/subject_test.txt",col.names="Subject_ID")
unique(subject_test)
nrow(subject_test)


train_output <- cbind(subject_train,y_train_desc,train_mean_std_feature)
names(train_output)

test_output <- cbind(subject_test,y_test_desc,test_mean_std_feature)
names(test_output)

output <- rbind(train_output, test_output)

result <- aggregate(output[,4:82], by = output[,1:3], FUN = "mean")
library(plyr)
tidy_dataset <- result[with(result,order(Subject_ID,Activity_ID)),]
tidy_dataset
write.table(tidy_dataset,file="/Users/Sandman/MOOC/Getting and Cleaning Data/Course Project/Data/tidy_data_set.txt", row.names = FALSE)
