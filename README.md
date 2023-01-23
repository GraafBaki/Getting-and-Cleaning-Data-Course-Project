# Getting-and-Cleaning-Data-Course-Project
Peer review assignment

The script takes the data from the 
Human Activity Recognition Using Smartphones Data Set
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and cleans it to achieve the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

These are the steps taken to reach the final outcome

read the data
add a column with test and train description for the subjects and change add the column names
name the columns of test an train data
merge the labels with their names using left_join (because it does not change the order), 
remove the column with numbers and label the column 
join the subject, activity label and main tables for train and test using cbind and remove the unnecessary tables
merge the test and train data sets to create one using rbind
select the columns with mean and std deviation, keep the columns with subject number, group and activity label
group by subject and activity and use summarize to create the final data frame
write the text file with the final df using write.table

The code book describes the variables, the data, and any transformations or work that you performed to clean up the data and refers to the final data set (from step 5)
