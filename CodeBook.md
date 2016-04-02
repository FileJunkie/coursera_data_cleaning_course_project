# Code book

## Used data

The data, which is used by this script, is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. From this zip archive, the following files from the `UCI HAR Dataset` directory are used:

* `activity_labels.txt` contains the list of activities performed by the test subject, mapped to their integer codes
* `features.txt` contains the list of the names of feature variables
* `train/X_train.txt` and `test/X_test.txt` contain feature vectors for training and test data respectively
* `train/subject_train.txt` and `test/subject_test.txt` contain the numbers of subjects, to which the mentioned feature vector data belong to
* `train/y_train.txt` and `test/y_test.txt` describe which activity was happening when the mentioned data was measured

## Data transformation

Data is transformed by the script in the following steps:

* Activity and features labels are loaded
* Using the features names, a vector, to be used later to only use feature values containing words `mean` and `std` (standard deviation) is prepared
* Feature names are renamed to be more readable - `t` and `f` prefixes are replaced with full words `time` and `frequency`, another abbreviations are replaces with the full words (`Acc` -> `gcceleration`, `Gyro` -> `gyroscope`, `Mag` -> `magnitude`) with dots between them. Also, the names are decapitalized and potential double-dots in the names are removed
* Variable vectors are read from `X_train.txt` and `X_test.txt` files using feature variable names from `features.txt` as column names
* Mentioned data is filtered by removing unnecessary variables (see before)
* Subject test data is read from `subject_train.txt` and `subject_test.txt`, as well as activity data from `y_train.txt` and `y_test.txt`
* Subject data is added to variables data frame as a new column, which now contains the numbers of subjects, for which the data was gathered
* Activity data is merged with activity labels, and these labels are appended to the the feature variables matrices as a new row
* Feature variable data frames get columns `type`, containing word `train` or `test`, depending on from which file were they read
* Feature variable data frames are merged into one data frame
* Newly-added columns in the data frame are moved to the beginning
* Resulting data frame is written to the file named `result.txt`

## Variable description

Three variables have simple names:

* `subject` - the number of the subject
* `activity` - contains the activity name
* `type` - contains the data type - `train` or `test`

Other variables are normalized to [-1;1] and have complex names which should be described part-by-part:

* Every variable has `time` or `frequency` prefix - in the first case, the signal is a time domain signal, in the case, the signal is the frequency domain signal after Fast Fourier Transform (FFT)
* Every variable has `mean` or `std` in its name, meaning that this variable has either mean or standard deviation of a measurement
* Some variables have `X`, `Y` or `Z` suffix, which denotes that they contain the respective components of the signal
* `body`/`gravity` part denoted that variable contains the body or gravity acceleration component
* `acceleration`/`gyroscope` part shows whether is it linear acceleration or gyroscrope data (angular velocity)
* `jerk` values are derivatives in time for the previous values
* `magnitude` shows that variable contains the magnitude of a signal calculated using the Euclidian form

**Examples**:
* `time.body.gyroscope.mean.Y` - mean of the signal in the time domain, angular velocity, body compontent, Y axis
* `frequency.body.acceleration.jerk.std.X` - standard deviation of the X component of the derivative (jerk value) of linear acceleration of body, in frequency domain (after FFT)
