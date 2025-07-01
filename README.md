# Machine Learning for ICO Success Prediction

This project explores the use of machine learning techniques to predict the success of Initial Coin Offerings (ICOs) based on various campaign attributes. It leverages data-driven insights to support investors and campaign organizers in understanding the factors behind successful blockchain-based fundraising.

## 📌 Project Overview

With the rise of ICOs as a method of crowdfunding, accurately forecasting campaign outcomes is crucial. This project uses multiple machine learning models to classify ICOs as successful (`Y`) or unsuccessful (`N`) using features such as team size, blockchain platform, coin distribution percentage, and campaign duration.

---

## 🗂 Dataset

- **Observations**: 2,767 ICO campaigns  
- **Target Variable**: `success` (Y/N)  
- **Key Features**:
  - `priceUSD`
  - `teamSize`
  - `coinNum`
  - `distributedPercentage`
  - `countryRegion`
  - `platform`
  - `Duration_of_campaign` (engineered)

### Data Preprocessing Highlights

- Missing values handled using median imputation  
- Outliers and logically invalid values removed  
- Categorical inconsistencies standardized (e.g., country and platform names)  
- One-hot encoding applied to categorical features  
- Created `Duration_of_campaign` feature from `startDate` and `endDate`

---

## ⚙️ Machine Learning Models

1. **Decision Tree**
2. **Adaboost**
3. **Random Forest**
4. **Support Vector Machine (SVM)**
5. **Artificial Neural Network (ANN)**

All models were trained and evaluated using a 90/10 train-test split. Performance metrics include Accuracy, AUC, and Precision.

---

## 📊 Model Evaluation

| Model        | Accuracy | AUC    | Precision |
|--------------|----------|--------|-----------|
| Decision Tree| 63.41%   | 0.5989 | 0.4989    |
| Adaboost     | 62.55%   | 0.6144 | 0.4843    |
| Random Forest| 63.13%   | 0.6637 | 0.5145    |
| SVM          | 67.48%   | 0.7239 | 0.5963    |
| **ANN**      | **69.65%** | **0.7389** | **0.6128** |

---

## ✅ Results

- The **Artificial Neural Network (ANN)** achieved the best performance across all metrics.
- Precision of 61.28% indicates strong ability to correctly identify successful ICOs.
- Class imbalance observed: only ~37% of campaigns were successful.
- Influential predictors: `rating`, `teamSize`, `distributedPercentage`, and `countryRegion`.

---

## 🧠 Feature Engineering

- Engineered `Duration_of_campaign` feature.
- Removed non-informative columns: `ID`, `startDate`, `endDate`, `brandSlogan`.
- Applied normalization for ANN input features.
- Standardized and cleaned categorical values.

---

## 🔮 Future Enhancements

- Address class imbalance using SMOTE or cost-sensitive learning.
- Add external data (e.g., social media sentiment, GitHub activity).
- Experiment with ensemble models or deep learning frameworks.
- Tune hyperparameters for improved accuracy and generalization.

---


