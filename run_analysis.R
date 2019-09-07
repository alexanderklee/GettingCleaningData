# -- Include libraries that we need to run this script --#

library(reshape2)
library(dplyr)

# -- extracting labels and feature definitions --#
activity_labels  <- read.table("UCI HAR Dataset/activity_labels.txt")
feature_list     <- read.table("UCI HAR Dataset/features.txt")

# -- extracting test data --#
test_subjects    <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_dataset     <- read.table("UCI HAR Dataset/test/X_test.txt")
test_activities  <- read.table("UCI HAR Dataset/test/Y_test.txt")

# -- extracting training data --#
train_subjects   <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_dataset    <- read.table("UCI HAR Dataset/train/X_train.txt")
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")

# -- Create/Update lables for each data frame using --#
# -- sensible terms and no abbreviations            --#
names(activity_labels) <- c("Activity.Id","Activity")

names(test_subjects)   <- c("Subject.Id")
names(test_dataset)    <- feature_list$V2
names(test_activities) <- c("Activity.Id")

names(train_subjects)   <- c("Subject.Id")
names(train_dataset)    <- feature_list$V2
names(train_activities) <- c("Activity.Id")

# -- Combine the related test and training data sets -- #
# -- together first.                                 -- #
testset          <- cbind(test_subjects,test_dataset,test_activities)
trainset         <- cbind(train_subjects,train_dataset,train_activities)

# -- Extract only the the columns we want from the -- #
# -- combined data frames and merge them together  -- #
# -- (repeat for train, test, final data sets)     -- #
sliced_testset   <<- testset[,grepl("Subject.Id|Activity.Id|mean\\(\\)|std\\(\\)",colnames(testset))]
final_testset    <- merge(sliced_testset,activity_labels,all=TRUE)
sliced_trainset  <<- trainset[,grepl("Subject.Id|Activity.Id|mean\\(\\)|std\\(\\)",colnames(trainset))]
final_trainset   <- merge(sliced_trainset,activity_labels,all=TRUE)
data<-merge(final_testset,final_trainset,all=TRUE)

# -- Take the column averages of the merged data set -- #
avg_columns<-colnames(data[,3:68])

# -- Final reshape of the data set -- #
molten_data <- melt(data,id=c("Subject.Id","Activity"),measure.vars=avg_columns)

# -- Cast molten data back into a data frame
tidy_data <- dcast(molten_data, Subject.Id + Activity ~ variable, mean)

# -- Write tidy data out to a file -- #
write.table(tidy_data, file = "tidydataset.txt", row.names= FALSE)
