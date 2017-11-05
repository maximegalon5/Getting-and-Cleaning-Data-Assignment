library(tidyverse)
##Data downloaded and unzipped into working directory
##Importing activity labels
activity_labels <- as.tibble(read.table("./activity_labels.txt", header = F))
##Importing features (Column Headings)
features_col_names <- read.table("./features.txt", header = F)
##Importing Test Data
X_test <- as.tibble(read.table("./test/X_test.txt", header = F))
y_test <- as.tibble(read.table("./test/y_test.txt", header = F)) %>% left_join(activity_labels, by = "V1")
subject_test <- as.tibble(read.table("./test/subject_test.txt", header = F))
##Importing Training Data
X_train <- as.tibble(read.table("./train/X_train.txt", header = F))
y_train <- as.tibble(read.table("./train/y_train.txt", header = F)) %>% left_join(activity_labels, by = "V1")
subject_train <- as.tibble(read.table("./train/subject_train.txt", header = F))
##Converting features (Column Names) into character vectors for labelling purposes
features_col_names <- as.character(features_col_names[,2])
#Creating unified data frames for Testing and Training Data for the purposes of colum labelling
Data_Test <- bind_cols(subject_test, y_test[,2], X_test)
Data_Train <- bind_cols(subject_train, y_train[,2], X_train)
#Note sequence of columns ie subject, activity, features
names(Data_Test) <- c(c("Subject", "Activity"), features_col_names)
names(Data_Train) <- c(c("Subject", "Activity"), features_col_names)
#Creating a unified data frame for all data
All_Data <- bind_rows(Data_Train, Data_Test)
#Creating a subject data frame with only those features that have mean and SD measures
Data_Subset <- All_Data %>% select(Subject, Activity, contains("mean"), contains("std"))
## Renaming Columns to make them more descriptive ie replacing t - > time, f -> frequency etc..
names(Data_Subset) <-gsub("^t", "time", names(Data_Subset))
names(Data_Subset) <-gsub("^f", "frequency", names(Data_Subset))
names(Data_Subset) <-gsub("BodyBody", "Body", names(Data_Subset))
names(Data_Subset) <-gsub("Acc", "Accelerometer", names(Data_Subset))
names(Data_Subset) <-gsub("Mag", "Magnitude", names(Data_Subset))
names(Data_Subset) <-gsub("Gyro", "Gyroscope", names(Data_Subset))
names(Data_Subset) <-gsub("-", "_", names(Data_Subset))
## Creating new Tidy data set with the average of each variable for each activity for each subject
Ave_Data_Set <- Data_Subset %>% group_by(Subject, Activity) %>% summarise_all(mean)
## Creating a txt file with the new dataset
dir.create("outputDir")
write.table(Ave_Data_Set, "./outputDir/GCDC_Final_Submission_UCI_Har_Dataset.txt", row.name = FALSE)
