# read data
library(dplyr)

Subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
testX<- read.table("./UCI HAR Dataset/test/X_test.txt")
testY<- read.table("./UCI HAR Dataset/test/y_test.txt")

Subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
trainX<- read.table("./UCI HAR Dataset/train/X_train.txt")
trainY<- read.table("./UCI HAR Dataset/train/y_train.txt")

activity_labels<- read.table("./UCI HAR Dataset/activity_labels.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
feature_labels<- features [,2]

# add a column with test and train description for the subjects and change add the column names
Subject_test<-mutate(Subject_test,V2="test")
Subject_train<-mutate(Subject_train,V2="test")
colnames(Subject_test)<- c("Subject_number", "Group_(test/train)")
colnames(Subject_train)<- c("Subject_number", "Group_(test/train)")

# name the columns of test an train data
colnames(testX)<- feature_labels
colnames(trainX)<- feature_labels

# merge the labels with their names using left_join (because it does not change the order), 
# remove the column with numbers and label the column 
merged_table_test <- left_join(testY, activity_labels, by = c("V1" = "V1"))
merged_table_test <- select(merged_table_test, V2)
colnames(merged_table_test)<-c("Activity_label")
merged_table_train <- left_join(trainY, activity_labels, by = c("V1" = "V1"))
merged_table_train <- select(merged_table_train, V2)
colnames(merged_table_train)<-c("Activity_label")

#join the subject, activity label and main tables for train and test using cbind
# and remove the unnecessary tables
testX<-cbind(Subject_test,merged_table_test,testX)
trainX<-cbind(Subject_train,merged_table_train,trainX)
rm(testY,trainY,Subject_test,Subject_train,features,feature_labels, activity_labels, merged_table_test,merged_table_train)

# merge the test and train data sets to create one using rbind
merged_test_train <- rbind(testX, trainX)

# select the columns with mean and std deviation, keep the columns with subject number, group and activity label
test_train<- select(merged_test_train, "Subject_number", "Group_(test/train)", "Activity_label", matches("mean\\(|std\\("))

# group by subject and activity and use summarize to create the final data frame
tidy_data<-tbl_df(test_train)
tidy_data <- group_by(tidy_data, Subject_number,Activity_label)
tidy_data<-summarise_each(tidy_data, funs(mean), 4:67)

# write the text file with the final df
write.table(tidy_data, "tidy_data_step5.txt", sep = "\t", row.names = FALSE, col.names = TRUE)


