# Analysis workflow template — not the original full analysis script
# Project: NHANES 2017–2018 hypertension-threshold analysis
# Replace/extend this scaffold with the exact script used to produce the reports.

# Suggested packages
# install.packages(c("nhanesA", "dplyr", "ggplot2", "survey", "pROC", "broom"))
library(dplyr)
library(ggplot2)
library(survey)

# Suggested raw-file workflow:
# 1. Download DEMO_J, BPX_J, BPQ_J, and BMX_J from the official NHANES site.
# 2. Join files by SEQN.
# 3. Restrict to adults aged 18 years or older.
# 4. Calculate the mean of the available first three systolic and diastolic readings.
# 5. Define the project outcome as systolic mean >= 140 OR diastolic mean >= 90.
# 6. Create the survey design with WTMEC2YR, SDMVPSU, and SDMVSTRA.
# 7. Fit a survey-weighted logistic regression with age, sex, and BMI.
# 8. Recreate figures and evaluate prediction performance without using test outcomes
#    to choose a classification threshold.
# 9. Export model results, figures, and sessionInfo() for reproducibility.

# This is intentionally a scaffold. It will not run end-to-end until the actual
# data-loading, cleaning, variable-name checks, model, and plotting code are added.
