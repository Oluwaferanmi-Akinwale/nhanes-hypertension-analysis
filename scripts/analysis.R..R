demo<-read_xpt(
  "https://wwwn.cdc.gov/Nchs/Nhanes/2017-2018/DEMO_J.XPT"
)
demo<-read_xpt(file.choose())
dim(demo)
head(demo)
str(demo)
summary(demo$RIDAGEYR)
sum(demo$RIDAGEYR>=18,na.rm=TRUE)
adults<-demo[demo$RIDAGEYR>=18,]
dim(adults)
bpx<-read_xpt(file.choose())
dim(bpx)
str(bpx)
summary(bpx$BPXSY1)
sum(is.na(bpx$BPXSY1))
summary(bpx$BPXSY2)
sum(is.na(bpx$BPXSY2))
summary(bpx$BPXSY3)
bpx_selected<-bpx|>
  dplyr::select(
    SEQN,
    BPXSY1,BPXDI1,
    BPXSY2,BPXDI2,
    BPXSY3,BPXDI3,
    BPXSY4,BPXDI4
  )
dim(bpx_selected)
adults_bp<-adults|>
  dplyr::left_join(bpx_selected,by="SEQN")
dim(adults_bp)
head(adults_bp[,c("SEQN","RIDAGEYR",
                  "BPXSY1","BPXDI1",
                  "BPXSY2","BPXDI2",
                  "BPXSY3","BPXDI3")])
mean(c(112,114,116),na.rm=TRUE)
mean(c(120,NA,122),na.rm=TRUE)
demo<-read_xpt(file.choose())
dim(demo)
names(demo)
summary(demo$RIDAGEYR)
sum(demo$RIDAGEYR>=18,na.rm=TRUE)
adults<-demo[demo$RIDAGEYR>=18,]
dim(adults)
head(adults$SEQN)
bpx<-read_xpt(file.choose())
dim(bpx)
names(bpx)
sum(!is.na(bpx$BPXSY1))
sum(!is.na(bpx$BPXSY2))
sum(!is.na(bpx$BPXSY3))
sum(!is.na(bpx$BPXSY4))
table(bpx$BPAEN4,useNA = "ifany")
bpx_selected<-bpx|>
  dplyr::select(
    SEQN,
    BPXSY1,BPXDI1,
    BPXSY2,BPXDI2,
    BPXSY3,BPXDI3,
    BPXSY4,BPXDI4
  )
dim(bpx_selected)
adults_bp<-adults|>
  dplyr::left_join(bpx_selected,by="SEQN")
dim(adults_bp)
head(adults_bp[,c("SEQN","RIDAGEYR",
                  "BPXSY1","BPXDI1",
                  "BPXSY2","BPXDI2",
                  "BPXSY3","BPXDI3",
                  "BPXSY4","BPXDI4")])
sum(
  rowSums(!is.na(adults_bp[,c("BPXSY1","BPXSY2","BPXSY3")]))>0
)
adults_bp$mean_systolic<-rowMeans(
  adults_bp[,c("BPXSY1","BPXSY2","BPXSY3")],
  na.rm=TRUE
)
summary(adults_bp$mean_systolic)
max(adults_bp$mean_systolic,na.rm=TRUE)
adults_bp$mean_diastolic<-rowMeans(
  adults_bp[,c("BPXDI1","BPXDI2","BPXDI3")],
  na.rm=TRUE
)
summary(adults_bp$mean_diastolic)
sum(adults_bp$mean_diastolic==0,na.rm=TRUE)
adults_bp[a
          dults_bp$mean_diastolic==0,
          c("SEQN","BPXDI1","BPXDI2","BPXDI3")]
adults_bp[!is.na(adults_bp$mean_diastolic)&
            adults_bp$mean_diastolic==0,
          c("SEQN","BPXDI1","BPXDI2","BPXDI3")
]
bpq<-read_xpt(file.choose())
dim(bpq)
names(bpq)
table(bpq$BPQ020,useNA = "ifany")
table(bpq$BPQ030,useNA = "ifany")
table(bpq$BPQ040A,useNA = "ifany")
bpq_selected<-bpq|>
  dplyr::select(
    SEQN,
    BPQ020,
    BPQ030,
    BPQ040A,
    BPQ050A
  )
