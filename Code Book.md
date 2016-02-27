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

The most important files that `run_analysis.R` uses in transforming the 
