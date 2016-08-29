# courseraHCI
#Getting and Cleaning Data program assignement week 4

#Human Activity Recognition Using Smartphones Data Set

This README.md first cites sources of the data (Source, Data Set Information, Citation Request, ttribute Information).

Finally, it described the modifications done to answer the programm assignement.

##Source:

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws 

## Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset.

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [Web Link]

An updated version of this dataset can be found at [Web Link]. It includes labels of postural transitions between activities and also the full raw inertial signals instead of the ones pre-processed into windows. 

## Citation Request:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
Attribute Information:

## Attribute Information:

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment. 

## Modifications
The original files we use are:
    For the test set:
    subject_test.txt (Ids of subjects), Y_test.txt (Ids of Activities) and X_test.txt (Measurements)
    For the train set:
    subject_train.txt (Ids of subjects), Y_train.txt (Ids of Activities) and X_train.txt (Measurements)
    
The script run._analysis.R perfomrs the following transformations:
- read and merge these file in one data frame named "dataset". 
- Subsetting this dataset by keeping only the varaibles involving mean() or std(). This dataset has 10299 observations of 88 variables. The name of this subset is still "dataset".
- renames the 88 variables to be more descriptive (see the CodeBook.md). The variable 1 is "Subject". The variable 2 is "Acitivity". The following 86 variables are measurements variables.
- creates a second data frame named "tidydataset" summarizing the mean of each of the 86 measurements variables along the 10299 observations for each subject and each activity. There are 30 subjects and 6 activities so the tidydataset contains 180 rows along 88 variables.
