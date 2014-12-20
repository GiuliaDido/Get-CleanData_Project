
## This script will operate on a starting dataset consisting of:

# 1. subjecttrain: a data.frame with dim 7352x1 (integer)
# 2. ytrain: a data.frame with dim 7352x1 (integer)
# 3. Xtrain: a data.frame with dim 7352x561 (numeric)
# 4. subjecttest: a data.frame with dim 2947x1 (integer)
# 5. ytest: a data.frame with dim 2947x1 (integer)
# 6. Xtest: a data.frame with dim 2947x561 (numeric)
# 7. activities: a data.frame with dim 6x2 (integer, factor)
# 8. features:a data.frame with dim 561x2 (integer, factor)

##The data.table are loaded from the the Dataset with the following:

subjecttrain<-read.table("./Dataset/train/subject_train.txt")
Xtrain<-read.table("./Dataset/train/X_train.txt")
ytrain<-read.table("./Dataset/train/y_train.txt")
subjecttest<-read.table("./Dataset/test/subject_test.txt")
Xtest<-read.table("./Dataset/test/X_test.txt")
ytest<-read.table("./Dataset/test/y_test.txt")
features<-read.table("./Dataset/features.txt")
activities<-read.table("./Dataset/activity_labels.txt")

## The script assigns the same column names to both sub-datasets (test and train).

# subcject(test/train) --> subject
# y(test/train) --> activity
# X(test/train) --> features[,2]

colnames(subjecttest)<-"subject"
colnames(subjecttrain)<-"subject"

colnames(ytest)<-"activity"
colnames(ytrain)<-"activity"

features[,2]<-as.character(features[,2])
names(Xtrain)<-features[,2]
names(Xtest)<-features[,2]

## Let's now select only the measurements of the mean and std of each measuremnt.

Xtrainmean<-subset(Xtrain, select=grep("-mean()", names(Xtrain), fixed=TRUE, value=TRUE))
Xtrainstd<-subset(Xtrain, select=grep("-std()", names(Xtrain), fixed=TRUE, value=TRUE))
Xtestmean<-subset(Xtest, select=grep("-mean()", names(Xtest), fixed=TRUE, value=TRUE))
Xteststd<-subset(Xtest, select=grep("-std()", names(Xtest), fixed=TRUE, value=TRUE))

Xtrain<-cbind(Xtrainmean, Xtrainstd)
Xtest<-cbind(Xtestmean, Xteststd)

## It is time to create a single dataset by
# binding column-wise subject, activity and measurements (for both train and test subsets)
# binding row-wise train and test
## The resulting data.frame, called tidydataset, has 10299 observations of 68 variables

train<-cbind(subjecttrain, ytrain, Xtrain)
test<-cbind(subjecttest, ytest, Xtest)
tidydataset<-rbind(train,test)
cleannames<-c("subject", "activity", "tbodyaccX-mean", "tbodyaccY-mean", "tbodyaccZ-mean", "tgravityaccX-mean", "tgravityaccY-mean", "tgravityaccZ-mean", "tbodyaccjerkX-mean", "tbodyaccjerkY-mean", "tbodyaccjerkZ-mean", "tbodygyroX-mean", "tbodygyroY-mean", "tbodygyroZ-mean", "tbodygyrojerkX-mean", "tbodygyrojerkY-mean", "tbodygyrojerkZ-mean", "tbodyaccmag-mean", "tgravityaccmag-mean", "tbodyaccjerkmag-mean", "tbodygyromag-mean", "tbodygyrojerkmag-mean", "fbodyaccX-mean", "fbodyaccY-mean", "fbodyaccZ-mean", "fbodyaccjerkX-mean", "fbodyaccjerkY-mean", "fbodyaccjerkZ-mean", "fbodygyroX-mean", "fbodygyroY-mean", "fbodygyroZ-mean", "fbodyaccmag-mean", "fbodyaccjerkmag-mean", "fbodygyromag-mean", "fbodygyrojerkmag-mean", "tbodyaccX-std",  "tbodyaccY-std", "tbodyaccZ-std", "tgravityaccX-std", "tgravityaccY-std", "tgravityaccZ-std", "tbodyaccjerkX-std", "tbodyaccjerkY-std", "tbodyaccjerkZ-std", "tbodygyroX-std", "tbodygyroY-std", "tbodygyroZ-std", "tbodygyrojerkX-std", "tbodygyrojerkY-std", "tbodygyrojerkZ-std", "tbodyaccmag-std", "tgravityaccmag-std", "tbodyaccjerkmag-std", "tbodygyromag-std", "tbodygyrojerkmag-std", "fbodyaccX-std", "fbodyaccY-std", "fbodyaccZ-std", "fbodyaccjerkX-std", "fbodyaccjerkY-std", "fbodyaccjerkZ-std", "fbodygyroX-std", "fbodygyroY-std", "fbodygyroZ-std", "fbodyaccmag-std", "fbodyaccjerkmag-std", "fbodygyromag-std", "fbodygyrojerkmag-std")
names(tidydataset)<-cleannames

##In the next step, the script gives descriptive values to the activity column using the code given in 
##the activities data.frame

tidydataset$activity<-as.factor(tidydataset$activity)
levels(tidydataset$activity)<-activities[,2]

##Making use of the dplyr package, the script will now group data with respect to subject and activity
##This is our tidydataset for point 4 of the assignement

tidydataset<-group_by(tidydataset, subject, activity)

##Now the final step: evaluate the mean of each variable within each block (same subject, same activity)
##and write the table as a .txt file in the working directory 

tidymeans<-summarise_each(group_by(tidydataset, subject, activity), funs(mean))
write.table(tidymeans, "./tidymeans.txt", sep="\t", row.name=FALSE)




