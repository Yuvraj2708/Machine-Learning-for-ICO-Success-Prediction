# Install and load the necessary packages

library(readr)

library(ggplot2)
library(dplyr)
library(cowplot)
library(zoo)
install.packages("corrplot")
library(corrplot)
library(reshape2)
library(corrgram)

install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)
install.packages("VIM",dependencies = T)
library("VIM")

library(caret)
library(pROC)

library(randomForest)
library(stringr)

raw_data <- read_csv("/Users/yuvrajsingh/Modules/ML_Practice/LUBS5990M_courseworkData_2324.csv")

raw_data1 <- raw_data
# check the first six 
head(raw_data)
# View the structure of the dataset
str(raw_data)

# Summary statistics
summary(raw_data)



#Dimensions
dim(raw_data)
#the dataset has 2,767 rows and 15 columns
#data on 2,767 ICOs with 15 features

## Appendix --------------------------------------------------------- 1 
# Numeric variables 
numeric_vars <- sapply(raw_data, is.numeric) 
numeric_names <- names(numeric_vars[numeric_vars]) 
# Integer variables 
integer_vars <- sapply(raw_data, is.integer) 
integer_names <- names(integer_vars[integer_vars]) 
# Character variables 
character_vars <- sapply(raw_data, is.character) 
character_names <- names(character_vars[character_vars]) 
# Factor variables 
factor_vars <- sapply(raw_data, is.factor) 
factor_names <- names(factor_vars[factor_vars]) 
# Logical variables 
logical_vars <- sapply(raw_data, is.logical) 
logical_names <- names(logical_vars[logical_vars]) 
cat("Numeric variables:", "\n") 
print(numeric_names) 
cat("\nInteger variables:", "\n") 
print(integer_names) 
cat("\nCharacter variables:", "\n") 
print(character_names) 
cat("\nFactor variables:", "\n") 
print(factor_names) 
cat("\nLogical variables:", "\n") 
print(logical_names) 

# # Appendix  --------------------------------------------------------------------------------- 2 

# View the structure of the raw_dataset 
str(raw_data) 
# Summary statistics 
summary(raw_data) 
# Appendix --------------------------------------------------------------------------------- 3 
histd1 <- hist(raw_data$priceUSD) 
histd1  
# Appendix --------------------------------------------------------------------------------- 4 
# Draw histogram 
hist_coinNum <- hist(raw_data$coinNum) 
boxplot_coinNum <- boxplot(raw_data$coinNum) 
# Print histogram information 
print(hist_coinNum) 
# Appendix --------------------------------------------------------------------------------- 5 
# Draw boxplot 
boxplot_distributedPercentage <- boxplot(raw_data$distributedPercentage) 
# Print boxplot information 
print(boxplot_distributedPercentage) 
# Appendix --------------------------------------------------------------------------------- 6 
rev(sort(table(raw_data$countryRegion))) 
# Appendix --------------------------------------------------------------------------------- 7 
table(raw_data$platform) 
# Appendix --------------------------------------------------------------------------------- 8 
 
platform_freq <- table(raw_data$platform) 
 
# Convert the table to a data frame 
platform_df <- as.data.frame(platform_freq) 
 
# Set column names 
names(platform_df) <- c("Platform", "Frequency") 
 
# Sort the data frame by frequency 
platform_df <- platform_df[order(-platform_df$Frequency), ] 
wordcloud_platform <- wordcloud(words = platform_df$Platform, freq = 
platform_df$Frequency, min.freq = 1, 
                                max.words = 80, random.order = FALSE, colors = brewer.pal(8, "Dark2"), 
                                scale = c(3, 0.5), rot.per = 0.3, random.color = TRUE, 
                                family = "sans", bg = "white", 
                                title.size = 1.5, title.color = "darkblue", title.bold = TRUE, 
                                random.seed = 42) 
 
# Add informative title for platform word cloud 
title(main = "Word Cloud of Platform Names", col.main = "darkblue", font.main = 4) 
 
# Appendix --------------------------------------------------------------------------------- 9 
raw_data[is.na(raw_data$priceUSD),"priceUSD"] <- median(raw_data$priceUSD, na.rm 
=TRUE) 
summary(raw_data$priceUSD) 
 
# Appendix --------------------------------------------------------------------------------- 10 
raw_data$priceUSD[raw_data$priceUSD == 0] <- median(raw_data$priceUSD) 
summary(raw_data$priceUSD) 
 
# Appendix --------------------------------------------------------------------------------- 11 
 
