
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
S <- rbind(subject_train,subject_test)
XSY <- cbind(X,S,Y)
  
# read variable descriptions
feat <- read.table("./data/UCI HAR Dataset/features.txt",header=FALSE)
feat$name <- as.character(feat$V2)
#create logical vector of names containing "mean" 
l1 <- ifelse(grepl("mean",feat$name,ignore.case=TRUE),TRUE,FALSE)
#create logical vector of names containing "std" 
l2 <- ifelse(grepl("std",feat$name,ignore.case=TRUE ),TRUE,FALSE)
# combine them as logical statements (l1 + l2 is the same as l1 or l2)
featl <- l1 + l2
dset1 <- XSY

# replace unwanted characters in variable descriptions to form names

myfnCleantext <- function(x){gsub("[[:punct:]]", "", x)}
feat$name <- myfnCleantext(feat$name)
names(dset1) <- feat$name # set these names into the main data frame as per 3.
# remove unwanted columns i.e. those columns that are not mean or std. as per 2.
for(i in 1:length(featl)){(!featl[i]){dset1[, feat$name[i]] <- NULL}}
# add the name for the Y sets.
names(dset1)[ncol(dset1)-1] <- "Subject"

names(dset1)[ncol(dset1)] <- "Activity.Num"
actname <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
dset1$Activity <- actname[dset1$Activity.Num]
names(dset1)[ncol(dset1)] <- "Activity"
dset1$Activity.Num <- NULL
# dset1 is now the first data set that was asked for in step 4.

foo <- NULL
#write out a code book that translates the original names to the new names
# This is to document the new names constructed here, and is to be used in 
# addition to the features.txt and features_info.txt provided before.
foo$Original.Name <- feat$V2
foo$New.Name <- feat$name
write(foo,file="./data/code.txt")

## now to get the second, tidy, data set.
## The columns will be the subject, activity, average value of each variable. 
# this leaves us with one observation (of an activity) per row.

# traverse the columns of dset1, and produce a list of the means of all the activities. This has all the information we 
# need for the new data set.

catch <- apply(dset1[,1:(ncol(dset1)-2)],2,function(x){aggregate(x,by=list(dset1$Subject,dset1$Activity),FUN=mean)})
# set up the second data set
temp <- NULL
df <- data.frame(Subject = numeric(), Activity = character(),Avg_Measurement= = numeric(), stringsAsFactors = FALSE)

dset2 <- NULL
#for (i in 1:length(catch))
for (i in 1:1){
   temp$Subject <- catch[[i]][[1]]
   temp$Activity <- catch[[i]][[2]]
   temp$Avg_Measurement <- catch[[i]][[3]]
   temp2 <- as.data.frame(temp)
  }

# construct the dataframe row by row.
# this is not as inefficient as it looks.
# see http://stackoverflow.com/questions/20689650/how-to-append-rows-to-an-r-data-frame
  df <- data.frame(Subject = int(), Activity = character(),Avg_Measurement = numeric(), stringsAsFactors = FALSE)
  n = length(catch) # the number of variables
  
  k=0
  for(i in 1:n){
      print(paste("i=",i))
      for (j in 1:length(catch[[i]][[1]])){
        print(paste(catch[[i]][[2]][[j]]))
        k <- k+1
      #print(paste("k=",k))
    df[k,1] <- catch[[i]][[1]][[j]]
    df[k,2] <- catch[[i]][[2]][[j]]
    df[k,3] <- catch[[i]][[3]][[j]] 
    }}
write.table(df,"tidy_dataset.csv",sep=",")
# The file containing df is the output of this script.