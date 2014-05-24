# This file explains the workings of run_analysis.R

## Input files used
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 
The script, run_analysis.R reads assumes that the above files are in a folder called data in the current working directly.  It reads raw data for training and test sets, and combines them.

Activity names (e.g. "WALKING" are used to replace the numbers in the original data set).  The names are taken from activity_labels.txt.


## output files used

The variable names are read from features.txt, and non-alpha numeric characters are stripped to form new names. These transformations are recorded in code.txt

###Finally, the data is aggregated into a list, which is then transformed into a new tidy data set called tidy_dataset.csv