dim(bpq_selected)
adults_bpq<-adults_bp|>
  dplyr::left_join(bpq_selected,by="SEQN")
dim(adults_bpq)
table(adults_bpq$BPQ020,useNA = "ifany")
adults_bpq$hypertension_self<-ifelse(
  adults_bpq$BPQ020==1,1,
  ifelse(adults_bpq$BPQ020==2,0,NA)
)
table(adults_bpq$hypertension_self,useNA = "ifany")
table(adults_bpq$RIAGENDR,useNA = "ifany")
adults_bpq$sex<-ifelse(
  adults_bpq$RIAGENDR==1,"Male",
  ifelse(adults_bpq$RIAGENDR==2,"Female",NA)
)
table(adults_bpq$sex,useNA = "ifany")
bmx<-read_xpt(file.choose())
dim(bmx)
names(bmx)
bmx_selected<-bmx|>
  dplyr::select(
    SEQN,
    BMXBMI
  )
dim(bmx_selected)
adults_bmi<-adults_bpq|>
  dplyr::left_join(bmx_selected,by="SEQN")
dim(adults_bmi)
names(adults_bmi)
summary(adults_bmi$BMXBMI)
class(adults_bmi$BMXBMI)
summary(adults_bmi$RIDAGEYR)
sum(
  !is.na(adults_bmi$mean_systolic)&
    !is.na(adults_bmi$mean_diastolic)
)
adults_bmi$hypertension_measured <- ifelse(
  is.na(adults_bmi$mean_systolic) |
    is.na(adults_bmi$mean_diastolic),
  NA,
  ifelse(
    adults_bmi$mean_systolic >= 140 |
      adults_bmi$mean_diastolic >= 90,
    1, 0
  )
)
table(adults_bmi$hypertension_measured, useNA = "ifany")
table(
  adults_bmi$hypertension_self,
  adults_bmi$hypertension_measured,
  useNA = "ifany"
)
adults_bmi$measured_high_bp<-adults_bmi$hypertension_measured
table(adults_bmi$measured_high_bp,useNA = "ifany")
table(
  adults_bmi$sex,
  adults_bmi$measured_high_bp,
  useNA = "ifany"
)
prop.table(
  table(
    adults_bmi$sex,
    adults_bmi$measured_high_bp
  ),
  margin=1
)
sex_bp_table <- table(
  adults_bmi$sex[!is.na(adults_bmi$measured_high_bp)],
  adults_bmi$measured_high_bp[!is.na(adults_bmi$measured_high_bp)]
)
chisq.test(sex_bp_table)
adults_bmi$age_group<-cut(
  adults_bmi$RIDAGEYR,
  breaks = c(17,39,59,79,80),
  labels = c("18-39","40-59","60-79","80"),
  right = TRUE
)
table(adults_bmi$age_group,useNA = "ifany")
table(
  adults_bmi$age_group,
  adults_bmi$measured_high_bp,
  useNA = "ifany"
)
prop.table(
  table(
    adults_bmi$age_group,
    adults_bmi$measured_high_bp
  ),
  margin = 1
)
age_bp_table <- table(
  adults_bmi$age_group[!is.na(adults_bmi$measured_high_bp)],
  adults_bmi$measured_high_bp[!is.na(adults_bmi$measured_high_bp)]
)
chisq.test(age_bp_table)
tapply(
  adults_bmi$BMXBMI,
  adults_bmi$measured_high_bp,
  mean,
  na.rm = TRUE
)
t.test(
  BMXBMI~measured_high_bp,
  data = adults_bmi
)
plot(
  adults_bmi$BMXBMI,
  adults_bmi$mean_systolic,
  xlab = "BMI",
  ylab = "Mean systolic blood pressure",
  main = "BMI vs mean systolic blood pressure"
)
cor(
  adults_bmi$BMXBMI,
  adults_bmi$mean_systolic,
  use = "complete.obs"
)
sum(
  complete.cases(
    adults_bmi[,c(
      "measured_high_bp",
      "RIDAGEYR",
      "sex",
      "BMXBMI"
    )]
  )
)
model1<-glm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  data = adults_bmi,
  family = binomial
)
summary(model1)
exp(coef(model1))
exp(confint(model1))
model0<-glm(
  measured_high_bp~1,
  data = adults_bmi,
  family = binomial
)
anova(model0, model1, test = "Chisq")
model_data<-adults_bmi[
  complete.cases(
    adults_bmi[,c(
      "measured_high_bp",
      "RIDAGEYR",
      "sex",
      "BMXBMI"
    )]
  ),
]
dim(model_data)
model1<-glm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  data = adults_bmi,
  family = binomial
)
model0<-glm(
  measured_high_bp~1,
  data = adults_bmi,
  family = binomial
)
anova(model0, model1, test = "Chisq")
model_data<-adults_bmi[
  complete.cases(
    adults_bmi[,c(
      "measured_high_bp",
      "RIDAGEYR",
      "sex",
      "BMXBMI"
    )]
  ),
]
dim(model_data)
model0<-glm(
  measured_high_bp~1,
  data = model_data,
  family = binomial
)
model1<-glm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  data = model_data,
  family = binomial
)
anova(model0, model1, test = "Chisq")
library(survey)
packageVersion("survey")
library(survey)
packageVersion("survey")
nhanes_design<-svydesign(
  ids = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~WTMEC2YR,
  data = model_data,
  nest = TRUE
)
nhanes_design
model_svy<-svyglm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  design = nhanes_design,
  family = quasibinomial()
)
summary(model_svy)
exp(coef(model_svy))
confint(model_svy)
exp(confint(model_svy))
svymean(
  ~measured_high_bp,
  nhanes_design,
  na.rm=TRUE
)
svymean(
  ~measured_high_bp,
  nhanes_design,
  na.rm = TRUE
)|>
  confint()
