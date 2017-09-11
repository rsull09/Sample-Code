# HR Anlaysis

# Read in data
dat <- read.csv("C:/Users/Documents/HR_comma_sep.csv", stringsAsFactors = T)

# Change sales column name to division.
names(dat)[names(dat) == "sales"] <- "division"

# Descriptive Statistics
summary(dat)

# Linear model to predict satisfaction_level with numerical variables
satis_model <- lm(satisfaction_level~number_project + average_montly_hours + time_spend_company, data = dat)

summary(satis_model)

# Observe this model using different categories in ggplot. "Col=as.factor" indicates which data column we are using to observe
#the x and y columns with. The lines with %in% are observing the specific number of projects that an employee has.
library(ggplot2)

names(dat)

ggplot() + geom_point(data=dat, aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(left))) + ggtitle("Plot") + xlab("Average Monthly Hours")
ggplot() + geom_point(data=dat, aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(number_project)))
ggplot() + geom_point(data=dat[as.factor(dat$number_project) %in% c(2), ], aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(number_project)))
ggplot() + geom_point(data=dat[as.factor(dat$number_project) %in% c(3), ], aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(number_project)))
ggplot() + geom_point(data=dat[as.factor(dat$number_project) %in% c(4), ], aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(number_project)))
ggplot() + geom_point(data=dat[as.factor(dat$number_project) %in% c(5), ], aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(number_project)))
ggplot() + geom_point(data=dat[as.factor(dat$number_project) %in% c(6), ], aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(number_project)))
ggplot() + geom_point(data=dat[as.factor(dat$number_project) %in% c(7), ], aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(number_project)))
ggplot() + geom_point(data=dat[as.factor(dat$number_project) %in% c(6,7), ], aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(number_project)))
ggplot() + geom_point(data=dat, aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(salary)))
ggplot() + geom_point(data=dat, aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(division)))
ggplot() + geom_point(data=dat, aes(x=average_montly_hours, y=satisfaction_level, col=as.factor(promotion_last_5years)))


ggplot() + geom_point(data=dat, aes(x=number_project,       y=satisfaction_level, col=as.factor(left)))
ggplot() + geom_point(data=dat, aes(x=number_project,       y=satisfaction_level, col=as.factor(salary)))
ggplot() + geom_point(data=dat, aes(x=number_project,       y=satisfaction_level, col=as.factor(division)))
ggplot() + geom_point(data=dat, aes(x=number_project,       y=satisfaction_level, col=as.factor(promotion_last_5years)))

# This test indicates that all employees with 7 projects left the company. It also indicates that not all employees who left the company had 7 projects.
nrow(dat[dat$number_project == 7,]) == nrow(dat[dat$number_project == 7 & dat$left == 1,])
nrow(dat[dat$number_project == 7,])
nrow(dat[dat$left == 1,])

# Instead of using the average_montly_hours, these plots use the last_evalution data against satisfaction level with the other factors in a plot.
ggplot() + geom_point(data=dat, aes(x=last_evaluation, y=satisfaction_level, col=as.factor(salary)))
ggplot() + geom_point(data=dat, aes(x=last_evaluation, y=satisfaction_level, col=as.factor(left)))
ggplot() + geom_point(data=dat, aes(x=last_evaluation, y=satisfaction_level, col=as.factor(division)))
ggplot() + geom_point(data=dat, aes(x=last_evaluation, y=satisfaction_level, col=as.factor(promotion_last_5years)))
ggplot() + geom_point(data=dat, aes(x=last_evaluation, y=satisfaction_level, col=as.factor(number_project)))

# This is the correlatiion of last_evaluation with average_montly_hours. It is weak correlation 0.3397.
cor(dat$last_evaluation,dat$average_montly_hours)

# This is a RandomForest prediction of the type of employees who would leave.
library(caret)
library(randomForest)

set.seed(178)
test_index <- sample(1:nrow(dat),6000)
test_dat <- dat[test_index, ]
train_dat <- dat[-test_index, ]

rf_model <- randomForest(as.factor(left)~., data=train_dat)
pred_test_dat <- predict(rf_model, test_dat)
confuse <- data.frame(unname(pred_test_dat), as.factor(test_dat$left))
confuse_tab <- table(confuse)
confusionMatrix(confuse_tab)
