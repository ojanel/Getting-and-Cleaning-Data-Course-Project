# Getting-and-Cleaning-Data-Course-Project
The repo contain a script that read data from the UCI HAR Dataset and creates a tidy one with the average of each mean 
and standard variables, for each activity and each subject.

The different steps are :

1 - We read the data from "~/features.txt" and store it in the data frame named features. 
    We will use it later to label the variables of the test and training datasets. 
    
2 - We read the data from "./features.txt" and store it in the data frame named actlabels. 
    It will be used to map the activities in the dataset
 
3 - Measurements training and test data
  3.1 Data are read from "~/train/X_train.txt" and "~/test/X_test.txt" and then clipped in the dataframe Xdata.
  3.2 Variables are labeled using the data frame Features. 
      It is done at this stage to easily extract measure we need based on column names (in 3.3)
  3.3 We extract only the mean and standard deviation for each mesurement using a regular expression and store it in measure.
  3.4 We appropriately labels the data set with descriptive variable names.
      The prefixes t and f are replace with "time signal" and "frequence signals"
      The truncated names like , "Gyro" etc. are extended ("Acc" becomes "accelerometer", "Mag" becomes "magnitude").
      Please refers to the code book for details.
 
4 - Activity training and test data
  4.1 Data are read from "~/train/y_train.txt" and "~/test/y_test.txt" and then clipped in the dataframe activity.
  4.2 The variable is labeled "activity". 


5 - Subject training and test data
  5.1 Data are read from "~/train/subject_train.txt" and "t~/test/subject_test.txt" and then clipped in the dataframe subject.
  5.2 The variable is labeled "qubject". 
      
6 - The datasets are merged

7 - We used the actlabels to map the activities in the dataset (we replace the id by the corresponding activity)

8 - We create from the dataset an independent tidy data set with the average of each variable for each activity and each subject.
    We first melt the data to distinct ids and measures and then use dcast with the mean function.