predicted_prob<-predict(
  model_svy,
  type = "response"
)
head(predicted_prob)
summary(predicted_prob)
predicted_class<-ifelse(
  predicted_prob>=0.5,
  1,
  0
)
table(predicted_class)
confusion_matrix<-table(
  Actual=model_data$measured_high_bp,
  Predicted=predicted_class
)
confusion_matrix
roc_model<-roc(
  model_data$measured_high_bp,
  predicted_prob
)
auc(roc_model)
plot(
  roc_model,
  main="ROC Curve for Survey-Weighted Logistic Regression"
)
coords(
  roc_model,
  "best",
  ret=c("threshold","sensitivity","specificity"),
  best.method="youden"
)
predicted_class_optimal<-ifelse(
  predicted_prob>=0.1835941,
  1,
  0
)
table(
  Actual=model_data$measured_high_bp,
  Predicted=predicted_class_optimal
)
plot(
  roc_model,
  main="ROC Curve with Youden-Optimal Threshold"
)
points(
  1 - 0.6150744,
  0.7915633,
  pch=19
)
calibration_group <- cut(
  predicted_prob,
  breaks = quantile(
    predicted_prob,
    probs = seq(0, 1, 0.1),
    na.rm = TRUE
  ),
  include.lowest = TRUE,
  labels = FALSE
)

table(calibration_group)
calibration_results <- aggregate(
  cbind(predicted_prob, model_data$measured_high_bp),
  by = list(Group = calibration_group),
  FUN = mean
)

calibration_results
nhanes_design<-update(
  nhanes_design,
  calibration_group=calibration_group,
  predicted_prob=predicted_prob
)
weighted_calibration<-svyby(
  ~measured_high_bp+predicted_prob,
  ~calibration_group,
  nhanes_design,
  svymean,
  na.rm=TRUE
)
weighted_calibration
plot(
  weighted_calibration$predicted_prob,
  weighted_calibration$measured_high_bp,
  xlab = "Mean predicted probability",
  ylab = "Observed proportion",
  main = "Survey-Weighted Calibration Plot",
  pch = 19,
  xlim = c(0, 0.55),
  ylim = c(0, 0.55)
)

abline(
  a = 0,
  b = 1,
  lty = 2
)
set.seed(123)

train_index <- sample(
  1:nrow(model_data),
  size = 0.80 * nrow(model_data)
)

train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]

dim(train_data)
dim(test_data)
train_design <- svydesign(
  ids = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~WTMEC2YR,
  data = train_data,
  nest = TRUE
)
train_model_svy <- svyglm(
  measured_high_bp ~ RIDAGEYR + sex + BMXBMI,
  design = train_design,
  family = quasibinomial()
)
summary(train_model_svy)
exp(coef(train_model_svy))
exp(confint(train_model_svy))
test_pred_prob <- predict(
  train_model_svy,
  newdata = test_data,
  type = "response"
)

