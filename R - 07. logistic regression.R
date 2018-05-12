http://www.r-bloggers.com/logistic-regression-in-r-part-two/ 
http://www.r-bloggers.com/evaluating-logistic-regression-models/

Why cannt use linear regression for outcome is dichotomous (yes/no) (For classification): 
	Because:
		-> the error terms (\epsilon ) from this model will not be normally distributed. They can only take two values
		-> the probability of the outcome occurring, \pi = p(Y = 1) , follows a binomial distribution and depends on the value of the predictor variables, X . Since the variance of a binomial distribution is a function of the probability, the error variance will also vary with the level of X  and as such the assumption of homoscedasticity will be violated,
		-> the mean responses are constrained to lie within 0 and 1. With a linear regression model, the predicted values might fall outside of this range.
		
		
Logistic Regression:
	Logistic regression is used to analyze the relationship between a dichotomous dependent variable and one or more categorical or continuous independent variables. It specifies the likelihood of the response variable as a function of various predictors. 
	
	To fit logistic regression model, glm() function is used in R which is similar to lm(), but glm() includes additional parameters. The format is

	glm(Y~X1+X2+X3, family=binomial(link=”logit”), data=mydata)
	
	Here, Y is dependent variable and X1, X2 and X3 are independent variables. 
	binomial(link=”logit”) which means the probability distribution of regression model is binomial and link function is logit.
	
Example 1:
	library(caret)
	data(GermanCredit)
 
	Train <- createDataPartition(GermanCredit$Class, p=0.6, list=FALSE)
	training <- GermanCredit[ Train, ]
	testing <- GermanCredit[ -Train, ]
	 
	mod_fit_one <- glm(Class ~ Age + ForeignWorker + Property.RealEstate + Housing.Own +
	CreditHistory.Critical, data=training, family="binomial")
	 
	summary(mod_fit_one) # estimates 
	exp(coef(mod_fit$finalModel)) # odds ratios
	predict(mod_fit_one, newdata=testing, type="response") # predicted probabilities

Example 2:
	Model_1<-glm(admitted ~ exam_1 +exam_2, family = binomial("logit"), data=data)
	#predict
	in_frame<-data.frame(exam_1=60,exam_2=86)
	predict(Model_1,in_frame, type="response")
	Output
	0.9894302
	Here, the output is given as a probability score which has value in range 0 to 1. If the probability score is greater than 0.5 then it is considered as TRUE. If the probability score is less than or equal to 0.5 then it is considered as FALSE
	
	round(predict(Model_1, in_frame, type="response"))
	Output
	1


