# Getting the data file, if it's now downloaded yet
if(!file.exists("data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data.zip")
} else {
  print("File data.zip already exists, not refreshing it")
}

# Contains the enumeration of activities
con <- unz("data.zip", "UCI HAR Dataset/activity_labels.txt")
activities <- read.table(con)

# Contains the enumeration of features variables
con <- unz("data.zip", "UCI HAR Dataset/features.txt")
features <- read.table(con)

# We don't really need every single feature var - only the mean() and std() ones
featuresFilter <- grepl("mean\\(\\)|std\\(\\)",features$V2)

# Contains the observations of the feature variables values
# We have already read their names
con <- unz("data.zip", "UCI HAR Dataset/train/X_train.txt")
x_train <- read.table(con, col.names = features$V2)
# We don't need every column
x_train <- x_train[,featuresFilter]

# Shows which vector belongs to which subject
con <- unz("data.zip", "UCI HAR Dataset/train/subject_train.txt")
subject_train <- read.table(con)

# Shows which activity was happening
con <- unz("data.zip", "UCI HAR Dataset/train/y_train.txt")
y_train <- read.table(con)

# Contains the observations of the feature variables values
# We have already read their names
con <- unz("data.zip", "UCI HAR Dataset/test/X_test.txt")
x_test <- read.table(con, col.names = features$V2)
# We don't need every column
x_test <- x_test[,featuresFilter]

# Shows which vector belongs to which subject
con <- unz("data.zip", "UCI HAR Dataset/test/subject_test.txt")
subject_test <- read.table(con)

# Shows which activity was happening
con <- unz("data.zip", "UCI HAR Dataset/test/y_test.txt")
y_test <- read.table(con)

## Data read. Manipulating

# Adding activity data
x_train$activity <- merge(y_train, activities)$V2
x_test$activity <- merge(y_test, activities)$V2

# Adding subject data

x_train$subject <- subject_train$V1
x_test$subject <- subject_test$V1

# Adding the data type
x_train$type <- "train"
x_test$type <- "test"

# Merging data
merged <- rbind(x_train, x_test)

## Done. writing data.

write.table(merged, file="result.txt", row.names = FALSE)