head(test_pred_prob)
test_pred_class<-ifelse(
  test_pred_prob>=0.50,
  1,
  0
)
table(test_pred_class)
test_confusion_matrix <- table(
  Actual = test_data$measured_high_bp,
  Predicted = test_pred_class
)

test_confusion_matrix
test_pred_class_optimal <- ifelse(
  test_pred_prob >= 0.1835941,
  1,
  0
)

table(
  Actual = test_data$measured_high_bp,
  Predicted = test_pred_class_optimal
)
roc_test <- roc(
  test_data$measured_high_bp,
  test_pred_prob
)
auc(roc_test)
set.seed(123)
train_data$fold<-sample(
  rep(1:5,length.out=nrow(train_data))
)
table(train_data$fold)
train_fold1<-train_data[train_data$fold!=1,]
valid_fold1<-train_data[train_data$fold==1,]
dim(train_fold1)
dim(valid_fold1)
train_design_fold1<-svydesign(
  ids = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~WTMEC2YR,
  data = train_fold1,
  nest = TRUE
)
model_fold1<-svyglm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  design = train_design_fold1,
  family = quasibinomial()
)
summary(model_fold1)
valid_pred_fold1<-predict(
  model_fold1,
  newdata = valid_fold1,
  type = "response"
)
head(valid_pred_fold1)
roc_fold1<-roc(
  valid_fold1$measured_high_bp,
  valid_pred_fold1
)
auc_fold1<-auc(roc_fold1)
auc_fold1
train_fold2<-train_data[train_data$fold!=2,]
valid_fold2<-train_data[train_data$fold==2,]
dim(train_fold1)
dim(valid_fold1)
train_design_fold2<-svydesign(
  ids = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~WTMEC2YR,
  data = train_fold2,
  nest = TRUE
)
model_fold2<-svyglm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  design = train_design_fold2,
  family = quasibinomial()
)
summary(model_fold2)
valid_pred_fold2<-predict(
  model_fold2,
  newdata = valid_fold2,
  type = "response"
)
head(valid_pred_fold2)
roc_fold2<-roc(
  valid_fold1$measured_high_bp,
  valid_pred_fold2
)
auc(roc_fold2)
train_fold3<-train_data[train_data$fold!=3,]
valid_fold3<-train_data[train_data$fold==3,]
dim(train_fold3)
dim(valid_fold3)
train_design_fold3<-svydesign(
  ids = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~WTMEC2YR,
  data = train_fold3,
  nest = TRUE
)
model_fold3<-svyglm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  design = train_design_fold3,
  family = quasibinomial()
)
summary(model_fold3)
valid_pred_fold3<-predict(
  model_fold3,
  newdata = valid_fold3,
  type = "response"
)
head(valid_pred_fold3)
roc_fold3<-roc(
  valid_fold1$measured_high_bp,
  valid_pred_fold3
)
auc(roc_fold3)
train_fold4<-train_data[train_data$fold!=4,]
valid_fold4<-train_data[train_data$fold==4,]
dim(train_fold4)
dim(valid_fold4)
train_design_fold4<-svydesign(
  ids = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~WTMEC2YR,
  data = train_fold4,
  nest = TRUE
)
model_fold4<-svyglm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  design = train_design_fold4,
  family = quasibinomial()
)
summary(model_fold4)
valid_pred_fold4<-predict(
  model_fold4,
  newdata = valid_fold4,
  type = "response"
)
head(valid_pred_fold4)
roc_fold4<-roc(
  valid_fold1$measured_high_bp,
  valid_pred_fold4
)
auc(roc_fold4)
train_fold5<-train_data[train_data$fold!=5,]
valid_fold5<-train_data[train_data$fold==5,]
dim(train_fold5)
dim(valid_fold5)
train_design_fold5<-svydesign(
  ids = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~WTMEC2YR,
  data = train_fold5,
  nest = TRUE
)
model_fold5<-svyglm(
  measured_high_bp~RIDAGEYR+sex+BMXBMI,
  design = train_design_fold5,
  family = quasibinomial()
)
summary(model_fold5)
valid_pred_fold5<-predict(
  model_fold5,
  newdata = valid_fold5,
  type = "response"
)
head(valid_pred_fold5)
roc_fold5<-roc(
  valid_fold1$measured_high_bp,
  valid_pred_fold5
)
auc(roc_fold5)
auc_values<-c(
  0.7442,
  0.5119,
  0.4876,
  0.4992,
  0.5008
)
mean(auc_values)
sd(auc_values)
table(train_data$fold,train_data$measured_high_bp)
roc_fold1<-roc(
  valid_fold1$measured_high_bp,
  valid_pred_fold1
)
auc(roc_fold1)
sd(c(0.7442,0.5119,0.4876,0.4992,0.5008))
c(
  Fold1=0.7442,
  Fold2=0.5119,
  Fold3=0.4876,
  Fold4=0.4992,
  Fold5=0.5008
)
roc_fold2<-roc(
  valid_fold1$measured_high_bp,
  valid_pred_fold2
)
auc(roc_fold2)
summary(valid_pred_fold2)
tapply(
  valid_pred_fold2,
  valid_fold2$measured_high_bp,
  mean
)
tapply(
  valid_pred_fold2,
  valid_fold2$measured_high_bp,
  summary
)
roc_fold2$direction
auc(roc_fold2)
auc(
  roc(
    valid_fold2$measured_high_bp,
    valid_pred_fold2,
    direction=">"
  )
)
levels(roc_fold2)
roc_fold2$levels
roc_fold2_check<-roc(
  response=valid_fold2$measured_high_bp,
  predictor=valid_pred_fold2,
  levels=c("0","1"),
  direction="<"
)
auc(roc_fold2_check)
auc_fold1 <- auc(
  roc(
    valid_fold1$measured_high_bp,
    valid_pred_fold1,
    levels = c("0", "1"),
    direction = "<"
  )
)

