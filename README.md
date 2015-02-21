#Getting and Cleaning Data Project** 

This repo contains the deliverables for the "Getting and Cleaning Data" Coursera Course Project

**Files in this repository**

**run_analysis.R** is the R script that can be run to perform the 5 steps in the project requirements described below.

**CodeBook.md** is a code book that describes the variables, the data, and any transformations or work performed to clean up the data

**tidy_data.txt** is the tidy dataset that is the output of step 5 and is created after running the run_analysis.R script.


**Input**

The run_analysis.R script starts with the assumption that the Samsung data is available in the working directory in an unzipped folder

Here are the data for the project: 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip][1] 


The initial step is to download the ZIP file and extract to the following folder:

C:\Coursera\Data



The dataset includes the following files that will be used in the project assignment:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.


**Required R packages**


The plyr and reshap2 packages will be used in this project. Run the following commands in the R console if they have not already been run on your computer:

install.packages('plyr',repos='http://cran.r-project.org')
install.packages('reshape2',repos='http://cran.r-project.org')




Here are the 5 steps that need to be performed to complete the project:

You should create one R script called run_analysis.R that does the following. 
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject



Here are details about what is being performed in the run_analysis.R script:

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
A file with this tidy set is created called      **c:\coursera\data\tidy_data.txt**


  [1]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
</markdown></p>