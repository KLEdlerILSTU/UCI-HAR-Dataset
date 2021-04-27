---
title: "README"
author: "Kate Edler"
date: "4/21/2021"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Files included in the repository

* README.Rmd: A markdown file that describes the code used in the analysis
* run_analysis.R: An R script that takes a set of raw data files and outputs a text file, summarydata.txt
* CodeBook.Rmd: A markdown file that contains a description of all variables

## Loading run_analysis

An R script file, "run_analysis.R", has been created to combine and analyze particular data files and summarize the output in "summarydata.txt". For the script to run properly, the data files and run_analysis.R must be in your working directory. Once you have these files in your working directory, the script can be called to perform the analysis with:

```{r, message = FALSE}
        source("run_analysis.R")
```

## Inner Workings of run_analysis.R

### Merge the training and the test sets to create one data set

The first step in the analysis is to create one untidy data set by reading in all of the data files and merging them. The data files to read in should all be in the same working directory as the run_analysis.R script. The data files are:

* X_train.txt: contains accelerometer and gyroscope measurements for ~70% of randomly selected data points;
* y_train.txt: contains the corresponding activity factor level for the X_train.txt data set;
* subject_train.txt: contains the corresponding subject identifier for the X_train.txt data set;
* X_test.txt: contains accelerometer and gyroscope measurements for ~30% of randomly selected data points;
* y_test.txt: contains the corresponding activity factor level for the X_test.txt data set;
* subject_test.txt: contains the corresponding subject identifier for the X_test.txt data set;

The R code used to read all of the data files in is as follows:

```{r}
        subject.test <- read.table("subject_test.txt")
        subject.train <- read.table("subject_train.txt")
        y.test <- read.table("y_test.txt")
        y.train <- read.table("y_train.txt")
        x.test <- read.table("X_test.txt")
        x.train <- read.table("X_train.txt")
```

The first step in merging these data files is to create two separate data sets: a full test data set and a full train data set that each includes the subject, activity, and measurements. To accomplish this in R, the data files need to be column bound:

```{r}
        test.data <- cbind(subject.test, y.test, x.test)
        train.data <- cbind(subject.train, y.train, x.train)
```

Once these data sets exist, they can be merged together to create one (untidy) data set with the following code:

```{r}
        full.data <- rbind(test.data, train.data)
```

### Extract only the measurements on the mean and standard deviation for each measurement

Before the mean and standard deviation for each measurement are extracted from the data set, the columns need headers to indicate what kind of measurement or calculation they contain. A new data file needs to be read into R (features.txt) that contains these headers. The subject identifier column and activity factor level column are named simply by typing in the column name. Columns are selected in R by subsetting by column position. The following R code completes all of the tasks described above.

```{r}
        features <- read.table("features.txt")
        colnames(full.data)[1]  <- "Subject"
        colnames(full.data)[2]  <- "Activity"
        colnames(full.data)[3:563]  <- features$V2
```

Now that all the columns have headers, the dplyr package is used to easily select any column that matches the string "mean" or "std" (std refers to standard deviation). The "Subject" column and "Activity" column are also needed in the tidy data set, so those strings are included in ones to match. Since dplyr is used in this part of the script, the code first checks to see if dplyr is installed. If it is, dplyr is loaded. If dplyr is not installed, the code installs it and then loads it.

```{r}
        if (!require("dplyr", character.only = TRUE)) {
                        install.packages("dplyr", dependencies = TRUE)
                        library("dplyr", character.only = TRUE)
                }
        small.data <- select(full.data, matches('Subject|Activity|mean|std'))
```

At this point, I made a decision to eliminate columns that matched the string "meanFreq" and "angle." These columns did not meet the criteria for being a "mean" calculation, even though the column headers contained the string "mean." The "meanFreq" is calculated by using a weighted average (not strictly a mean). The "angle" columns contained an angle between two vectors, one of which was a vector containing a mean (why it matched through the first selection). To eliminate these columns from further analysis, the following command was deployed:

```{r}
        small.data <- select(small.data, -matches('meanFreq|angle'))
```

### Use descriptive activity names to name the activities in the data set

With the columns narrowed down, the next step is to label everything clearly with descriptive names. First, the numbers in the activity column need to be replaced with text descriptions of what each activity is. There is a data file included with the project (activity_labels.txt) that indicates what each number in the activity column is. This file does not need to be read into R, just referenced while assigning new values to each number. The following R script accomplishes this task:

```{r}
        small.data$Activity[small.data$Activity == 1] <- "walking"
        small.data$Activity[small.data$Activity == 2] <- "walkingupstairs"
        small.data$Activity[small.data$Activity == 3] <- "walkingdownstairs"
        small.data$Activity[small.data$Activity == 4] <- "sitting"
        small.data$Activity[small.data$Activity == 5] <- "standing"
        small.data$Activity[small.data$Activity == 6] <- "laying"
```

In the interest of applying descriptive (and tidy) properties, names were all lowercase letters and completely spelled out. Further, there were no special characters or spaces used in these label names.

### Label the data set with descriptive variable names

Using purely descriptive variable names is a bit more difficult to accomplish since each name needs to convey a lot of information. I chose to leave some abbreviations, while spelling out others based purely on what was confusing to me. Further, capital letters were utilized in the variable names to break up the different words/abbreviations. Each abbreviation and meaning is fully spelled out in the Code Book file. Also, any metacharacters and typos were corrected as necessary. As a summary, I changed the abbreviation "Acc" to "LinearAcc," "Gyro" to "AngVelocity," "Mag" to "Magnitude," "-mean()-" and "-mean()" to "Mean" (eliminating the metacharacters -, (, and)), "-std()-" and "-std()" to Std (eliminating the same metacharacters as in mean), and "fBodyBody" to "fBody" (correcting the duplicate use of Body). All of these replacements can be made using the following code: 

```{r}
        names(small.data) <- gsub(x = names(small.data), pattern = "Acc", replacement = "LinearAcc")
        names(small.data) <- gsub(x = names(small.data), pattern = "Gyro", replacement = "AngVelocity")
        names(small.data) <- gsub(x = names(small.data), pattern = "Mag", replacement = "Magnitude")
        names(small.data) <- gsub(x = names(small.data), pattern = "\\-mean\\(\\)\\-", replacement = "Mean")
        names(small.data) <- gsub(x = names(small.data), pattern = "\\-mean\\(\\)", replacement = "Mean")
        names(small.data) <- gsub(x = names(small.data), pattern = "\\-std\\(\\)\\-", replacement = "Std")
        names(small.data) <- gsub(x = names(small.data), pattern = "\\-std\\(\\)", replacement = "Std")
        names(small.data) <- gsub(x = names(small.data), pattern = "fBodyBody", replacement = "fBody")
```

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject

From the smaller, tidy data set, the data is grouped by subject and then by type of activity. The mean function is run for each of these combinations and the output is written into a separate text file called "summarydata.txt." The R code to accomplish this is as follows:

```{r}
        summary.data <- summarise_all(group_by(small.data, Subject, Activity), mean)
        write.table(summary.data, file = "summarydata.txt", row.names = FALSE)
```

To read this text file back into R, this code would be used:

```{r, results = FALSE}
        read.table("summarydata.txt", header = TRUE)
```