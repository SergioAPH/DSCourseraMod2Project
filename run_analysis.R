#Step 1
features<-read.table("./UCI HAR Dataset/features.txt", sep = "", header = FALSE, col.names = c("index", "headers"))
SubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE, col.names = c("Subject"))
SetTest <- read.table("./UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE, col.names = features$headers)
ActivityTest <- read.table("./UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE, col.names = c("Activity") )


SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE, col.names = c("Subject"))
SetTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE, col.names = features$headers)
ActivityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE, col.names = c("Activity") )


Step1Merge<-rbind(cbind(SubjectTest, ActivityTest, SetTest), cbind(SubjectTrain, ActivityTrain,  SetTrain) )

#Step 2 
#grep is called for for columnnames that contain "mean(" or "std("
indices<-grep("mean\\(|std\\(", features$headers)
#Step1Merge's first and second column are Subject and Activity
indices<-indices+2
Step2Extract<-cbind(Step1Merge[,1:2], Step1Merge[,indices])
#Step 3
ActivityLabels<-read.table("./UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE, col.names = c("index", "labels"))
ActivityLabels$labels<-tolower(ActivityLabels$labels)
for(i in 1:length(ActivityLabels$index)){
  Step2Extract$Activity<-sub(ActivityLabels$index[i],ActivityLabels$labels[i],Step2Extract$Activity)
}
#Step 4

#Step 5
Step2Extract$Subject<-as.factor(Step2Extract$Subject)
Step2Extract$Activity<-as.factor(Step2Extract$Activity)
library("plyr")
Step5Tidy<-aggregate(. ~Subject + Activity, Step2Extract, mean)
write.table(Step5Tidy, file = "tidydata.txt",row.name=FALSE)

