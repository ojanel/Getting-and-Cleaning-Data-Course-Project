library(reshape2)

## read features
features <- read.table("./UCI HAR Dataset/features.txt")
names(features) <- c("id", "desc")
## read activity labels
actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(actlabels) <- c("id", "desc")

## read training & test mesurement
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
## merge training & test mesurement
Xdata <- rbind(Xtrain, Xtest)
## label dataset using features vector
names(Xdata) <- features$desc
##extract mean and standard deviation for each mesurement
measure <- Xdata[, grep("^(.*)-(mean|std)\\((.*)$", names(Xdata))]

names(measure) <- sub("^t", "time signal - ", names(measure))
names(measure) <- sub("^f", "frequence signal - ", names(measure))
names(measure) <- sub("Acc", " accelerometer ", names(measure))
names(measure) <- sub("Gyro", " gyroscope ", names(measure))
names(measure) <- sub("BodyBody", "Body", names(measure))
names(measure) <- sub("Mag", " magnitude", names(measure))
names(measure) <- sub("mean\\(\\)", " mean value", names(measure))
names(measure) <- sub("std\\(\\)", " standard deviation", names(measure))

## Read activity data
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
## merge training & test activities
activity <- rbind(ytrain, ytest)
## labels the data set with descriptive variable name
names(activity) <- "activity"
      
## Read subject data
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
## merge training & test subject data
subject <- rbind(subjecttrain, subjecttest)
## labels the data set with descriptive variable name
names(subject) <- "subject"
      
## Merge whole dataset
data <- cbind(subject, cbind(activity, measure))

##Use descriptive activity names to name the activities in the data set
for (i in 1:nrow(actlabels)) {
      data$activity <- gsub(actlabels$id[i], actlabels$desc[i], data$activity)
}


## create from dataset an independent tidy data set with the average of each variable for each activity and each subject.
meltdata <- melt(data, id = c("subject", "activity"), measure.vars=names(measure))
tidiest <- dcast(meltdata, subject+activity~variable, mean)

## write  dataset in a csv file
write.table(tidiest, './tidiest.txt')