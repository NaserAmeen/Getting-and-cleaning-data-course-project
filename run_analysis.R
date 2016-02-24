library(dplyr)
library(tidyr)

filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, mode='wb', cacheOK=FALSE)
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# read activity_labels and features
activity_labels = tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt"))
activity_labels <- rename(activity_labels, activity = V1)
features = tbl_df(read.table("./UCI HAR Dataset/features.txt"))
featureNames <- gsub('[\\(\\)]','',features$V2)
featureNames <- gsub('[-,]','_',featureNames)


# read test data
test_features <- tbl_df(read.table("UCI HAR Dataset/test/X_test.txt"))
names(test_features) = featureNames
test_features <- test_features[, unique(colnames(test_features))]
test_features <- select(test_features,matches("mean|std"))
test_activities <- tbl_df(read.table("UCI HAR Dataset/test/Y_test.txt"))

test_activities <- test_activities %>% rename(activity = V1) %>% 
                  inner_join(activity_labels, by="activity") %>%
                  select(-matches("activity")) %>%
                  rename(activity = V2)

test_subjects <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt"))
test_subjects <- rename(test_subjects, subject_id = V1)
test <- cbind(test_subjects, test_activities, test_features)

# read train data
train_features <- tbl_df(read.table("UCI HAR Dataset/train/X_train.txt"))
names(train_features) = featureNames
train_features <- train_features[, unique(colnames(train_features))]
train_features <- select(train_features,matches("mean|std"))
train_activities <- tbl_df(read.table("UCI HAR Dataset/train/Y_train.txt"))

train_activities <- train_activities %>% rename(activity = V1) %>% 
  inner_join(activity_labels, by="activity") %>%
  select(-matches("activity")) %>%
  rename(activity = V2)

train_subjects <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt"))
train_subjects <- rename(train_subjects, subject_id = V1)
train <- cbind(train_subjects, train_activities, train_features)

# merge the training and test set, save to file
merged_set <- tbl_df(rbind(test,train))
write.csv(merged_set,"test_train_merged.csv")

# tidy up the data
# Data transformed from wide format to long format
messy <- merged_set
tidy_summary <- messy %>% gather("measurement","value",-c(subject_id,activity)) %>%
                group_by(subject_id,activity,measurement) %>%
                summarise(mean_measure = mean(value)) %>%
                print

#write summary to file
write.csv(tidy_summary,"summaryData.csv")
