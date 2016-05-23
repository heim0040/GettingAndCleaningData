# download data
library(downloader)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(fileUrl, dest="dataset.zip", mode="wb")
unzip("dataset.zip", exdir = "./")

# prepare test data
testdat <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
testlabels <- read.table("UCI HAR Dataset/test/Y_test.txt", header=FALSE)
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)
activities <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
colnames(testdat) <- features[,2]
testdata <- testdat[ , grep( "mean()|std()", colnames(testdat))]
test <- cbind(testlabels, testdata)
test2 <- cbind(testsubjects, test)
colnames(test2)[1:2] <- c("Subject", "ActivityNumber")

# prepare training data
traindat <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
trainlabels <- read.table("UCI HAR Dataset/train/Y_train.txt", header=FALSE)
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
colnames(traindat) <- features[,2]
traindata <- traindat[ , grep( "mean()|std()", colnames(traindat))]
train <- cbind(trainlabels, traindata)
train2 <- cbind(trainsubjects, train)
colnames(train2)[1:2] <- c("Subject", "ActivityNumber")

# combine test and train datasets
merged <- rbind(test2, train2)
merged$Activity <- activities$V2[match(merged$ActivityNumber,activities$V1)]

# reorder columns
col_idx <- grep("Activity", names(merged))
merged <- merged[,c(col_idx, (1:ncol(merged))[-col_idx])]
merged$ActivityNumber <- NULL
colnames(merged)[3:81] <- paste("Average.of.", colnames(merged)[3:81], sep="")

library(dplyr)
ActivityData <-
        merged %>%
        group_by(Activity,Subject) %>%
        summarise_each(funs(mean))