auc_fold2 <- auc(
  roc(
    valid_fold2$measured_high_bp,
    valid_pred_fold2,
    levels = c("0", "1"),
    direction = "<"
  )
)

auc_fold3 <- auc(
  roc(
    valid_fold3$measured_high_bp,
    valid_pred_fold3,
    levels = c("0", "1"),
    direction = "<"
  )
)

auc_fold4 <- auc(
  roc(
    valid_fold4$measured_high_bp,
    valid_pred_fold4,
    levels = c("0", "1"),
    direction = "<"
  )
)

auc_fold5 <- auc(
  roc(
    valid_fold5$measured_high_bp,
    valid_pred_fold5,
    levels = c("0", "1"),
    direction = "<"
  )
)
c(
  Fold1 = auc_fold1,
  Fold2 = auc_fold2,
  Fold3 = auc_fold3,
  Fold4 = auc_fold4,
  Fold5 = auc_fold5
)
mean(c(
  auc_fold1,
  auc_fold2,
  auc_fold3,
  auc_fold4,
  auc_fold5
))
sd(c(
  auc_fold1,
  auc_fold2,
  auc_fold3,
  auc_fold4,
  auc_fold5
))
test_pred_prob<-predict(
  model1_full,
  newdata=test_data,
  type="response"
)
train_design <- svydesign(
  ids = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~WTMEC2YR,
  data = train_data,
  nest = TRUE
)
final_model <- svyglm(
  measured_high_bp ~ RIDAGEYR + sex + BMXBMI,
  design = train_design,
  family = quasibinomial()
)
summary(final_model)
test_pred_prob<-predict(
  final_model,
  newdata=test_data,
  type="response"
)
head(test_pred_prob)
test_pred_class <- ifelse(
  test_pred_prob >= 0.1835941,
  1,
  0
)
table(
  Actual = test_data$measured_high_bp,
  Predicted = test_pred_class
)
TN <- 498
FP <- 308
FN <- 50
TP <- 180

accuracy <- (TP + TN) / (TP + TN + FP + FN)

sensitivity <- TP / (TP + FN)

specificity <- TN / (TN + FP)

PPV <- TP / (TP + FP)

NPV <- TN / (TN + FN)

F1 <- 2 * (PPV * sensitivity) / (PPV + sensitivity)

