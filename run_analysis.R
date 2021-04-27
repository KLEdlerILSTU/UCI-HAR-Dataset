##Merges the training and the test sets to create one data set.
        ## Read all data files
        
                subject.test <- read.table("subject_test.txt")
                subject.train <- read.table("subject_train.txt")
                y.test <- read.table("y_test.txt")
                y.train <- read.table("y_train.txt")
                x.test <- read.table("X_test.txt")
                x.train <- read.table("X_train.txt")
        
        ## Compile separate test data set and train data set
                
                test.data <- cbind(subject.test, y.test, x.test)
                train.data <- cbind(subject.train, y.train, x.train)
                
        ## Merge the compiled test and train data sets
                
                full.data <- rbind(test.data, train.data)

##Extracts only the measurements on the mean and standard deviation for each measurement.
                
        ## Give columns names
                
                features <- read.table("features.txt")
                colnames(full.data)[1]  <- "Subject"
                colnames(full.data)[2]  <- "Activity"
                colnames(full.data)[3:563]  <- features$V2
                
        ## Select columns whose name contains "mean" or "std" (along with subject and activity)
        ## Check to see if dplyr package needs to be installed
                
                if (!require("dplyr", character.only = TRUE)) {
                        install.packages("dplyr", dependencies = TRUE)
                        library("dplyr", character.only = TRUE)
                }
                
                small.data <- select(full.data, matches('Subject|Activity|mean|std'))
                
        ## Remove columns that include "meanFreq" and "angle"
                
                small.data <- select(small.data, -matches('meanFreq|angle'))


##Uses descriptive activity names to name the activities in the data set

                small.data$Activity[small.data$Activity == 1] <- "walking"
                small.data$Activity[small.data$Activity == 2] <- "walkingupstairs"
                small.data$Activity[small.data$Activity == 3] <- "walkingdownstairs"
                small.data$Activity[small.data$Activity == 4] <- "sitting"
                small.data$Activity[small.data$Activity == 5] <- "standing"
                small.data$Activity[small.data$Activity == 6] <- "laying"

##Appropriately labels the data set with descriptive variable names. 

                names(small.data) <- gsub(x = names(small.data), pattern = "Acc", replacement = "LinearAcc")
                names(small.data) <- gsub(x = names(small.data), pattern = "Gyro", replacement = "AngVelocity")
                names(small.data) <- gsub(x = names(small.data), pattern = "Mag", replacement = "Magnitude")
                names(small.data) <- gsub(x = names(small.data), pattern = "\\-mean\\(\\)\\-", replacement = "Mean")
                names(small.data) <- gsub(x = names(small.data), pattern = "\\-mean\\(\\)", replacement = "Mean")
                names(small.data) <- gsub(x = names(small.data), pattern = "\\-std\\(\\)\\-", replacement = "Std")
                names(small.data) <- gsub(x = names(small.data), pattern = "\\-std\\(\\)", replacement = "Std")
                names(small.data) <- gsub(x = names(small.data), pattern = "fBodyBody", replacement = "fBody")


##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
                
                summary.data <- summarise_all(group_by(small.data, Subject, Activity), mean)
                write.table(summary.data, file = "summarydata.txt", row.names = FALSE)