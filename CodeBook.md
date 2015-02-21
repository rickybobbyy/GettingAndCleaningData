##Getting and Cleaning Data Project CodeBook


**Project Introduction**

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones][1] 


**Transformation Details**

There is one R script called **run_analysis.R** that does the following:

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


**Details for each step**

**Step 1**
The training and test sets are in the files X_train.txt and X_test.txt.
The R script reads the files using read.table and then uses the rbind function to merge them and create a dataset called dataset_merged

**Step 2**
After reading the file features.txt that has all of the feature labels (measurement names) and creating a vector called feature_labels,
it is possible to view the feature_labels file and determine that the mean and standard deviation measurements contain 'std' and 'mean' in the label name.
So, the grepl function is used to create a vector of features with 'std' or 'mean' in the label name.
This is then used to extract only the measurements from the dataset_merged dataset that have 'std' or 'mean' in the measurement name.

**Step 3**
The activity_labels.txt file has a descriptive list of the activities and the y_train.txt and y_test.txt files have the activities.
The two activities files are merged into one dataset called rbind and the activity column is renamed to allow a subsequent join.

**Step 4**
The join function is used to merge 2 data frames (activities_merge and activity_labels) using the activityLabel vector.
Then 3 data frames are merged using the cbind function (subject_merged,activities_joined and dataset_mean_std).
The melt function is applied to the new data frame which takes wide-format data and melts it into long-format data

**Step 5**
The dcast function is applied to the data frame created at the end of the previous step. It applies the mean function for each activity and each subject
and creates a second tidy data set.
A file with this tidy set is created called      c:\coursera\data\tidy_data.txt


Here are the data elements of the tidy dataset (created in Step 5):

 - SubjectId
 - ActivityName 
 - tBodyAcc-mean()-X 
 - tBodyAcc-mean()-Y 
 - tBodyAcc-mean()-Z 
 - tBodyAcc-std()-X 
 - tBodyAcc-std()-Y 
 - tBodyAcc-std()-Z 
 - tGravityAcc-mean()-X 
 - tGravityAcc-mean()-Y 
 - tGravityAcc-mean()-Z 
 - tGravityAcc-std()-X 
 - tGravityAcc-std()-Y 
 - tGravityAcc-std()-Z 
 - tBodyAccJerk-mean()-X 
 - tBodyAccJerk-mean()-Y 
 - tBodyAccJerk-mean()-Z 
 - tBodyAccJerk-std()-X 
 - tBodyAccJerk-std()-Y 
 - tBodyAccJerk-std()-Z 
 - tBodyGyro-mean()-X 
 - tBodyGyro-mean()-Y 
 - tBodyGyro-mean()-Z 
 - tBodyGyro-std()-X 
 - tBodyGyro-std()-Y 
 - tBodyGyro-std()-Z 
 - tBodyGyroJerk-mean()-X 
 - tBodyGyroJerk-mean()-Y 
 - tBodyGyroJerk-mean()-Z 
 - tBodyGyroJerk-std()-X 
 - tBodyGyroJerk-std()-Y 
 - tBodyGyroJerk-std()-Z 
 - tBodyAccMag-mean() 
 - tBodyAccMag-std() 
 - tGravityAccMag-mean() 
 - tGravityAccMag-std() 
 - tBodyAccJerkMag-mean() 
 - tBodyAccJerkMag-std() 
 - tBodyGyroMag-mean() 
 - tBodyGyroMag-std() 
 - tBodyGyroJerkMag-mean() 
 - tBodyGyroJerkMag-std() 
 - fBodyAcc-mean()-X 
 - fBodyAcc-mean()-Y 
 - fBodyAcc-mean()-Z 
 - fBodyAcc-std()-X 
 - fBodyAcc-std()-Y 
 - fBodyAcc-std()-Z 
 - fBodyAcc-meanFreq()-X 
 - fBodyAcc-meanFreq()-Y 
 - fBodyAcc-meanFreq()-Z 
 - fBodyAccJerk-mean()-X 
 - fBodyAccJerk-mean()-Y 
 - fBodyAccJerk-mean()-Z 
 - fBodyAccJerk-std()-X 
 - fBodyAccJerk-std()-Y 
 - fBodyAccJerk-std()-Z 
 - fBodyAccJerk-meanFreq()-X 
 - fBodyAccJerk-meanFreq()-Y
 - fBodyAccJerk-meanFreq()-Z 
 - fBodyGyro-mean()-X 
 - fBodyGyro-mean()-Y 
 - fBodyGyro-mean()-Z 
 - fBodyGyro-std()-X 
 - fBodyGyro-std()-Y 
 - fBodyGyro-std()-Z 
 - fBodyGyro-meanFreq()-X 
 - fBodyGyro-meanFreq()-Y 
 - fBodyGyro-meanFreq()-Z 
 - fBodyAccMag-mean() 
 - fBodyAccMag-std() 
 - fBodyAccMag-meanFreq() 
 - fBodyBodyAccJerkMag-mean() 
 - fBodyBodyAccJerkMag-std() 
 - fBodyBodyAccJerkMag-meanFreq() 
 - fBodyBodyGyroMag-mean() 
 - fBodyBodyGyroMag-std() 
 - fBodyBodyGyroMag-meanFreq() 
 - fBodyBodyGyroJerkMag-mean() 
 - fBodyBodyGyroJerkMag-std() 
 - fBodyBodyGyroJerkMag-meanFreq()

Here is a description of the features:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.



The tidy dataset contains the average of each variable for each activity and each subject. From Step 2 described above, only features that are Mean or Standard Deviation features were selected from the initial dataset.


SubjectId denotes the subject number that performed the activity.

ActivityName denoted the activity performed by the subject. Here are the domain of values:
 - WALKING
 - WALKING_UPSTAIRS
 - WALKING_DOWNSTAIRS
 - SITTING
 - STANDING
 - LAYING

 - The prefix 't' denotes time
 - The prefix 'f' denotes frequency
 - mean() denotes Mean value
 - std() denotes Standard deviation
 - meanFreq()denotes Weighted average of the frequency components to obtain a mean frequency


  [1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
</markdown></p>