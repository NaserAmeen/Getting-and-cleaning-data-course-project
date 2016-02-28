## Code book for UCI HAR dataset

This code book details the transformations made to the UCI HAR data set to convert the raw files in the UCI HAR dataset to it final transformed version `summaryData.txt` attached as part of this repo.  In the **Study Design** section details of the rawfiles are listed and the **Transformations** section details of the transformations done are listed.

### Study Design
The raw files are automatically downloaded into R's current working directory when the script `run_analysis.R` is called.  Once unzipped, the `README` file in `UCI HAR Dataset` contains details of the study design.  According to the `README` file:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. (`README`)

#### For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#### In addition to the `README` the following files are provided:
- `features_info.txt`: Shows information about the variables used on the feature vector.
- `features.txt`: List of all features.
- `activity_labels.txt`: Links the class labels with their activity name.
- `train/X_train.txt`: Training set.
- `train/y_train.txt`: Training labels.
- `test/X_test.txt`: Test set.
- `test/y_test.txt`: Test labels.

### Transformations
The  `run_analysis.R` creates a file called `test_train_merged.csv` (not included as part of this repo, but available when the script is executed). The `test_train_merged.csv` file merges the `test` and `train` data into one data set using tidy data principles shown below:
- Each type of observation unit forms a table.  Here we create a table containing `subject_id`, `activity`, `mean` and `std` variables from the raw data. Thus for each subject, and each activity a set of `mean` and `std` sampled at different frequencies are gathered.
- Descriptive names are applied to `activity` column using the keys and values available from the `activity_labels_txt` file.
- Each variable forms a column.  The `run_analysis.R` script ensures that duplicate variables are eliminated.
- Next, descriptive names are applied to each variable where the names are obtained from the `features.txt`.
- Each observation forms a row.

The next step in creating the tidy data involves, summarizing the data.  The `tidyr` library is used to convert the `test_train_merged.csv` from _wide_ format to _long_ format.  The `tidyr` library is used to create a grouping of all the `mean` and `std` measurements by `subject_id` and `activity`.  The data is then summarized by taking the mean of each measurement:

    tidy_summary <- messy %>% gather("measurement","value",-c(subject_id,activity)) %>%
                group_by(subject_id,activity,measurement) %>%
                summarise(mean_measure = mean(value)) %>%
                print

Finally, the data is written to the output file `summaryData.txt`, which is attached to this repo. The header and some lines of the file are presented below:
 
     subject_id activity                        measurement mean_measure
        (int)   (fctr)                              (chr)        (dbl)
           1   LAYING  angletBodyAccJerkMean_gravityMean  0.003060407
           1   LAYING          angletBodyAccMean_gravity  0.021365966
           1   LAYING angletBodyGyroJerkMean_gravityMean  0.084437165
           1   LAYING     angletBodyGyroMean_gravityMean -0.001666985
           1   LAYING                 angleX_gravityMean  0.426706226
           1   LAYING                 angleY_gravityMean -0.520343818
           1   LAYING                 angleZ_gravityMean -0.352413109
           1   LAYING                    fBodyAcc_mean_X -0.939099052
           1   LAYING                    fBodyAcc_mean_Y -0.867065205
           1   LAYING                    fBodyAcc_mean_Z -0.882666876

There are 30 unique subjects, and each subject are measured performing 6 activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.  For each activity 86 unique measurements are taken.  The activities and their units are shown in the table below:

Measurement | Unit
------------|-----
angletBodyAccJerkMean_gravityMean | g
angletBodyAccMean_gravity | g
angletBodyGyroJerkMean_gravityMean | rad/sec
angletBodyGyroMean_gravityMean | rad/sec
angleX_gravityMean | rad/sec
angleY_gravityMean | rad/sec
angleZ_gravityMean | rad/sec
fBodyAcc_mean_X | g
fBodyAcc_mean_Y | g
fBodyAcc_mean_Z | g
fBodyAcc_meanFreq_X | g
fBodyAcc_meanFreq_Y | g
fBodyAcc_meanFreq_Z | g
fBodyAcc_std_X | g
fBodyAcc_std_Y | g
fBodyAcc_std_Z | g
fBodyAccJerk_mean_X | g
fBodyAccJerk_mean_Y | g
fBodyAccJerk_mean_Z | g
fBodyAccJerk_meanFreq_X | g
fBodyAccJerk_meanFreq_Y | g
fBodyAccJerk_meanFreq_Z | g
fBodyAccJerk_std_X | g
fBodyAccJerk_std_Y | g
fBodyAccJerk_std_Z | g
fBodyAccMag_mean | g
fBodyAccMag_meanFreq | g
fBodyAccMag_std | g
fBodyBodyAccJerkMag_mean | g
fBodyBodyAccJerkMag_meanFreq | g
fBodyBodyAccJerkMag_std | g
fBodyBodyGyroJerkMag_mean | rad/sec
fBodyBodyGyroJerkMag_meanFreq | rad/sec
fBodyBodyGyroJerkMag_std | rad/sec
fBodyBodyGyroMag_mean | rad/sec
fBodyBodyGyroMag_meanFreq | rad/sec
fBodyBodyGyroMag_std | rad/sec
fBodyGyro_mean_X | rad/sec
fBodyGyro_mean_Y | rad/sec
fBodyGyro_mean_Z | rad/sec
fBodyGyro_meanFreq_X | rad/sec
fBodyGyro_meanFreq_Y | rad/sec
fBodyGyro_meanFreq_Z | rad/sec
fBodyGyro_std_X | rad/sec
fBodyGyro_std_Y | rad/sec
fBodyGyro_std_Z | rad/sec
tBodyAcc_mean_X | g
tBodyAcc_mean_Y | g
tBodyAcc_mean_Z | g
tBodyAcc_std_X | g
tBodyAcc_std_Y | g
tBodyAcc_std_Z | g
tBodyAccJerk_mean_X | g
tBodyAccJerk_mean_Y | g
tBodyAccJerk_mean_Z | g
tBodyAccJerk_std_X | g
tBodyAccJerk_std_Y | g
tBodyAccJerk_std_Z | g
tBodyAccJerkMag_mean | g
tBodyAccJerkMag_std | g
tBodyAccMag_mean | g
tBodyAccMag_std | g
tBodyGyro_mean_X | rad/sec
tBodyGyro_mean_Y | rad/sec
tBodyGyro_mean_Z | rad/sec
tBodyGyro_std_X | rad/sec
tBodyGyro_std_Y | rad/sec
tBodyGyro_std_Z | rad/sec
tBodyGyroJerk_mean_X | rad/sec
tBodyGyroJerk_mean_Y | rad/sec
tBodyGyroJerk_mean_Z | rad/sec
tBodyGyroJerk_std_X | rad/sec
tBodyGyroJerk_std_Y | rad/sec
tBodyGyroJerk_std_Z | rad/sec
tBodyGyroJerkMag_mean | rad/sec
tBodyGyroJerkMag_std | rad/sec
tBodyGyroMag_mean | rad/sec
tBodyGyroMag_std | rad/sec
tGravityAcc_mean_X | g
tGravityAcc_mean_Y | g
tGravityAcc_mean_Z | g
tGravityAcc_std_X | g
tGravityAcc_std_Y | g
tGravityAcc_std_Z | g
tGravityAccMag_mean | g
tGravityAccMag_std | g
_Note that g is gravitational accleration, and its unit is m/sec^2_

The `summaryData.txt` is tidy because:
* There is one variable per column
* There is one observation per row
* Each type of observation unit forms a table


 
 
