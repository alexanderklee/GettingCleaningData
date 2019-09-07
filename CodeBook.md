# Code Book for run_analysis.R

## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

## Data Set Information
### The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

### The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

### The data set includes these files:
- UCI HAR Dataset/activity_labels.txt
- UCI HAR Dataset/features.txt
- UCI HAR Dataset/test/subject_test.txt
- UCI HAR Dataset/test/X_test.txt
- UCI HAR Dataset/test/Y_test.txt

### Please refer to the UCI website for more details
### http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Structure of run_analysis.R
### This script is written in a highly linear manner and does not contain any dependent functions. The script does require the use of the dplyr and reshape2 R libraries in order to perform data frame manipulations against. The script contains these data frame variables:
- test_subjects: the data loading data frame for the subjects data set
- activity_labels: contains the activity labels data set
- feature_list: contains the feature list names
- test_dataset: contains the initial data load from the test data set
- test_activities: contains the test activities data set
- train_subjects: contains the test subject data set information
- train_dataset: contains the train data set
- train_activities: contains the training activities data set 
- testset: contains the combined data set of training and test
- sliced_testset: contains test data set with only the interesting columns
- sliced_trainset: contians training data with only the interesting columns
- final_trainset: contains the merged data set
- molten_data: contains the reshaped data from the combined set
- tidy_data: contains the tidied version of the molten data set

## This probram can be read top-down with minimal guessing as it is highly linear in execution. The code operates in this manner:

1. Program loads all dependent libraries (dplyr and reshape2)
2. Reads in all the data input files into a local data frame data structure
3. Adds column names to data frames with ambiguous titles
4. Renames data set columns using the features list names
5. Filters out columns (using grepl) for only those columns we are interested in
6. Merges the test and training data sets
7. Extracts the column averages
8. Melts (or reshapes) the final data frame for outputting to a file
7. Outputs final results to a text file


