# Factors Associated With Hypertension Among Adults: NHANES 2017–2018

## Project overview
This portfolio project explores the association of age, sex, and body mass index (BMI) with a project-defined high blood-pressure indicator among adults using the US National Health and Nutrition Examination Survey (NHANES) 2017–2018 public data. It demonstrates data preparation, exploratory analysis, survey-weighted logistic regression, and an exploratory prediction assessment using R.

**Important outcome definition:** the project defines `measured_high_bp = 1` when the mean of available first three examination systolic readings is at least 140 mmHg **or** the mean diastolic reading is at least 90 mmHg. This is an educational, project-defined classification from one examination session; it is **not a clinical diagnosis**. The analysis is not medical advice.

## Main findings
- The survey-weighted estimated prevalence of the project-defined threshold was about **18.63%** (95% CI 16.78%–20.49%).
- In the survey-weighted logistic regression, age was associated with higher odds of meeting the project-defined threshold (OR 1.0617 per year; 95% CI 1.0541–1.0693).
- BMI was also associated with higher odds (OR 1.0376 per BMI unit; 95% CI 1.0257–1.0496).
- The male-versus-female association was not statistically significant at the 5% level in the survey-weighted model (OR 1.2358; 95% CI 0.9338–1.6354; p approximately 0.10).
- Exploratory prediction performance was AUC 0.75 on the held-out test set. Classification metrics are unweighted and threshold-dependent, and should not be interpreted as a clinical screening tool.

## Repository contents
- `figures/` — project visualizations. The calibration figure is exploratory and should not be treated as a validated calibration assessment.
- `reports/` — academic report, portfolio brief, and visualization appendix in PDF; Word versions are included where available.
- `results/key_results.csv` — key estimates and performance metrics.
- `scripts/analysis_template.R` — clearly labelled workflow template, not a complete reproduction of the original analysis.

## Data sources
NHANES 2017–2018 public-use files were linked using `SEQN`: demographic (`DEMO_J`), blood pressure examination (`BPX_J`), blood pressure questionnaire (`BPQ_J`), and body measures (`BMX_J`).

- [NHANES 2017–2018 overview](https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/overview.aspx?BeginYear=2017)
- [Blood Pressure Examination (BPX_J)](https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/BPX_J.htm)
- [Blood Pressure Questionnaire (BPQ_J)](https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/BPQ_J.htm)

## Methods summary
Adults aged 18 and older were selected. Mean blood pressure was calculated from available first three readings. The survey-weighted logistic regression used the examination weight `WTMEC2YR`, strata `SDMVSTRA`, and PSU `SDMVPSU`, with age, sex, and BMI as predictors. Missing predictor/outcome records were excluded from the model, yielding 5,176 complete cases.

Prediction performance was assessed using a train/test split and cross-validation. These performance summaries are exploratory: cross-validation was not explicitly survey-design-aware, classification metrics are unweighted, and the chosen threshold should be reviewed to ensure it was selected without using held-out test outcomes. Do not use these estimates for individual medical decisions.

## Reproducibility note
This package includes finished reports, figures, and a results table. It does **not** contain the original complete R script or raw NHANES data. The included `scripts/analysis_template.R` is a starting scaffold, not a claim that every result can be reproduced from raw files with one run. Before describing the repository as fully reproducible, add the actual analysis script, document package versions, and verify that the workflow regenerates all outputs.

## Suggested skills to list
R · dplyr · data cleaning · exploratory data analysis · survey-weighted regression · logistic regression · data visualization · model evaluation
