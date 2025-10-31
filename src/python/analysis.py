#!/usr/bin/env python3
"""
Northwestern MLDS 400 Assignment 3
Titanic Survival Analysis - Python Implementation
"""

import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
import os

def main():
    print("TITANIC SURVIVAL ANALYSIS")
    print("Northwestern MLDS 400 Assignment 3")
    print("=" * 40)
    
    # Q13: Load training data
    print("\n[Q13] Loading training data")
    try:
        train = pd.read_csv("src/data/train.csv")
        print(f"Data shape: {train.shape}")
        print("First 5 rows:")
        print(train.head())
        print(f"Survival rate: {train['Survived'].mean():.3f}")
    except FileNotFoundError:
        print("Error: train.csv not found in src/data/")
        return
    
    # Q14: Feature engineering
    print("\n[Q14] Feature engineering")
    
    train['FamilySize'] = train['SibSp'] + train['Parch'] + 1
    print("Created FamilySize feature")
    
    train['IsAlone'] = (train['FamilySize'] == 1).astype(int)
    print("Created IsAlone feature")
    
    train['Sex_num'] = (train['Sex'] == 'male').astype(int)
    print("Applied gender encoding")
    
    train['Age'].fillna(train['Age'].median(), inplace=True)
    train['Embarked'].fillna(train['Embarked'].mode()[0], inplace=True)
    print("Filled missing values")
    
    # Q15: Train model
    print("\n[Q15] Model training")
    
    features = ['Pclass', 'Sex_num', 'Age', 'Fare', 'FamilySize', 'IsAlone']
    X = train[features]
    y = train['Survived']
    
    model = LogisticRegression(random_state=42, max_iter=1000)
    model.fit(X, y)
    print("Logistic regression trained")
    
    # Q16: Calculate accuracy
    print("\n[Q16] Training accuracy")
    
    pred = model.predict(X)
    acc = accuracy_score(y, pred)
    print(f"Accuracy: {acc:.4f}")
    
    # Q17: Process test data
    print("\n[Q17] Test data processing")
    
    try:
        test = pd.read_csv("src/data/test.csv")
        print(f"Test shape: {test.shape}")
        
        test['FamilySize'] = test['SibSp'] + test['Parch'] + 1
        test['IsAlone'] = (test['FamilySize'] == 1).astype(int)
        test['Sex_num'] = (test['Sex'] == 'male').astype(int)
        
        test['Age'].fillna(train['Age'].median(), inplace=True)
        test['Fare'].fillna(train['Fare'].median(), inplace=True)
        test['Embarked'].fillna(train['Embarked'].mode()[0], inplace=True)
        
        print("Applied transformations")
        
    except FileNotFoundError:
        print("Error: test.csv not found")
        return
    
    # Q18: Generate predictions
    print("\n[Q18] Predictions generated")
    
    X_test = test[features]
    predictions = model.predict(X_test)
    
    submission = pd.DataFrame({
        'PassengerId': test['PassengerId'],
        'Survived': predictions
    })
    
    os.makedirs("outputs", exist_ok=True)
    submission.to_csv("outputs/python_predictions.csv", index=False)
    
    print(f"Predictions for {len(predictions)} passengers")
    print(f"Survival rate: {predictions.mean():.3f}")
    print("Saved to outputs/python_predictions.csv")
    
    print("\nPython analysis completed")

if __name__ == "__main__":
    main()
