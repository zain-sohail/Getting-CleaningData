#Getting and Cleaning Data Project
#Project work for Coursera's Getting & Cleaning Data
#This file describes how the script works

Firstly, we import all the data in R environment which are required. I have done this using the read.table command. The files read include:
subject_test
subject_train
features
activity_labels
X_test
y_test
X_train
y_train

Next, I rename the subject test and train to a new name so that combining them later is easier.

Then, I make a vector of features and make the numeric column IDs in x_test & x_train to descriptive names.

Using the 'for' function, I match the y test data as well as the y train data's IDs to the Activity they are linked to and use the descriptive names.
Column names are once again changed to new names so that merging is possible and for having a descriptive name.

I am now use 'cbind' to bind the columns from all three different test datasets and all different train datasets which are then binded into a single dataframe using rbind.

The next part is where only the columns with words 'mean' & 'std' are sub-setted using the grepl fuction.
Since Subject & Activity column do not contain either of the above words, I subset that from the binded dataset earlier. 
Now I made a tidy dataset out of the four different columns I sub-setted and merging them through 'cbind'.

The last part is where we use the dplyr package
First, we convert the data into a tbl format (A Data.frame format used by dyplr)
I then group the tidy data by the Subject & Activity columns
This allows me to summarise and take the mean of each of the variables in the dataset (excl. Subject & Activity) and group them by Subject & Activity (Function used earlier)
Finally, this data is written into a text file of which a link is provided above.


The code book is provided in different formats so feel comfortable to look at any of them.