run_analysis.R is a script that downloads data collected from the accelerometers from the Samsung Galaxy S smartphone, cleans the data, and
creates a tidy data set. 

The data file is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The script performs the following:

1) download data from website
2) merge the training and test datasets into one dataset.
3) extracts only the mean and standard deviation for each variable.
4) renames the rows and columns using descriptive labels.
5) creates a second tidy data set with the mean for each activity and each subject.

The tidy data set is titled "ActivityData" and has been grouped by "Activity" and then "Subject".

Each of the 6 Activities include observations for each of the 30 subjects tested. The observation data consists of the mean of the means and standard deviations for the signal pattern measurements (78 total) from the smartphones dataset.


