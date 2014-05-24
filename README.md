## This file explains the workings of run_analysis.R
## read raw data for training and test sets, and combine them.
# the variable names are read from features.txt, and non-alpha numeric characters are stripped to form new names.
# These transformations are recorded in code.txt

Activity names (e.g. "WALKING" are used to replace the numbers in the original data set).  The names are taken from activity_labels.txt.

Finally, the data is aggregated into a list, which is then transformed into a new tidy data set.
