
library(reshape2)

# Load activity labels + features
activity<-read.table("C:/Users/MANISH/Desktop/UCI HAR Dataset/activity_labels.txt")
activity[ ,2]<-as.character(activity[,2])

features<-read.table("C:/Users/MANISH/Desktop/UCI HAR Dataset/features.txt")
features[ ,2]<-as.character(features[ ,2])


 #Extract only the data on mean and standard deviation

feat.req<-grep("mean|std",features[ ,2])
feat.req.names<-features[feat.req,2]

feat.req.names<-gsub('-mean','Mean',feat.req.names)
feat.req.names<-gsub('-std','Std',feat.req.names)


 # Load the datasets
train<-read.table("C:/Users/MANISH/Desktop/UCI HAR Dataset/train/X_train.txt")
trainAct<-read.table("C:/Users/MANISH/Desktop/UCI HAR Dataset/train/y_train.txt")
trainSub<-read.table("C:/Users/MANISH/Desktop/UCI HAR Dataset/train/subject_train.txt")
train<-cbind(train,trainAct,trainSub)

test<-read.table("C:/Users/MANISH/Desktop/UCI HAR Dataset/test/X_test.txt")
testAct<-read.table("C:/Users/MANISH/Desktop/UCI HAR Dataset/test/y_test.txt")
testSub<-read.table("C:/Users/MANISH/Desktop/UCI HAR Dataset/test/subject_test.txt")
test<-cbind(test,testAct,testSub)


 #merge datasets and add labels
data<-rbind(train,test)
colnames(data)<-c("subject","activity",feat.req.names)

 #turn activities & subjects into factors
data$activity <- factor(data$activity, levels = activity[,1], labels = activity[,2])
data$subject <- as.factor(data$subject)

data.melted <- melt(data, id = c("subject", "activity"))
data.mean <- dcast(data.melted, subject + activity ~ variable, mean)


write.table(data.mean, "C:/Users/MANISH/Desktop/tidy.txt", row.names = FALSE, quote = FALSE)