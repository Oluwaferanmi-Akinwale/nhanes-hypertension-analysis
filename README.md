# Factors Associated With Hypertension Among Adults: NHANES 2017–2018

## Project Overview
This project investigates associations between age, sex, and body mass index (BMI) and a project-defined high blood-pressure classification among adults using data from the National Health and Nutrition Examination Survey (NHANES) 2017–2018.

The analysis demonstrates data preparation, exploratory analysis, survey-weighted logistic regression, visualization, and exploratory predictive modelling using R.

**Important:** The outcome is a project-defined classification based on blood pressure readings from one examination session. It is not a clinical diagnosis of persistent hypertension.

## Research Objectives
- Describe blood-pressure and BMI patterns among adults.
- Examine unadjusted differences by age group and sex.
- Estimate adjusted associations using survey-weighted logistic regression.
- Explore the classification performance of a logistic regression model.

## Data Sources
The analysis uses public-use NHANES 2017–2018 datasets:

- [Demographics (DEMO_J)](https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/DEMO_J.htm)
- [Blood Pressure Examination (BPX_J)](https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/BPX_J.htm)
- [Body Measures (BMX_J)](https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/BMX_J.htm)
- [Blood Pressure Questionnaire (BPQ_J)](https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/BPQ_J.htm)

The datasets were linked using the participant identifier `SEQN`.

## Methods
- Data cleaning and preparation
- Descriptive statistics and exploratory visualizations
- Survey-weighted logistic regression using the `survey` package
- ROC/AUC-based assessment of predictive discrimination
- Exploratory classification metrics

The survey-weighted model adjusted for age, sex, and BMI and incorporated NHANES examination weights, strata, and primary sampling units.

## Key Findings
- **Age:** Adjusted odds ratio (OR) 1.0617 per year (95% CI: 1.0541–1.0693).
- **BMI:** Adjusted OR 1.0376 per kg/m² (95% CI: 1.0257–1.0496).
- **Sex:** The adjusted association for male versus female participants was not statistically significant at the 5% level (OR 1.2358; 95% CI: 0.9338–1.6354).
- **Prediction:** Held-out test-set AUC was 0.75. Reported classification metrics were unweighted sample estimates.

These results describe associations and do not establish causation. The project-defined outcome should not be used as a clinical diagnostic tool.

## Repository Structure
- `scripts/analysis.R` — R analysis script
- `figures/` — project visualizations
- `reports/` — academic report and portfolio brief
- `results/` — selected statistical results

## Tools
R, RStudio, `haven`, `dplyr`, `ggplot2`, `survey`, and `pROC`.

## Limitations
The outcome is based on one examination session. Some observations have missing data. Predictive metrics are unweighted, and the threshold-selection and validation procedures require further methodological documentation. The model has not been externally validated.

## Disclaimer
This project is for educational and analytical demonstration. It is not medical advice or a clinical decision-support tool.
## Research Report

The full biostatistics research report is available in PDF and editable Word formats.

- **[Read the Full Report (PDF)](reports/Final_NHANES_Biostatistics_Report.pdf)**
- **[Download the Editable Report (Word)](reports/Final_NHANES_Biostatistics_Report.docx)**

### Key Findings

- Age was positively associated with the project-defined high blood-pressure classification.
- BMI was also positively associated with the classification after adjustment for age and sex.
- The adjusted association between sex and the classification was not statistically significant at the 5% level.
- The prediction model achieved a held-out test-set AUC of 0.75.

### Tools and Methods

R programming, NHANES data, data cleaning, exploratory data analysis, survey-weighted logistic regression, statistical modelling, and data visualization.

### Important Note

The outcome represents an analytical classification based on blood-pressure measurements from one examination session; it is not a clinical diagnosis. Predictive performance metrics are unweighted and should not be interpreted as nationally representative estimates.