GLM – Evaluating Logistic Regression Models 
(http://www.r-bloggers.com/veterinary-epidemiologic-research-glm-evaluating-logistic-regression-models-part-3/):
	Two steps in assessing the fit of the model:
		-> first is to determine if the model fits using summary measures of goodness of fit or by assessing the predictive ability of the model;
		->second is to deterime if there’s any observations that do not fit the model or that have an influence on the model.
		
	Covariate pattern:
		A covariate pattern is a unique combination of values of predictor variables.
		library(epiR)
	Goodness-of-fit test
	Overdispersion:
		Sometimes we can get a deviance that is much larger than expected if the model was correct. It can be due to the presence of outliers, sparse data or clustering of data. The approach to deal with overdispersion is to add a dispersion parameter \sigma^2 .
	Predictive ability of the model:
		A ROC curve can be drawn
		predicted <- predict(mod3)
		library(ROCR)
		prob <- prediction(predicted, nocardia$casecont,label.ordering = c('Control', 'Case'))
		tprfpr <- performance(prob, "tpr", "fpr")
		tpr <- unlist(slot(tprfpr, "y.values"))
		fpr <- unlist(slot(tprfpr, "x.values"))
		roc <- data.frame(tpr, fpr)
		ggplot(roc) + geom_line(aes(x = fpr, y = tpr)) + 
		+   geom_abline(intercept = 0, slope = 1, colour = "gray") + 
		+   ylab("Sensitivity") + 
		+   xlab("1 - Specificity")
	
	Identifying important observations:
		Like for linear regression, large positive or negative standardized residuals allow to identify points which are not well fit by the model.
	
Evaluating Logistic Regression Models (http://www.r-bloggers.com/evaluating-logistic-regression-models/):
	There are many thousands of tests one can apply to inspect a logistic regression model, and much of this depends on whether ones goal is prediction, classification, variable selection, inference, causal modeling, etc. 
	
	1. We must now examine the model to understand how well it fits the data and generalizes to other observations. 
	
	2. The evaluation process involves the assessment of three distinct areas –
			a)goodness of fit
			b)tests of individual predictors
			c)validation of predicted values
	
	3. Goodness of Fit: Likelihood Ratio Test:
		A logistic regression is said to provide a better fit to the data if it demonstrates an improvement over a model with fewer predictors. This occurs by comparing the likelihood of the data under the full model against the likelihood of the data under a model with fewer predictors. The null hypothesis, H0  holds that the reduced model is true,so an \alpha  for the overall model fit statistic that is less than 0.05  would compel us to reject H0.
		
		Example:
			mod_fit_one <- glm(Class ~ Age + ForeignWorker + Property.RealEstate + Housing.Own+CreditHistory.Critical, data=training, family="binomial")
 
			mod_fit_two <- glm(Class ~ Age + ForeignWorker, data=training, family="binomial")
 
			library(lmtest)
			lrtest(mod_fit_one, mod_fit_two)
		
	4. Goodness of Fit: Pseudo R^2:
		With linear regression, the R^2  statistic tells us the proportion of variance in the dependent variable that is explained by the predictors. While no equivilent metric exists for logistic regression, there are a number of R^2  values that can be of value. Most notable is McFadden’s R^2 , which is defined as 1 - \frac{ ln(L_M) }{ ln(L_0) } where ln(L_M)  is the log likelihood value for the fitted model and ln(L_0)  is the log likelihood for the null model with only an intercept as a predictor. The measure ranges from 0  to just under 1 , with values closer to zero indicating that the model has no predictive power.
		
		Example:
			library(pscl)
			pR2(mod_fit_one) # look for 'McFadden'
			
	5. Goodness of Fit: Hosmer-Lemeshow Test:
		The Hosmer-Lemeshow test examines whether the observed proportion of events are similar to the predicted probabilities of occurences in subgroups of the dataset using a pearson chi-square statistic from the 2 x g table of observed and expected frequencies. Small values with large p-values indicate a good fit to the data while large values with p-values below 0.05  indicate a poor fit. The null hypothesis holds that the model fits the data and in the below example we would reject H_0 .
		
		Example:
			library(MKmisc)
			HLgof.test(fit = fitted(mod_fit_one), obs = training$Class)
 
			library(ResourceSelection)
			hoslem.test(training$Class, fitted(mod_fit_one), g=10)
			
	6. Tests of Individual Predictors: Wald Test:
		A wald test is used to evaluate the statistical significance of each coefficient in the model and is calculated by taking the ratio of the square of the regression coefficient to the square of the standard error of the coefficient. The idea is to test the hypothesis that the coefficient of an independent variable in the model is not significantly different from zero. If the test fails to reject the null hypothesis, this suggests that removing the variable from the model will not substantially harm the fit of that model.
		
		Example:
			library(survey)
 
			regTermTest(mod_fit_one, "ForeignWorker")
			regTermTest(mod_fit_one, "CreditHistory.Critical")
			
	7. Tests of Individual Predictors: Variable Importance:
		To assess the relative importance of individual predictors in the model, we can also look at the absolute value of the t-statistic for each model parameter. This technique is utilized by the varImp function in the caret package for general and generalized linear models. The t-statistic for each model parameter helps us determine if it’s significantly different from zero.
		
		Example:
			mod_fit <- train(Class ~ Age + ForeignWorker + Property.RealEstate + Housing.Own +CreditHistory.Critical, data=training, method="glm", family="binomial")
 
			varImp(mod_fit)
			
	8. Validation of Predicted Values: Classification Rate:
		With predictive models, he most critical metric regards how well the model does in predicting the target variable on out of sample observations. The process involves using the model estimates to predict values on the training set. Afterwards, we will compare the predicted target variable versus the observed values for each observation.
		
		Example:
			pred = predict(mod_fit, newdata=testing)
			accuracy <- table(pred, testing[,"Class"])
			sum(diag(accuracy))/sum(accuracy)
 
			pred = predict(mod_fit, newdata=testing)
			confusionMatrix(data=pred, testing$Class)
			
	9.Validation of Predicted Values: ROC Curve:
		The receiving operating characteristic is a measure of classifier performance. It’s based on the proportion of positive data points that are correctly considered as positive, TPR = \frac{TP}{n(Y=1)} , and the proportion of negative data points that are accuratecly considered as negative, TNR = \frac{TN}{n(Y=0)} . These metrics are expressed through a graphic that shows the trade off between these values. Ultimately, we’re concerned about the area under the ROC curve, or AUROC. That metric ranges from 0.50 to 1.00 , and values above 0.80 indicate that the model does a great job in discriminating between the two categories which comprise our target variable.
		
		Example:
			library(pROC)
			# Compute AUC for predicting Class with the variable CreditHistory.Critical
			f1 = roc(Class ~ CreditHistory.Critical, data=training)
			plot(f1, col="red")
			 
			library(ROCR)
			# Compute AUC for predicting Class with the model
			prob <- predict(mod_fit_one, newdata=testing, type="response")
			pred <- prediction(prob, testing$Class)
			perf <- performance(pred, measure = "tpr", x.measure = "fpr")
			plot(perf)
			 
			auc <- performance(pred, measure = "auc")
			auc <- auc@y.values[[1]]
			auc
			
	10. Validation of Predicted Values:K-Fold Cross Validation:
		When evaluating models, we often want to assess how well it performs in predicting the target variable on different subsets of the data. One such technique for doing this is k-fold cross-validation, which partitions the data into k equally sized segments (called ‘folds’). One fold is held out for validation while the other k-1 folds are used to train the model and then used to predict the target variable in our testing data. This process is repeated k times, with the performance of each model in predicting the hold-out set being tracked using a performance metric such as accuracy. The most common variation of cross validation is 10-fold cross-validation.
		
		Example: 
			ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)

			mod_fit <- train(Class ~ Age + ForeignWorker + Property.RealEstate + Housing.Own + CreditHistory.Critical,  data=GermanCredit, method="glm", family="binomial",trControl = ctrl, tuneLength = 5)

			pred = predict(mod_fit, newdata=testing)
			confusionMatrix(data=pred, testing$Class)
			

