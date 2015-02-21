install.packages('plyr',repos='http://cran.r-project.org')
install.packages('reshape2',repos='http://cran.r-project.org')
 
library(plyr) ##need for join()
library(reshape2) ##need for melt() and dcast()
 
setwd("~/Coursera/data")
 
#This script starts with the assumption that the Samsung data is available in the working directory and is already unzipped.
   run_analysis<-function(){   
        #Read data for train and test set
        dataset_train    <- read.table("./train/X_train.txt", sep = "")
	dataset_test     <- read.table("./test/X_test.txt", sep = "")
        #Read list of feature names
        feature_list     <- read.table("./features.txt", col.names=c("index", "feature_labels"), sep = "")
	#Read activities for train and test
        activities_train <- read.table("./train/Y_train.txt", sep = "",col.names=c("activityLabel"))
	activities_test  <- read.table("./test/Y_test.txt", sep = "",col.names=c("activityLabel"))
        #Read subject Ids for train and test set
	subject_train    <- read.table("./train/subject_train.txt", col.names=c("subjectId"), sep = "")
        subject_test     <- read.table("./test/subject_test.txt", col.names=c("subjectId"), sep = "")
	#Read list of activities
        activity_labels <-read.table("activity_labels.txt",sep=" ",col.names=c("activityLabel","activityName"))

	#1.Merge the training and the test datasets
        dataset_merged <- rbind(dataset_test, dataset_train)
	#Rename columns in dataset_merged  
        colnames(dataset_merged) <- feature_labels
        #Create vector containing all feature labels
        feature_labels <- feature_list$feature_labels
        ##Create vector that indicates which records in feature_labels have mean and std in their name
        features_check <- grepl("mean|std",feature_labels)
        #Create vector of features with mean and std in their name
        feature_mean_std <- as.character(feature_labels[features_check])

 
#2.Extract only the measurements on the mean and standard deviation for each measurement.
	#use the features_check logical vector
	dataset_mean_std <- dataset_merged[,features_check]
        
#3.Use descriptive activity names to name the activities in the data set
        #Combine train and test activities
        activities_merge <- rbind(activities_test, activities_train)
	colnames(activities_merge) <- "activityLabel"
        
#4.Appropriately label the data set with descriptive variable names
	#use the Join function to join the activities_merge and activity_labels data frames using the activityLabel vector
	#using the "left" argument in case there are activities in the activities_merge data frame that do not exist in the activity_labels data frame
	activities_joined <-join(activities_merge,activity_labels,by="activityLabel",type="left",match="all")
	activities_joined$activityLabel <- NULL
	
	#Combine 3 data frames
        subject_merged <- rbind(subject_train, subject_test)
	df <- cbind(subject_merged,activities_joined, dataset_mean_std )
       
	#melt function takes wide-format data and melts it into long-format data
	melt_df <- melt(df, id=c("subjectId", "activityName"), measure.vars=feature_mean_std)
	
##5.create a second, independent tidy data set with the average of each variable for each activity and each subject.
        #dcast function takes long-format data and casts it into wide-format data	
        tidy_data   = dcast(melt_df, subjectId + activityName ~ variable, mean)
                
        #Output file as TXT created with write.table() using row.name=FALSE
	write.table(tidy_data,file="./tidy_data.txt",row.name=FALSE) 
}