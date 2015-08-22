
Introduction

The script run_analysis.R performs the 5 steps dfined in the course project's requirements.

* Step 0: this first steps prepares the working directory and download the untidy data for the rest of the script. Be patient because the downloading and unzipping of the data takes some many minutes.

* Step 1: using rbind() function, we merge the training and testing data into one data set.

* Step 2: We extract the columns with mean and standard deviation filtering the data by the match of each column with the variable names identified in the features.txt file. Using this file, we also properly renames the columns by its corresponding labels.

* Step 3: We properly relabel the activities identification replacing their number code by its names presents in the activities_label.txt file.

* Step 4: We properly relabel the activities identification replacing their number code by its names presents in the activities_label.txt file.

* Step 5: We generate the final dataset with all the average and standar deviations measures for each subject and activity type. The output file is in this repository under the name "averages_and_std_data.txt"

Variables

* trainX, trainY, testX, testY, trainSubject and testSubject contain the data from the downloaded files.
* dataX, dataY and dataSubj merge the previous datasets to further analysis.
* features contains the correct names for the X ata dataset. 
* meanStdfeatures is a numeric vector used to extract the desired data.
* activityNames contains the names of the activities measured.
* dataX merges x_data
* dataY merges y_data
* dataSubj mergres subject_data

Finally, averages_data contains the relevant averages which will be later stored in a .txt file.

