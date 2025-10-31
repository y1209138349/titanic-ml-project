#!/usr/bin/env Rscript
# Northwestern MLDS 400 Assignment 3
# Titanic Survival Analysis - R Implementation

library(readr)
library(dplyr)

cat("TITANIC SURVIVAL ANALYSIS\n")
cat("Northwestern MLDS 400 Assignment 3\n")
cat(rep("=", 40), "\n")

# Q13: Load training data
cat("\n[Q13] Loading training data\n")

if (!file.exists("src/data/train.csv")) {
    cat("Error: train.csv not found in src/data/\n")
    quit(status = 1)
}

train <- read_csv("src/data/train.csv", show_col_types = FALSE)
cat("Data shape:", paste(dim(train), collapse = " x "), "\n")
cat("First 5 rows:\n")
print(head(train, 5))
cat("Survival rate:", sprintf("%.3f", mean(train$Survived)), "\n")

# Q14: Feature engineering
cat("\n[Q14] Feature engineering\n")

train$FamilySize <- train$SibSp + train$Parch + 1
cat("Created FamilySize feature\n")

train$IsAlone <- as.numeric(train$FamilySize == 1)
cat("Created IsAlone feature\n")

train$Sex_num <- as.numeric(train$Sex == "male")
cat("Applied gender encoding\n")

train$Age[is.na(train$Age)] <- median(train$Age, na.rm = TRUE)
train$Embarked[is.na(train$Embarked)] <- names(sort(table(train$Embarked), decreasing = TRUE))[1]
cat("Filled missing values\n")

# Q15: Train model
cat("\n[Q15] Model training\n")

features <- c("Pclass", "Sex_num", "Age", "Fare", "FamilySize", "IsAlone")
model_data <- train[c(features, "Survived")]

model <- glm(Survived ~ ., data = model_data, family = binomial)
cat("Logistic regression trained\n")

# Q16: Calculate accuracy
cat("\n[Q16] Training accuracy\n")

pred_prob <- predict(model, model_data, type = "response")
pred <- ifelse(pred_prob > 0.5, 1, 0)
acc <- mean(pred == train$Survived)
cat("Accuracy:", sprintf("%.4f", acc), "\n")

# Q17: Process test data
cat("\n[Q17] Test data processing\n")

if (!file.exists("src/data/test.csv")) {
    cat("Error: test.csv not found\n")
    quit(status = 1)
}

test <- read_csv("src/data/test.csv", show_col_types = FALSE)
cat("Test shape:", paste(dim(test), collapse = " x "), "\n")

test$FamilySize <- test$SibSp + test$Parch + 1
test$IsAlone <- as.numeric(test$FamilySize == 1)
test$Sex_num <- as.numeric(test$Sex == "male")

test$Age[is.na(test$Age)] <- median(train$Age, na.rm = TRUE)
test$Fare[is.na(test$Fare)] <- median(train$Fare, na.rm = TRUE)
test$Embarked[is.na(test$Embarked)] <- names(sort(table(train$Embarked), decreasing = TRUE))[1]

cat("Applied transformations\n")

# Q18: Generate predictions
cat("\n[Q18] Predictions generated\n")

test_features <- test[features]
pred_prob <- predict(model, test_features, type = "response")
predictions <- ifelse(pred_prob > 0.5, 1, 0)

submission <- data.frame(
    PassengerId = test$PassengerId,
    Survived = predictions
)

if (!dir.exists("outputs")) {
    dir.create("outputs")
}

write.csv(submission, "outputs/r_predictions.csv", row.names = FALSE)

cat("Predictions for", length(predictions), "passengers\n")
cat("Survival rate:", sprintf("%.3f", mean(predictions)), "\n")
cat("Saved to outputs/r_predictions.csv\n")

cat("\nR analysis completed\n")
