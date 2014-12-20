#### Raw data
Raw data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

More information on the original dataset can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#### Data processing
The **Run_analysis.R** script performs data processing to clean the original dataset.
It required the **dplyr** package for running.
Data processing follows 5 main steps:

##### 1-merging
Data have been merged in the following way:

- test and train dataset have been merged row-wise in order to obtain a single dataset. 
- the subject, y(activities) and x data have been added column-wise in order to obtain a single dataset containing all the variables.

##### 2-renaming
- All variables have been renamed using the variable names stored in features.txt; 
- All variable names with errors have been corrected and double names eliminated;
- All () signs have been removed;
- All capital letters in the names have been replaced by low cases;
- Descriptive activity names (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) have been used in place of their corresponding code.

##### 3-selecting
Only those variables containing the mean or the std of a measurements have been selected from the dataset.

##### 4-ordering
The observation have been ordered by subject and by activity in such a way that all observations relative to the same subject performing the same activity are grouped together. 

##### 5-averaging
The mean of each variable for each of the groups described in step 4 (same subject - same activity) have been calculated 


#### Tidy dataset
The *tidydataset* generated at step 4 contains the following variables:

"subject", "activity", "tbodyaccX-mean", "tbodyaccY-mean", "tbodyaccZ-mean", "tgravityaccX-mean", "tgravityaccY-mean", "tgravityaccZ-mean", "tbodyaccjerkX-mean", "tbodyaccjerkY-mean", "tbodyaccjerkZ-mean", "tbodygyroX-mean", "tbodygyroY-mean", "tbodygyroZ-mean", "tbodygyrojerkX-mean", "tbodygyrojerkY-mean", "tbodygyrojerkZ-mean", "tbodyaccmag-mean", "tgravityaccmag-mean", "tbodyaccjerkmag-mean", "tbodygyromag-mean", "tbodygyrojerkmag-mean", "fbodyaccX-mean", "fbodyaccY-mean", "fbodyaccZ-mean", "fbodyaccjerkX-mean", "fbodyaccjerkY-mean", "fbodyaccjerkZ-mean", "fbodygyroX-mean", "fbodygyroY-mean", "fbodygyroZ-mean", "fbodyaccmag-mean", "fbodyaccjerkmag-mean", "fbodygyromag-mean", "fbodygyrojerkmag-mean", "tbodyaccX-std",  "tbodyaccY-std", "tbodyaccZ-std", "tgravityaccX-std", "tgravityaccY-std", "tgravityaccZ-std", "tbodyaccjerkX-std", "tbodyaccjerkY-std", "tbodyaccjerkZ-std", "tbodygyroX-std", "tbodygyroY-std", "tbodygyroZ-std", "tbodygyrojerkX-std", "tbodygyrojerkY-std", "tbodygyrojerkZ-std", "tbodyaccmag-std", "tgravityaccmag-std", "tbodyaccjerkmag-std", "tbodygyromag-std", "tbodygyrojerkmag-std", "fbodyaccX-std", "fbodyaccY-std", "fbodyaccZ-std", "fbodyaccjerkX-std", "fbodyaccjerkY-std", "fbodyaccjerkZ-std", "fbodygyroX-std", "fbodygyroY-std", "fbodygyroZ-std", "fbodyaccmag-std", "fbodyaccjerkmag-std", "fbodygyromag-std", "fbodygyrojerkmag-std" 

for a total of 102099 observations.

The dataset containing the means is named *tidymeans* and it is also saved as a .txt file (with tab as separator) in the working directory.

