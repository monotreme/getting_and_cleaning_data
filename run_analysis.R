
## Project Getting and cleaning data
## read raw data for training and test sets
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header=FALSE,)
Y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt",,header=FALSE)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header=FALSE,)
Y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt",header=FALSE)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)

# combine training and test sets as per instruction 1.
X <- rbind(X_train,X_test)
Y <- rbind(Y_train,Y_test)
XY <- cbind(X,Y)
  
# read variable descriptions
feat <- read.table("./data/UCI HAR Dataset/features.txt",header=FALSE)
feat$name <- as.character(feat$V2)
#create logical vector of names containing "mean" 
l1 <- ifelse(grepl("mean",feat$name,ignore.case=TRUE),TRUE,FALSE)
#create logical vector of names containing "std" 
l2 <- ifelse(grepl("std",feat$name,ignore.case=TRUE ),TRUE,FALSE)
# combine them as logical statements (l1 + l2 is the same as l1 or l2)
featl <- l1 + l2
test <- XY
count = 1
# replace unwanted characters in variable descriptions to form names
gsub(pattern="\\(\\)", x="abc()", replacement="")
myfnCleantext <- function(x){gsub("[[:punct:]]", "", x)}
feat$name <- myfnCleantext(feat$name)
names(test) <- feat$name # set these names into the main data frame as per 3.
# remove unwanted columns i.e. those columns that are not mean or std. as per 2.
for(i in 1:length(featl)){if!(featl[i]){test[, feat$name[i]] <- NULL}}
# add the name for the Y sets.
names(ncol(test) <- "Subject"
names(test)[ncol(test)] <- "Subject"

dset1 <- test  # this is the first data set that was asked for in step 4.

## now to get the second, tidy, data set.
## The columns will be the person, activity, mean and standard deviation. 
# this leaves us with one observation (of an activity) per row.


