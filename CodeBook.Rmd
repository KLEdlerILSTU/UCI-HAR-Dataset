---
title: "Code Book"
author: "Kate Edler"
date: "4/26/2021"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Variable Descriptions

The tidied data set contains 68 variables. Instead of describing each variable individually, the following table can be used to decipher the full meaning of any variable and how it was calculated.

Variable Snippet | Variable Description | Measurement Information and Units
------------- | ------------- | -------------
Subject | The subject identifier for each measurement. | The value range is 1-30.
Activity | The activity performed during the measurement. | There are six categories of activites: walking, walking upstairs, walking downstairs, sitting, standing, and laying.
t | Time domain signals collected at a rate of 50 Hz. Data were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
f | Frequency domain signals calculated by applying a Fast Fourier Transform (FFT) to the time domain signal.
Body | The portion of the accelerometer measurement attributed to the subject.
Gravity | The portion of the accelerometer measurement attributed to gravity.
LinearAcc | A linear acceleration measurement taken by the accelerometer. | Linear acceleration units are m/s^2^.
AngVelocity | An angular velocity measurement taken by the gyroscope. | Angular velocity units are rad/s.
Jerk | Jerk was calculated by taking the derivative in time of the measurement. | Jerk units for linear acceleration measurements are m/s^3^, while jerk units for angular velocity measurements are rad/s^2^.
Magnitude | The magnitude of the three-dimensional signals were calculated using the Euclidean norm.
Mean | The mean calculated of a given measurement.
Std | The standard deviation calculated of a given measurement.
X, Y, or Z | Indicates the three-dimensional direction of the measurement.

The full variable list can be obtained by combining these various snippets.

* Subject
* Activity
* tBodyLinearAccMeanX              
* tBodyLinearAccMeanY
* tBodyLinearAccMeanZ
* tBodyLinearAccStdX               
* tBodyLinearAccStdY
* tBodyLinearAccStdZ
* tGravityLinearAccMeanX           
* tGravityLinearAccMeanY
* tGravityLinearAccMeanZ
* tGravityLinearAccStdX            
* tGravityLinearAccStdY
* tGravityLinearAccStdZ
* tBodyLinearAccJerkMeanX          
* tBodyLinearAccJerkMeanY
* tBodyLinearAccJerkMeanZ
* tBodyLinearAccJerkStdX           
* tBodyLinearAccJerkStdY
* tBodyLinearAccJerkStdZ
* tBodyAngVelocityMeanX            
* tBodyAngVelocityMeanY
* tBodyAngVelocityMeanZ
* tBodyAngVelocityStdX             
* tBodyAngVelocityStdY
* tBodyAngVelocityStdZ
* tBodyAngVelocityJerkMeanX        
* tBodyAngVelocityJerkMeanY
* tBodyAngVelocityJerkMeanZ
* tBodyAngVelocityJerkStdX         
* tBodyAngVelocityJerkStdY
* tBodyAngVelocityJerkStdZ
* tBodyLinearAccMagnitudeMean
* tBodyLinearAccMagnitudeStd
* tGravityLinearAccMagnitudeMean
* tGravityLinearAccMagnitudeStd    
* tBodyLinearAccJerkMagnitudeMean
* tBodyLinearAccJerkMagnitudeStd
* tBodyAngVelocityMagnitudeMean    
* tBodyAngVelocityMagnitudeStd
* tBodyAngVelocityJerkMagnitudeMean
* tBodyAngVelocityJerkMagnitudeStd 
* fBodyLinearAccMeanX
* fBodyLinearAccMeanY
* fBodyLinearAccMeanZ              
* fBodyLinearAccStdX
* fBodyLinearAccStdY
* fBodyLinearAccStdZ               
* fBodyLinearAccJerkMeanX
* fBodyLinearAccJerkMeanY
* fBodyLinearAccJerkMeanZ          
* fBodyLinearAccJerkStdX
* fBodyLinearAccJerkStdY
* fBodyLinearAccJerkStdZ           
* fBodyAngVelocityMeanX
* fBodyAngVelocityMeanY
* fBodyAngVelocityMeanZ            
* fBodyAngVelocityStdX
* fBodyAngVelocityStdY
* fBodyAngVelocityStdZ             
* fBodyLinearAccMagnitudeMean
* fBodyLinearAccMagnitudeStd
* fBodyLinearAccJerkMagnitudeMean  
* fBodyLinearAccJerkMagnitudeStd
* fBodyAngVelocityMagnitudeMean
* fBodyAngVelocityMagnitudeStd     
* fBodyAngVelocityJerkMagnitudeMean
* fBodyAngVelocityJerkMagnitudeStd
