# Sample-Code
Sample Code in R

This code is analyzing a Human Resources dataset with the intent of discovering why employees at a company leave prematurely. The dataset used is Human Resources Analytics from Kaggle, located here (https://www.kaggle.com/ludobenistant/hr-analytics).

Observing the data, it is clear that employees who leave are in two particular groups - underpaid, overworked employees, and underutilized, advancement seeking employees. The first set of employees, the overworked ones, are observed in the bottom right of the plots made. These employees are low to middle pay, and have 6 to 7 projects, and poor performance reviews. All of them left the company. The second set of employees are a bit harder to understand, they are the square on the middle right of the plots. They are low to middle pay, and have only 2 to 3 project and little advancement. This, to me, indicates that they are leaving the company to persue more advanced career positions at other companies. 

Additionally, I used a randomForest to predict the type of employee most likely to leave the company. The dataset was partitioned into a training set (60%) and a testing set (40%). The confusion matrix for the model indicates that it has a very strong predictibility of 99%.