accuracy
sensitivity
specificity
PPV
NPV
F1
roc_test<-roc(
  test_data$measured_high_bp,
  test_pred_prob,
  direction="<"
)
auc_test<-auc(roc_test)
auc_test
exp(coef(final_model))
exp(confint(final_model))
# Extract odds ratios
or_values <- exp(coef(final_model))

# Extract 95% confidence intervals
ci_values <- exp(confint(final_model))

# Combine into a table
final_results <- data.frame(
  Predictor = names(or_values),
  Odds_Ratio = as.numeric(or_values),
  CI_Lower = ci_values[, 1],
  CI_Upper = ci_values[, 2]
)

# Display the table
round(final_results, 4)
# Round only the numeric columns
final_results$Odds_Ratio <- round(final_results$Odds_Ratio, 4)

final_results$CI_Lower <- round(final_results$CI_Lower, 4)

final_results$CI_Upper <- round(final_results$CI_Upper, 4)

# Display the completed table
print(final_results)
write.csv(
  final_results,
  "hypertension_logistic_regression_results.csv",
  row.names = FALSE
)
getwd()
# Create a folder for project visualisations
dir.create("figures", showWarnings = FALSE)

# Check that it exists
list.files()
png("figures/01_systolic_bp_distribution.png",
    width = 1600, height = 1000, res = 160)

hist(
  adults_bmi$mean_systolic,
  breaks = 30,
  main = "Distribution of Mean Systolic Blood Pressure",
  xlab = "Mean systolic blood pressure (mmHg)",
  ylab = "Number of participants",
  col = "lightblue",
  border = "white"
)

dev.off()
png("figures/02_bmi_by_high_bp.png",
    width = 1600, height = 1000, res = 160)

boxplot(
  BMXBMI ~ factor(
    measured_high_bp,
    levels = c(0, 1),
    labels = c("Below threshold", "Meets threshold")
  ),
  data = adults_bmi,
  main = "BMI by Measured High-BP Classification",
  xlab = "Blood pressure classification",
  ylab = "BMI (kg/m²)",
  col = c("lightblue", "lightgreen")
)

dev.off()
age_bp_table <- table(
  adults_bmi$age_group,
  adults_bmi$measured_high_bp,
  useNA = "no"
)

age_bp_percent <- prop.table(
  age_bp_table,
  margin = 1
)[, "1"] * 100

png("figures/03_high_bp_by_age_group.png",
    width = 1600, height = 1000, res = 160)

barplot(
  age_bp_percent,
  main = "Percentage Meeting High-BP Threshold by Age Group",
  xlab = "Age group (years)",
  ylab = "Participants meeting threshold (%)",
  col = "steelblue",
  ylim = c(0, max(age_bp_percent) * 1.15)
)

dev.off()
library(pROC)

roc_test <- roc(
  response = test_data$measured_high_bp,
  predictor = test_pred_prob,
  levels = c("0", "1"),
  direction = "<"
)

png("figures/04_test_set_roc_curve.png",
    width = 1600, height = 1000, res = 160)

plot(
  roc_test,
  main = paste0(
    "Test-Set ROC Curve (AUC = ",
    round(as.numeric(auc(roc_test)), 3),
    ")"
  ),
  col = "blue",
  lwd = 3,
  legacy.axes = TRUE
)

abline(a = 0, b = 1, lty = 2, col = "gray")

dev.off()
png("figures/05_calibration_plot.png",
    width = 1600, height = 1000, res = 160)

plot(
  weighted_calibration$predicted_prob,
  weighted_calibration$measured_high_bp,
  xlab = "Mean predicted probability",
  ylab = "Observed proportion",
  main = "Survey-Weighted Calibration Plot",
  pch = 19,
  xlim = c(0, 0.55),
  ylim = c(0, 0.55)
)

abline(a = 0, b = 1, lty = 2)

dev.off()
list.files("figures", pattern = "\\.png$")
names(weighted_calibration)
getwd()
# Check whether the calibration table exists
exists("weighted_calibration")

# Inspect its structure
str(weighted_calibration)

# Display the calibration results
print(weighted_calibration)
# Inspect the survey design object
class(nhanes_design)

# Check the calibration group's distribution
table(model_data$calibration_group, useNA = "ifany")

# Inspect the calibration table
print(weighted_calibration)

# Check the range of predicted probabilities
range(model_data$predicted_prob, na.rm = TRUE)
# Display the columns in model_data
names(model_data)

