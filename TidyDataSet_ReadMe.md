The following README file describes the run_analysis.R script developed for the Johns Hopkins "Getting and Cleaning Data" course.

SUMMARY DESCRIPTION:

The script utilizes source data files provided by the course to extract, transform, load and analyze detailed observation data generated by an experiment entitled, "Human Activity Recognition Using Smartphones Dataset".

Details relating to the source data variables and the text file generated by this script are addressed in the associated TidyDataSet_CodeBook.txt file.

The objective of this script is to load the detail observation data created by the experiment and calculate the mean of those observations for each unique combination of volunteer (subject), activity and variable.

Overall, the process performs the following steps:

1) Loads each group of source data files into tables.
2) Extracts only the variables related to mean and standard deviation measurements using descriptive variable names.
3) Merges the two groups of tables into a single dataset.
4) Applies descriptive activity names to the dataset.
5) Uses ddplyr to group the data by volunteer (subject) and activity and calculate the mean for each of the 79 feature variables.
6) Exports the results of the analysis to a tab delimited text file. 


DETAIL PROCESS DESCIPTION:

The script initiates the process by creating the reference files for the activity names and column names that will be used later in the script.

Source data is divided into two separate file sets that must be loaded and merged into a single dataset.  The script processes the "Test" file set first and the "Train" file set second.  Each file set is identically structed but contains different detail observation data.

For each file set, the script loads the files into data tables in the following order:

1) volunteer (subject) file
2) activity file
3) observation data file

After loading the three files, the process extracts only the 79 variables in the observation data that reference means or standard deviations.

The three tables are then combined into a single table with columns from each of the individual tables.

The combined tables for each group are then merged to single table containing all detail observations from both groups.

The merged table is updated to apply descriptive activity names.

Final analysis is performed using ddplyr to generate a summary table containing means for each combination of volunteer, activity and measurement.

The final summary table is then exported as a tab delimited text file.

AUTHORED BY:
D. Feger
Johns Hopkins "Getting and Cleaning Data" course project.
 