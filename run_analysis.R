getwd()
setwd("C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset")

#names(test_x) #to get column name with col numbers : 128
#nrow(test_x)  #row count:2946

##############################

#column names are same for both train and test so single file can be used for both
column_names <- read.table(file = "C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset/features.txt", header = FALSE)

###

#Test file
test_x <- read.table(file = "C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset/test/X_test.txt", header = FALSE)
test_y <- read.table(file = "C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset/test/y_test.txt", header = FALSE)
sub_test <- read.table(file = "C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

colnames(test_x) <- column_names$V2     #adding into test_x directly : test_x data + column name from (column_names$V2)
colnames(test_y) <- "Activity"          #test_y df: replacing the column name to Activity,since the file has only 1 column
colnames(sub_test) <- "Subject"         #sub_test df: replacing the column name to Subject,since the file has only 1 column
test_data <- cbind.data.frame(test_y,sub_test,test_x)      #joining 3 dataframes

###

#Train file
train_x <- read.table(file = "C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset/train/X_train.txt", header = FALSE)
train_y <- read.table(file = "C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset/train/y_train.txt", header = FALSE)
sub_train <- read.table(file = "C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset/train/subject_train.txt", header = FALSE)

colnames(train_x) <- column_names$V2    # adding into train_x directly : train_x data + column name from (column_names$V2)
colnames(train_y) <- "Activity"         # train_y df: replacing the column name to Activity,since the file has only 1 column
colnames(sub_train) <- "Subject"        # sub_train df: replacing the column name to Subject,since the file has only 1 column
train_data <- cbind.data.frame(train_y,sub_train,train_x)             #joining 3 dataframes

# merging Test and Train files
data <- rbind.data.frame(train_data , test_data ) #col no is 563 for both,so inner join

activity_name <- read.table(file = "C:/Users/Naveen Pandian Vasan/Desktop/Ramya/Coursera/Coursera_DS/Getting and cleaning data week 1 to 4/Week 4/Assignment/UCI HAR Dataset/activity_labels.txt", header = FALSE)
colnames(activity_name) <- c("id","Activity")       #activity_name df : changing name for both the columns

data_final <- merge(x=activity_name,y=data,by.x="id",by.y="Activity")  #merging with activity number(1-6)

install.packages("dplyr")
library(dplyr)
# select is a column filter
data_mean_std <- data_final  %>%  select(Activity,Subject, contains('mean'),contains('std')) 
#grouping 6 activities *30 subjects and finding mean = 180 rows
grouped_data <- data_mean_std  %>% group_by(Subject,Activity) %>% summarise(across(.groups=c("Activity","Subject"),.cols=is.numeric,.fns=mean))

write.table(grouped_data, file=file.path("tidydata.txt"), row.names = FALSE, quote = FALSE)




