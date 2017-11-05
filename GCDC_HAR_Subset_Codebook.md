# Codebook to accompany the run_analysis.R Script

##INTRODUCTION
The purpose of the assignment was to download the UCI HAR Data-set and create a 'tidy' data subset with the average values of the mean and std values of the observed variables. Please refer to the associated README file for more details on the assignment and the course.

##Overview of the process

The objective was achieved by performing the following actions / data manipulations.
Note: The associated script has been annotated to assist in the read-ability of the code.

* Downloading and Unzipping the Data into the working directory.

* Understanding the file structure by reading the README files (Important).

* Importing the required Data into R Studio.

* Extracting the required Data for Columns Names.

* Combining the Subject, Test and Training data per assignment.

* Creating a subset of the Data (only Data with Mean and Std values).

* Making the Column Names more descriptive.

* Summarise the data-subset to include on the average values of all the observations per subject, per activity.

* Write and text file with the newly created Data-subset.

***

### Downloading and Unzipping the Data into the working directory.
The files were downloaded and unzipped into the local working directory.
Download URL(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

On inspection of the UCI HAR Dataset folder the following files and directories were observed.

activity_labels.txt | features.txt | features_info.txt | README.txt | Folders containing the Test and Traning Data respectively. Both the Training and Test Data Folders contained the following folders and files:

* Folder with data on Inertial Signals (not required for this assignment)

* Files titled: subject_train.txt | X_train.txt | y_train.txt

### Understanding the file structure by reading the README files (Important).

Relevent excerpts from the README file.

* The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

* For each record it is provided:
    + Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
    + Triaxial Angular velocity from the gyroscope.
    + A 561-feature vector with time and frequency domain variables. 
    + Its activity label [Located in activity_label.txt].
    + An identifier of the subject who carried out the experiment. [Located in subject_T~.txt]

* Brief description of the help-files describing the dataset.
    + 'features_info.txt': Shows information about the variables used on the feature vector.
    + 'features.txt': List of all features.
    + 'activity_labels.txt': Links the class labels with their activity name.
    + 'train/X_train.txt': Training set.
    + 'train/y_train.txt': Training labels.
    + 'test/X_test.txt': Test set.
    + 'test/y_test.txt': Test labels.

* The following files are available for the train and test data. Their descriptions are equivalent.
    + 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

### Importing the required Data into R Studio.
The data was imported into R Studio using the as.tibble(read.table()) functions for the purposes of data wrangling by ensuring the dplyr library had been pre-loaded. This is achieved by lines 3:14 in the run_analysis.R Script

### Extracting the required Data for Columns Names.
The features.txt was read as.character() to enable using names() to label the columns of the Dataset

### Combining the Subject, Test and Training data per assignment.
Data from the Subject, Test and Training data were combined using bind_cols() in that order for the purposes of creating a 'tidy' data set. Additionally, data extraced from "y_t~.txt" (containg subject ID's) was appended to data extraced from "X_t~.txt" (containg observations). Subsequently, dplyr::bind_rows() was used to combine the Training and Test Datasets.

### Creating a subset of the Data (only Data with Mean and Std values).
dplyr::select() and contains() was used to sub-select values with "mean" and "std" strings based on information from the features_info.txt file.

### Making the Column Names more descriptive.
Using information from UCI Machine Learning website it was understood that prefixes in the column names such as "t" and "f" referred to "time" and "frequency". gsub() was used to append the same to create desciptive column names. "Acc" , "Mag" and "Gyro" too were expanded, along with, the removal of some repititious desciptions. Finally, "-" was changed to "_" for convention.

### Summarise the data-subset to include on the average values of all the observations per subject, per activity.
The data subset was grouped by 'Subject' and 'Activity' after which it was summarised by a call to mean() to obtain average values.

### Write and text file with the newly created Data-subset.
A directory named outputDir was created to easily locate the newly created data subset written in .txt format and labelled GCDC_Final_Submission_UCI_Har_Dataset.txt

***

## Description of the Variables
The dataset identifies the Subject(n = 30), the activities performed by the subjects ie WALKING | WALKING_UPSTAIRS | WALKING_DOWNSTAIRS | SITTING | STANDING | LAYING , and the associated readings from the accelerometer and gyroscope embeded in the mobile phone (Samsung Galaxy S II), worn on the waist, used for the purpose of this experiment. More information on the experiment can be viewed at (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Briefly, 3-axis (x, y, z axes) readings from both the accelerometer (linear acceleration) and gyroscope (angular velocity) were recorded. The intention behind the experiment was to ascertain if the data generated by the sensors in the mobile phone is able to correctly identify the activities being performed by the subjects. Time and Frequency readings for the following were generated.

* Body Acceleration-XYZ

* Gravity Acceleration-XYZ

* Body Acceleration Jerk-XYZ

* Body Gyroscope-XYZ

* Body Gyroscope Jerk-XYZ

* Body Acceleration Magnitude

* Gravity Acceleration Magnitude

* Body AccelerationJerk Magnitude

* Body Gyroscope Magnitude

* Body Gyroscope Jerk Magnitude

***



