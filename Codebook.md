## Introduction
This codebook is a description of the dataset tidydata.txt as well as description for the step-by-step transformations from
 the <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"> raw data </a> performed by run_analysis.md
 Descriptions of Variables and measurements descriptions are based from  the raw's data README file.
 ## Columns
### Subject
Each row identifies the subject who performed the activity . Its original range is from 1 to 30. For tidy.txt it was transformed into a factor variable in step 4; Levels: 1, 2, 3... 29,30

### Activity
Each row specifies the activity performed. Its range is from 1 to 6.
For tidy.txt it was  transformed  into a factor variable in step 3; Levels: laying sitting standing walking walking_downstairs walking_upstairs



### Aggregated Entries(columns from 3-68)

Originallly 561 columns, they get reduced to 66 from step 2, and from step 5 they get aggregated into their mean by Subject and Activity into 180 rows. 
The list of the 66 are written in the append.
They are normalized and bounded within [-1,1]

## Transformations
### Step 1.

For this first step, the 7 files mentioned below must be read through read.table()
at  ~\UCI HAR Dataset
features.txt is the label of the X_ data sets. (to be called as col.names when reading X_)
at ~\UCI HAR Dataset\test
subject_test.txt is the column vector of the subject number. (to be appended as a column into the merged data set)
y_test.txt is the column vector of the activity number. (to be appended as a column into the merged data set)
X_test.txt is the bulk of data processed, 561 columns. (to be appended as a dataframe into the merged data set)
 at ~\UCI HAR Dataset\train
subject_train.txt is the column vector of the subject number. (to be appended as a column into the merged data set)
y_train.txt is the column vector of the activity number. (to be appended as a column into the merged data set)
X_train.txt is the bulk of data processed, 561 columns. (to be appended as a dataframe into the merged data set)

Most files won't be read in R as they don't concern the assignment. The file activity_labels.txt will be read at step 3.

run_analysis.R reads features first and assigns it as the name of the columns for X_. It also assigns names to the columns of the subject and activity files. Then the test pieces (Subject, Activity and the X) can be binded through col bind with other test pieces, ; analogously, the train pieces can be binded toguether. This implies that they can be bound by rows.  run_analysis.R row binds the column binds of this objects into 
Step1Merge that looks like the following: 



Subject | Activity |  tBodyAcc-mean()-X | ... | angle(Z,gravityMean) | 
------- | -------- | ------------------| --- | -------------------- |
 2 | 5 | 0.25717778 | ... | -0.057978304| 
... |... |...| ... | ...| 
 30 | 2 |  0.3515035| ... | 0.03669484| 
Read from the subject_ text files | Read from the y_ text files | Column names are read from the "feature.txt" | ... | Rows taken from the X_ text files | 

### Step 2
Given this merged data set, it is possible to extract the measurements that represent means and std. 
run_analysis.R looks for the phrase "mean(" or "std(" in the names of the columns of our data set and then creates Step2Extract that has 68 columns.  The first 2 correspond to Subject and Activity. The remaining 66 to the measurements.

### Step 3
For this step, the column "Activity" will be given a more descriptive name.  For this purpose, activity_labels.txt will be read, and run_analysis.R will run a for loop to replace the number code for a character element. This step transforms the Step2Extract dataframe.

### Step 4
This step was done in step 1, the labels of the X_ columns ( col.names = features$headers).
### Step 5
For this step, the columns Subject and Activity have to be converted to factor types and the library plyr will be used.
Yet another Object is created, Step5Tidy. Step5Tidy has 30*6 rows, (30 different subjects, 6 different activities), and keeps the 68 columns.
Finally, Step5Tidy is written into tidydata.txt.

## Append
### Measurement names:
taken with the function
colnames(Step5Tidy)[3:68]

"tBodyAcc.mean...X"
"tBodyAcc.mean...Y"
"tBodyAcc.mean...Z"
"tBodyAcc.std...X"
"tBodyAcc.std...Y"
"tBodyAcc.std...Z"
"tGravityAcc.mean...X"
"tGravityAcc.mean...Y"
"tGravityAcc.mean...Z"
"tGravityAcc.std...X"
"tGravityAcc.std...Y"
"tGravityAcc.std...Z"
"tBodyAccJerk.mean...X"
"tBodyAccJerk.mean...Y"
"tBodyAccJerk.mean...Z"
"tBodyAccJerk.std...X"
"tBodyAccJerk.std...Y"
"tBodyAccJerk.std...Z"
"tBodyGyro.mean...X"
"tBodyGyro.mean...Y"
"tBodyGyro.mean...Z"
"tBodyGyro.std...X"
"tBodyGyro.std...Y"
"tBodyGyro.std...Z"
"tBodyGyroJerk.mean...X"
"tBodyGyroJerk.mean...Y"
"tBodyGyroJerk.mean...Z"
"tBodyGyroJerk.std...X"
"tBodyGyroJerk.std...Y"
"tBodyGyroJerk.std...Z"
"tBodyAccMag.mean.."
"tBodyAccMag.std.."
"tGravityAccMag.mean.."
"tGravityAccMag.std.."
"tBodyAccJerkMag.mean.."
"tBodyAccJerkMag.std.."
"tBodyGyroMag.mean.."
"tBodyGyroMag.std.."
"tBodyGyroJerkMag.mean.."
"tBodyGyroJerkMag.std.."
"fBodyAcc.mean...X"
"fBodyAcc.mean...Y"
"fBodyAcc.mean...Z"
"fBodyAcc.std...X"
"fBodyAcc.std...Y"
"fBodyAcc.std...Z"
"fBodyAccJerk.mean...X"
"fBodyAccJerk.mean...Y"
"fBodyAccJerk.mean...Z"
"fBodyAccJerk.std...X"
"fBodyAccJerk.std...Y"
"fBodyAccJerk.std...Z"
"fBodyGyro.mean...X"
"fBodyGyro.mean...Y"
"fBodyGyro.mean...Z"
"fBodyGyro.std...X"
"fBodyGyro.std...Y"
"fBodyGyro.std...Z"
"fBodyAccMag.mean.."
"fBodyAccMag.std.."
"fBodyBodyAccJerkMag.mean.."
"fBodyBodyAccJerkMag.std.."
"fBodyBodyGyroMag.mean.."
"fBodyBodyGyroMag.std.."
"fBodyBodyGyroJerkMag.mean.."
"fBodyBodyGyroJerkMag.std.."