Assumptions of Logistic Regression:
		Logistic regression does not make many of the key assumptions of linear regression and general linear models that are based on ordinary least squares algorithms – particularly regarding linearity, normality, homoscedasticity, and measurement level.
		
		However some other assumptions still apply:
			-> Binary logistic regression requires the dependent variable to be binary and ordinal logistic regression requires the dependent variable to be ordinal.  Reducing an ordinal or even metric variable to dichotomous level loses a lot of information, which makes this test inferior compared to ordinal logistic regression in these cases.
			-> Secondly, since logistic regression assumes that P(Y=1) is the probability of the event occurring, it is necessary that the dependent variable is coded accordingly.  That is, for a binary regression, the factor level 1 of the dependent variable should represent the desired outcome.
			-> Thirdly, the model should be fitted correctly.  Neither over fitting nor under fitting should occur.  That is only the meaningful variables should be included, but also all meaningful variables should be included.  A good approach to ensure this is to use a stepwise method to estimate the logistic regression.
			-> Fourthly, the error terms need to be independent.  Logistic regression requires each observation to be independent.  That is that the data-points should not be from any dependent samples design, e.g., before-after measurements, or matched pairings.  Also the model should have little or no multicollinearity.  That is that the independent variables should be independent from each other.  However, there is the option to include interaction effects of categorical variables in the analysis and the model.
			-> Fifthly, logistic regression assumes linearity of independent variables and log odds.  Whilst it does not require the dependent and independent variables to be related linearly, it requires that the independent variables are linearly related to the log odds. 
			-> Lastly, it requires quite large sample sizes.  Because maximum likelihood estimates are less powerful than ordinary least squares (e.g., simple linear regression, multiple linear regression); whilst OLS needs 5 cases per independent variable in the analysis, ML needs at least 10 cases per independent variable, some statisticians recommend at least 30 cases for each parameter to be estimated.
			