filter(raw_data, priceUSD == 39384) 
raw_data <- raw_data[-384,] 
filter(raw_data, priceUSD == 39384) 
# Appendix --------------------------------------------------------------------------------- 12 
# Histogram of teamSize variable 
hist(raw_data$teamSize,  
main = "Histogram of Team Size",  
xlab = "Team Size", 
ylab = "Frequency", 
col = "skyblue", 
border = "black") 
# Appendix --------------------------------------------------------------------------------- 13 
raw_data[is.na(raw_data$teamSize), "teamSize"] <- median(raw_data$teamSize, na.rm = 
TRUE) 
summary(raw_data$teamSize) 
# Appendix --------------------------------------------------------------------------------- 14 
# Find the highest value in coinNum 
highest_value <- max(raw_data$coinNum) 
# Find the position of the highest value in coinNum 
position <- which.max(raw_data$coinNum) 
# Print the highest value and its position 
cat("Highest value in coinNum:", highest_value, "\n") 
cat("Position of highest value:", position, "\n") 
which(raw_data$coinNum == 22619078416760300) 
raw_data <- raw_data[-1592,] 
filter(raw_data, coinNum == 22619078416760300) 
# Appendix --------------------------------------------------------------------------------- 15 
filter(raw_data, distributedPercentage == 0) 
filter(raw_data, distributedPercentage > 1) 
raw_data <- raw_data[raw_data$distributedPercentage <= 1,] 
raw_data <- raw_data[raw_data$distributedPercentage != 0,] 
filter(raw_data, distributedPercentage == 0) 
filter(raw_data, distributedPercentage > 1) 
# Appendix --------------------------------------------------------------------------------- 16 
table(raw_data$countryRegion) 
raw_data$countryRegion[nchar(raw_data$countryRegion) == 0] <- "unknown" 
table(raw_data$countryRegion) 
# Appendix --------------------------------------------------------------------------------- 17 
raw_data$countryRegion[raw_data$countryRegion == "india"] <- "India" 
raw_data$countryRegion[raw_data$countryRegion == "México"] <- "Mexico" 
raw_data$countryRegion[raw_data$countryRegion == "SINGAPORE"] <- "Singapore" 
raw_data$countryRegion[raw_data$countryRegion == "usa"] <- "USA" 
table(raw_data$countryRegion) 
# Appendix --------------------------------------------------------------------------------- 18 
raw_data$platform <- gsub("\\s+","",raw_data$platform) # To remove spaces in names of 
platform and replace it with nothing 
raw_data$platform <- tolower(raw_data$platform) # To convert names of platform to lower 
case 
table(raw_data$platform)  
# Appendix --------------------------------------------------------------------------------- 19 
raw_data$platform[raw_data$platform == "btc"] <- "bitcoin" 
raw_data$platform[raw_data$platform == "stellarprotocol"] <- "stellar" 
raw_data$platform[raw_data$platform == "x11blockchain"] <- "x11" 
raw_data$platform[raw_data$platform == "eth"] <- "ethereum" 
raw_data$platform[raw_data$platform == "ethererum"] <- "ethereum" 
raw_data$platform[raw_data$platform == "etherum"] <- "ethereum" 
raw_data$platform[raw_data$platform == "pos,pow"] <- "pos+pow" 
raw_data$platform[raw_data$platform == "pow/pos"] <- "pos+pow" 
raw_data$platform[nchar(raw_data$platform) == 0] <- "unknown" 
table(raw_data$platform) 
# Appendix --------------------------------------------------------------------------------- 20 
raw_data[,"startDate"] <- as.Date(raw_data[,"startDate"],format = "%d/%m/%Y") 
raw_data[,"endDate"] <- as.Date(raw_data[,"endDate"],format = "%d/%m/%Y") 
raw_data$Duration_of_campaign <- difftime(raw_data$endDate,raw_data$startDate, units = 
"days") 
str(raw_data$Duration_of_campaign) 
# Appendix --------------------------------------------------------------------------------- 21 
raw_data <- raw_data[, - c(1,3,8,9)] 
str(raw_data) 
# Appendix --------------------------------------------------------------------------------- 22 
# # Appendix --------------------------------------------------------------------------------- 22 
ico_dt <- raw_data 
#str(raw_data) 
#Converting character features to factors 
ico_dt[,c("success", "countryRegion", "platform")] <- lapply(ico_dt[,c("su 
ccess", "countryRegion", "platform")], factor) 
#str(ico_dt) 
#Separating Training and Test data 
smp_size <- floor(0.9 * nrow(ico_dt)) 
set.seed(12345) 
train_ind <- sample(nrow(ico_dt), smp_size) 
ico_dt_train <- ico_dt[train_ind, ] 
ico_dt_test <- ico_dt[-train_ind, ] 
ico_dt_test_labels <- ico_dt[-train_ind, "success"] 
ico_dt_test_labels 
# Checking the distribution of classes in training and testing data 
prop.table(table(ico_dt_train$success)) 
prop.table(table(ico_dt_test $success)) 
#Training the model 
library(C50) 
library(tidyverse) 
dt_model <- C5.0(success ~ ., ico_dt_train, rules = TRUE) 
dt_model 
summary(dt_model) 
#Evaluating the performance of DT model 
dt_pred <- predict(dt_model, ico_dt_test, type = "prob" ) 
dt_pred1 <- predict(dt_model, ico_dt_test) 
dt_pred 
#Developing ROC Curve 
library(ROCR) 
predict_object <- prediction(dt_pred[,2],ico_dt_test_labels) 
roc_DT <- performance(predict_object, measure = "tpr", x.measure = "fpr") 
plot(roc_DT, main = "ROC curve for Decision Tree Model", col = "blue", lwd 
= 2) 
abline(a = 0, b = 1, lwd = 2, lty = 2) 
auc_object_DT <- performance(predict_object, measure = "auc") 
auc_object_DT 
auc_object_DT@y.values[[1]] 
#Getting other metrics Accuracy, Sensitivity, Specificity, Precision, F-me 
asure 
library(caret) 
?confusionMatrix 
keymetric_DT <- confusionMatrix(dt_pred1 , ico_dt_test_labels, positive = 
"Y", mode = "everything") 
keymetric_DT 
# Appendix --------------------------------------------------------------------------------- 23  
#Model based on Adaptive Boosting 
dt_boost <- C5.0(select(ico_dt_train, -success), ico_dt_train$success, trails = 10) 
dt_boost 
summary(dt_boost) 
dt_boost_pred <- predict(dt_boost, ico_dt_test, type = "prob") 
dt_boost_pred1 <- predict(dt_boost, ico_dt_test ) 
#library(ROCR) 
predict_object_boost<- prediction(dt_boost_pred[,2],ico_dt_test_labels) 
roc_DT_boost <- performance(predict_object_boost, measure = "tpr", x.measure = "fpr") 
plot(roc_DT_boost, main = "ROC curve for Adaptive Boosting Model", col =  
"blue", lwd = 2) 
abline(a = 0, b = 1, lwd = 2, lty = 2) 
auc_object_boost <- performance(predict_object_boost, measure = "auc") 
auc_object_boost 
#Getting other metrics Accuracy, Sensitivity, Specificity, Precision, Fmeasure 
#library(caret) 
keymetric_Ada <- confusionMatrix(dt_boost_pred1 , ico_dt_test_labels, positive = "Y", mode 
= "everything") 
keymetric_Ada 
# Appendix --------------------------------------------------------------------------------- 24 
ico_RF <- randomForest(success ~ ., data = ico_dt_train, ntree = 20) 
ico_RF <- ico_main # Creating a duplicate dataframe 
library(caret) 
ico_RF_dummy <- dummyVars( ~ countryRegion + platform , data = ico_RF) # Using 
dummyVars for one hot encoding 
dummy_frame <- data.frame(predict(ico_RF_dummy, ico_RF))# Creating a dataframe of 
dummy features 
library(dplyr) 
ico_RF <- cbind(ico_RF, dummy_frame) #combining dummy dataframe with RF dataframe 
ico_RF$countryRegion <- NULL # removing country feature from final dataframe 
ico_RF$platform <- NULL # removing platform feature from final dataframe 
ico_RF$success <- factor(ico_RF$success) #Converting character features to factors 
#Separating Training and Test data 
smp_size_RF <- floor(0.9 * nrow(ico_RF)) 
set.seed(12345) 
train_ind_RF <- sample(nrow(ico_RF), smp_size) 
ico_dt_train_RF <- ico_RF[train_ind_RF, ] 
ico_dt_test_RF <- ico_RF[-train_ind_RF, ] 
ico_dt_test_labels_RF <- ico_RF[-train_ind_RF, "success"] 
#Training the model 
library(randomForest) 
ico_RF_model <- randomForest(success ~ ., data = ico_dt_train_RF, ntree  
= 20) 
#Evaluating the model on test data 
ico_RF_predict <- predict(ico_RF_model, ico_dt_test_RF, type = "prob" ) 
ico_RF_predict1 <- predict(ico_RF_model, ico_dt_test_RF) 
#Getting key metrics  
library(ROCR) 
predict_object_RF <- prediction(ico_RF_predict[,2],ico_dt_test_labels_RF 
) 
roc_RF <- performance(predict_object_RF, measure = "tpr", x.measure = "f 
pr") 
plot(roc_RF, main = "ROC curve for Random Forest Model", col = "blue", lwd = 2) 
abline(a = 0, b = 1, lwd = 2, lty = 2) 
auc_object_RF <- performance(predict_object_RF, measure = "auc") 
auc_object_RF 
auc_object_RF@y.values[[1]] 
#Getting other metrics Accuracy, Sensitivity, Specificity, Precision, Fmeasure 
library(caret) 
keymetric_RF <- confusionMatrix(ico_RF_predict1 , ico_dt_test_labels_RF,  
positive = "Y", mode = "everything") 
keymetric_RF 
ico_RF_model 
# Appendix --------------------------------------------------------------------------------- 25 
ico_SVM <- ico_RF 
#Partitioning the data into training and testing data 
smp_size_SVM <- floor(0.9 * nrow(ico_SVM)) 
set.seed(12345) 
train_ind_SVM <- sample(nrow(ico_SVM), smp_size_SVM) 
ico_dt_train_SVM <- ico_SVM[train_ind_SVM, ] 
ico_dt_test_SVM <- ico_SVM[-train_ind_SVM, ] 
ico_dt_test_labels_SVM <- ico_SVM[-train_ind_SVM, "success"] 
# Training the model 
library(kernlab) 
SVM_model <- ksvm(success ~ ., data = ico_SVM, 
+ kernel = "vanilladot", prob.model = TRUE) 
SVM_predict <- predict(SVM_model, select(ico_dt_test_SVM, -success), typ 
e = "probabilities") 
SVM_predict1 <- predict(SVM_model, select(ico_dt_test_SVM, -success)) 
#Getting key metrics  
library(ROCR) 
predict_object_SVM <- prediction(SVM_predict[,2],ico_dt_test_labels_SVM) 
roc_SVM <- performance(predict_object_SVM, measure = "tpr", x.measure =  
"fpr") 
plot(roc_SVM, main = "ROC curve for SVM Model", col = "blue", lwd = 2) 
abline(a = 0, b = 1, lwd = 2, lty = 2) 
auc_object_SVM <- performance(predict_object_SVM, measure = "auc") 
auc_object_SVM 
auc_object_SVM@y.values[[1]] 
#Getting other metrics Accuracy, Sensitivity, Specificity, Precision, Fmeasure 
library(caret) 
keymetric_SVM <- confusionMatrix(SVM_predict1 , ico_dt_test_labels_SVM,  
positive = "Y", mode = "everything") 
keymetric_SVM 
# Appendix --------------------------------------------------------------------------------- 26 
ico_ANN <- ico_RF 
#normalize complete data frame 
normalize <- function(x) { + return((x - min(x)) / (max(x) - min(x))) + } 
# apply normalization to entire data frame 
library(dplyr) 
ico_ANN_norm <- as.data.frame(lapply(select(ico_ANN, -success) , normalize)) # 'normalize' 
is the name of function we defined 
ico_ANN_norm <- cbind(ico_ANN_norm, success = ico_ANN$success) #combining "success" 
feature 
#summary(ico_ANN_norm) 
#Partitioning the data into training and testing data 
smp_size_ANN <- floor(0.9 * nrow(ico_ANN_norm)) 
set.seed(12345) 
train_ind_ANN <- sample(nrow(ico_ANN_norm), smp_size_ANN) 
ico_dt_train_ANN <- ico_ANN_norm[train_ind_ANN, ] 
ico_dt_test_ANN <- ico_ANN_norm[-train_ind_ANN, ] 
ico_dt_test_labels_ANN <- ico_ANN_norm[-train_ind_ANN, "success"] 
library(neuralnet) 
set.seed(12345) 
ANN_model <- neuralnet(formula = success ~ .,data = ico_ANN_norm) 
#plot(ANN_model) 
#summary(ANN_model) 
#Evaluating the model on test data 
ANN_predict <- predict(ANN_model, select(ico_dt_test_ANN, -success)) 
#ANN gives prediction probabilities; Converting them to class labels 
ANN_predict_df <- data.frame(ANN_predict) #Converting prediciton output as a dataframe 
class_labels_ANN_test <- ifelse(ANN_predict_df$X2 0.5, "Y", "N") #Converting probabilities 
to class labels 
class_labels_ANN_test <- factor(class_labels_ANN_test) 
#Getting key metrics  
install.packages("ROCR") 
library(ROCR) 
predict_object_ANN <- prediction(ANN_predict_df[,2],ico_dt_test_labels_ANN) 
roc_ANN <- performance(predict_object_ANN, measure = "tpr", x.measure =  
"fpr") 
plot(roc_ANN, main = "ROC curve for ANN Model", col = "blue", lwd = 2) 
abline(a = 0, b = 1, lwd = 2, lty = 2) 
auc_object_ANN <- performance(predict_object_ANN, measure = "auc") 
auc_object_ANN 
auc_object_ANN@y.values[[1]] 
#Getting other metrics Accuracy, Sensitivity, Specificity, Precision, Fmeasure 
library(caret) 
keymetric_ANN <- confusionMatrix(class_labels_ANN_test , ico_dt_test_labels_ANN, 
positive = "Y", mode = "everything")  keymetric_ANN