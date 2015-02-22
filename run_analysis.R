#Import all files needed
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"")
features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"")
activity_labels<-activity_labels$V2
X_test <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"")
X_train <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"")
        #Renaming the column for later step
        names(subject_test)<-"Subject"
        names(subject_train)<-"Subject"


#Renaming columns with feature labels
features<-features$V2
colnames(X_test)<-features
colnames(X_train)<-features

#Matching y test & train data with activity labels & renaming columns
for (i in 1:6){
        x<-activity_labels[i]
        y_test$V1<-gsub(i,x,y_test$V1)
}
names(y_test)<-"Activity"
for (i in 1:6){
        x<-activity_labels[i]
        y_train$V1<-gsub(i,x,y_train$V1)
}
names(y_train)<-"Activity"

#Binding data to have structured file
test<-cbind(subject_test, y_test, X_test)
train<-cbind(subject_train, y_train, X_train)

binded<-rbind(test, train)

#Select only variable names with Mean and Std & binding those again
mean<-binded[ , grepl("mean", colnames(binded))]
std<-binded[ , grepl("std", colnames(binded))]
Subject<-binded[1]
Activity<-binded[2]
tidydata<-cbind(Subject, Activity, mean, std)

#Grouping and Summarising the data
step5<-as.tbl(tidydata)
by_subject_activity<-group_by(tidydata, Subject, Activity)
Final<-summarise_each(by_subject_activity, funs(mean), -Subject, -Activity)
write.table(Final, file="Final.txt", row.name=FALSE)
