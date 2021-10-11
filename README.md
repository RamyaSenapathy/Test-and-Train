# Test-and-Train
# test and train data
column_names : Read the file "features.txt" it has all the 561 column names , column names are same for both train and test so single file can be used for both.

test_x : Read the file "X_test.txt", this file has all the measurements (2947*561)
test_y : Read the file "y_test.txt", this file has all the Activity numbers(1-6) (2947*1)
sub_test : Read the file "subject_test.txt", this file has all the subjects number (2947*1)
Changed the column name for : test_y and sub_test to "Activity" & "Subject" 
Added extra column to the data frame : test_x from the column_names$V2
test_data : joined 3dfs(test_y,sub_test,test_x) with cbind 
train_x : Read the file "X_train.txt" (7352*561) this file has all the measurements
train_y : Read the file "y_train.txt" (7352*1) this file has all the Activity numbers(1-6)
sub_train :  Read the file "subject_train.txt" this file has all the subjects number (7352*1)
Changed the column name for : train_y and sub_train to "Activity" & "Subject" 
Added extra column to the data frame : train_x from the column_names$V2
train_data <- joined 3dfs(train_y,sub_train,train_x) with cbind 
data : merged Test and Train dataframe : test_data + train_data with rbind
activity_name : read Read the file "activity_labels.txt",this file has all the activity names with code (1-6 & label)
activity_name : changed the column name to "id","Activity"
data_final : activity_name + data with the help of dplyr package: subsetted the dataframe 
data_mean_std : data with mean and standard deviation values with Activty and Subject columns
grouped_data : grouped with Activty(1-6) and Subject (1-30) and then calculated mean for each measurements after grouping.20. now the row count is : 6*30 = 180 and column count = 88(including : Activty and Subject)