# Display the columns in the calibration table
names(weighted_calibration)

# List objects containing prediction or calibration
ls(pattern = "pred|calib|model|design|test|train")
str(calibration_group)
str(predicted_prob)
str(calibration_results)
formula(final_model)
length(predicted_prob)
range(predicted_prob,na.rm = TRUE)
# Inspect the calibration group counts
table(calibration_group)

# Check the first 10 group assignments
head(calibration_group, 10)

# Inspect the first 10 predicted probabilities
head(predicted_prob, 10)

# Inspect the calibration results
print(calibration_results)
# Display the original calibration table
print(weighted_calibration)

# Display the survey design object's name and class
class(nhanes_design)
# Create a clean calibration dataset
calibration_data <- data.frame(
  measured_high_bp = model_data$measured_high_bp,
  predicted_prob = as.numeric(predicted_prob),
  calibration_group = calibration_group
)

# Check that all three variables have the same length
nrow(calibration_data)
length(predicted_prob)
length(calibration_group)
head(calibration_data)

summary(calibration_data$predicted_prob)

table(calibration_data$calibration_group)
# Create a clean calibration dataset
calibration_data <- data.frame(
  measured_high_bp = model_data$measured_high_bp,
  predicted_prob = as.numeric(predicted_prob)
)

# Remove rows with missing values
calibration_data <- calibration_data[
  complete.cases(calibration_data),
]

# Create 10 groups based on predicted probability
calibration_data$calibration_group <- cut(
  rank(calibration_data$predicted_prob, ties.method = "first"),
  breaks = quantile(
    rank(calibration_data$predicted_prob, ties.method = "first"),
    probs = seq(0, 1, 0.1)
  ),
  include.lowest = TRUE,
  labels = FALSE
)

# Check the group sizes
table(calibration_data$calibration_group)
head(calibration_data)

summary(calibration_data$predicted_prob)

table(calibration_data$calibration_group)
# Inspect the variables used in your survey design
names(nhanes_design$variables)
# Inspect the survey design structure
summary(nhanes_design)
# Check the outcome in the survey design
table(nhanes_design$variables$measured_high_bp, useNA = "ifany")

# Check predicted probabilities
summary(nhanes_design$variables$predicted_prob)

# Check the calibration groups
table(nhanes_design$variables$calibration_group, useNA = "ifany")

# Compare the number of rows
nrow(nhanes_design$variables)
nrow(calibration_data)
# Compare the first 10 predictions in both objects
head(nhanes_design$variables$predicted_prob, 10)

head(calibration_data$predicted_prob, 10)
library(survey)

# Calculate the survey-weighted observed and predicted proportions
calibration_corrected <- svyby(
  ~measured_high_bp + predicted_prob,
  ~calibration_group,
  design = nhanes_design,
  FUN = svymean,
  na.rm = TRUE,
  vartype = "se"
)

# Display the results
print(calibration_corrected)
# Save the corrected calibration plot
png(
  "figures/05_calibration_plot_corrected.png",
  width = 1600,
  height = 1000,
  res = 160
)

plot(
  calibration_corrected$predicted_prob,
  calibration_corrected$measured_high_bp,
  xlab = "Survey-weighted mean predicted probability",
  ylab = "Survey-weighted observed proportion",
  main = "Calibration Plot: NHANES Hypertension Model",
  pch = 19,
  xlim = c(0, 0.6),
  ylim = c(0, 0.6)
)

abline(a = 0, b = 1, lty = 2)

dev.off()
# Check whether higher predicted probabilities belong to higher groups
aggregate(
  predicted_prob ~ calibration_group,
  data = calibration_data,
  FUN = mean
)
# Compare the group means with the calibration table
print(calibration_results)

print(weighted_calibration)
shell.exec(normalizePath("figures"))
# Inspect the code used to create calibration_results
calibration_results

# Check the variables in your survey design
names(nhanes_design$variables)
calibration
# Inspect the structure of the calibration tables
str(calibration)

str(calibration_results)

str(weighted_calibration)

# Check the names of the final model's variables
formula(final_model)
# Inspect the survey design's sampling variables
names(nhanes_design$variables)[
  grepl(
    "WT|SDMVSTRA|SDMVPSU",
    names(nhanes_design$variables)
  )
]