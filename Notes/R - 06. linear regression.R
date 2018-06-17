https://www.youtube.com/watch?v=aq8VU5KLmkY

Regression is about to get the relationship between variables (line of best fit through all the points) and then assess the strength of the relationship.

RSS - Residuals sum of squares - SUMMATION(y(hat)-y)^2
ESS - Explained sum of squares - SUMMATION(y(bar)-y(hat))^2
TSS - Total sum of squares - ESS + RSS - SUMMATION(y-y(bar))^2

R-suared = ESS/TSS - The proporation of the variance in Y being explained by the variance in X (Always 0 to 1)
	so when RSS is high, we have low R-suared and when RSS is low we have high R-suared
e = (y(hat)-y)

Degrees of Freedom (df) -
	df = n-k-1 where n, number of observations; k, number of explanatory (X) variables
		so, additional X variable causes us to lost degree of freedom
		(imp) df is closly related to R-suared and R-suared is very imp for any regression (Its measure of strength of X and Y)
		
		Question: How df is relate to R-suared?
		Ans: As df decreases, (i.e. more variables added to the model) R-suared will ONLY increase i.e. if we add more and more X variables into model whether they are related or not to Y, R-suared will increase. So we Use Adjusted R-suared
Adjusted R-suared:
		as k increase, Adj R-suared will tend to decreas, reflecting the reduced power in the model. but if we add useful variable to model then Adj R-suared will increase. Adj R-suared is not bouned by 0 or 1, it can take negative values as well.
		The adjusted R-squared is a modified version of R-squared that has been adjusted for the number of predictors in the model. The adjusted R-squared increases only if the new term improves the model more than would be expected by chance. It decreases when a predictor improves the model by less than expected by chance. The adjusted R-squared can be negative, but it’s usually not.  It is always lower than the R-squared.

Both adjusted R-squared and predicted R-square provide information that helps you assess the number of predictors in your model:
	-> Use the adjusted R-square to compare models with different numbers of predictors
	-> Use the predicted R-square to determine how well the model predicts new observations and whether the model is too complicated
		
R-squared (coefficient of determination or the coefficient of multiple determination for multiple regression):
	It shows the verability of the dependent variable is explained by independent variables. the strength of the relationship between your model and the response variable.
	-> 0% indicates that the model explains none of the variability of the response data around its mean
	-> 100% indicates that the model explains all the variability of the response data around its mean
	
R-squared assess the Goodness-of-Fit. 		

How to Interpret Regression Analysis Results: P-values and Coefficients 
		(http://blog.minitab.com/blog/adventures-in-statistics/how-to-interpret-regression-analysis-results-p-values-and-coefficients):
		How Do I Interpret the P-Values in Linear Regression Analysis:
				The p-value for each term tests the null hypothesis that the coefficient is equal to zero (no effect). A low p-value (< 0.05) indicates that you can reject the null hypothesis. In other words, a predictor that has a low p-value is likely to be a meaningful addition to your model because changes in the predictors value are related to changes in the response variable.
				Conversely, a larger (insignificant) p-value suggests that changes in the predictor are not associated with changes in the response.
		How Do I Interpret the Regression Coefficients for Linear Relationships:
				Regression coefficients represent the mean change in the response variable for one unit of change in the predictor variable while holding other predictors in the model constant.
		How Do I Interpret the Regression Coefficients for Curvilinear Relationships and Interaction Terms:
				As a refresher, polynomial terms model curvature in the data, while interaction terms indicate that the effect of one predictor depends on the value of another predictor.
	
What Is the F-test of Overall Significance in Regression Analysis:
		In general, an F-test in regression compares the fits of different linear models. Unlike t-tests that can assess only one regression coefficient at a time, the F-test can assess multiple coefficients simultaneously.

Error and Residuals:
		The error (or disturbance) of an observed value is the deviation of the observed value from the (unobservable) true value of a quantity of interest (for example, a population mean), and the residual of an observed value is the difference between the observed value and the estimated value of the quantity of interest (for example, a sample mean)

Randomness in Residuals: (Residuals plots for regression analysis)
	You must explain everything that is possible with your predictors so that only random error is leftover. If you see non-random patterns in your residuals, it means that your predictors are missing something. This is why you need randomness in your residuals.
	(http://blog.minitab.com/blog/adventures-in-statistics/why-you-need-to-check-your-residual-plots-for-regression-analysis)

	
Extracting right variables for your Regression model:
		The precision of the model depends on the breadth (diversity) and depth (spread of data and correct transformations) of variables.
		Following are the categories of variables:
			1. Basic variable set
			2. Derived variable set
			3. Mathematically transformed variable set
			4. Bin Variable set
			5. Co-variant variable set
		Next steps to complete the regression model :  
			After we are done with the variable collection, following is the order to complete the regression model :
				1. Clean the data on each of the dependent and independent variables.
				2. Select the best predictive variable for the dependent variable
				3. Create the regression model
				4. Check the assumptions of the regression model using diagnostic plots (Below detailed discussion)
				5. Check the predictive power of the model
				6. Check the stability of the model
				7. Create the implementation tool

Diagnosing residual plots in linear regression models/ Assumptions of Linear Regression Model:
		-> Access the model: MAPE, Gini coefficient, R-square
			Gini and MAPE are metrics to gauge the predictive power of linear regression model.
		-> This article will take you through all the assumptions in a linear regression and how to validate assumptions and diagnose relationship using residual plots:
		
		-> There are number of assumptions of a linear regression model. In modeling, we normally check for five of the assumptions. These are as follows :
				1. Relationship between the outcomes and the predictors is linear.
				2. Error term has mean almost equal to zero for each value of outcome.
				3. Error term has constant variance.
				4. Errors are uncorrelated.
				5. Errors are normally distributed or we have an adequate sample size to rely on large sample theory.
				The point to be noted here is that none of these assumptions can be validated by R-square chart, F-statistics or any other model accuracy plots. On the other hand, if any of the assumptions are violated, chances are high that accuracy plot can give misleading results.
		-> How to use residual for diagnostics :
				Residual analysis is usually done graphically. Following are the two category of graphs we normally look at:
				1. Quantile plots : This type of is to assess whether the distribution of the residual is normal or not. The graph is between the actual distribution of residual quantiles and a perfectly normal distribution residuals. If the graph is perfectly overlaying on the diagonal, the residual is normally distributed.
				2. Scatter plots:  This type of graph is used to assess model assumptions, such as constant variance and linearity, and to identify potential outliers.
		-> http://www.statmethods.net/stats/rdiagnostics.html


1.	Simple regrssion model:
		# load train and test data set
		# identify features and response variable, value must be numeric 
		X_train<-input_variables_values_training_datasets
		Y_train<- target_variable_values_training_datasets
		X_test<- input_variables_values_test_datasets
		X<-cbind(x_train,y_train)
		# train model and check scores
		Linear<-lm(y_train~.,data=x)
		Summary(linear)
		#predict output
		Predicted <- predict(linear, x_test)
		
2. Multiple (Linear) Regression:
		R provides comprehensive support for multiple linear regression.
		a) Fitting the Model:
			# Multiple Linear Regression Example 
			fit <- lm(y ~ x1 + x2 + x3, data=mydata)
			summary(fit) # show results
			
			# Other useful functions 
			coefficients(fit) # model coefficients
			confint(fit, level=0.95) # CIs for model parameters 
			fitted(fit) # predicted values
			residuals(fit) # residuals
			anova(fit) # anova table 
			vcov(fit) # covariance matrix for model parameters 
			influence(fit) # regression diagnostics
			
		b) Diagnostic Plots:
			Diagnostic plots provide checks for heteroscedasticity, normality, and influential observerations.
			# diagnostic plots 
			layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
			plot(fit)
			
		c) Comparing Models:
			You can compare nested models with the anova( ) function
			# compare models
			fit1 <- lm(y ~ x1 + x2 + x3 + x4, data=mydata)
			fit2 <- lm(y ~ x1 + x2)
			anova(fit1, fit2)
			
		d) Cross Validation:
			You can do K-Fold cross-validation using the cv.lm( ) function in the DAAG package.
			# K-fold cross-validation
			library(DAAG)
			cv.lm(df=mydata, fit, m=3) # 3 fold cross-validation
			
			Sum the MSE for each fold, divide by the number of observations, and take the square root to get the cross-validated standard error of estimate.
			
			You can assess R2 shrinkage via K-fold cross-validation. Using the crossval() function from the bootstrap package, do the following:

			# Assessing R2 shrinkage using 10-Fold Cross-Validation 

			fit <- lm(y~x1+x2+x3,data=mydata) 

			library(bootstrap)
			# define functions 
			theta.fit <- function(x,y){lsfit(x,y)}
			theta.predict <- function(fit,x){cbind(1,x)%*%fit$coef} 

			# matrix of predictors
			X <- as.matrix(mydata[c("x1","x2","x3")])
			# vector of predicted values
			y <- as.matrix(mydata[c("y")]) 

			results <- crossval(X,y,theta.fit,theta.predict,ngroup=10)
			cor(y, fit$fitted.values)**2 # raw R2 
			cor(y,results$cv.fit)**2 # cross-validated R2
		
		e) Variable Selection:
			Selecting a subset of predictor variables from a larger set (e.g., stepwise selection) is a controversial topic. You can perform stepwise selection (forward, backward, both) using the stepAIC( ) function from the MASS package. stepAIC( ) performs stepwise model selection by exact AIC.
			# Stepwise Regression
			library(MASS)
			fit <- lm(y~x1+x2+x3,data=mydata)
			step <- stepAIC(fit, direction="both")
			step$anova # display results
			
			Alternatively, you can perform all-subsets regression using the leaps( ) function from the leaps package. In the following code nbest indicates the number of subsets of each size to report. Here, the ten best models will be reported for each subset size (1 predictor, 2 predictors, etc.).
			
			# All Subsets Regression
			library(leaps)
			attach(mydata)
			leaps<-regsubsets(y~x1+x2+x3+x4,data=mydata,nbest=10)
			# view results 
			summary(leaps)
			# plot a table of models showing variables in each model.
			# models are ordered by the selection statistic.
			plot(leaps,scale="r2")
			# plot statistic by subset size 
			library(car)
			subsets(leaps, statistic="rsq")
			
		f) Relative Importance:
			The relaimpo package provides measures of relative importance for each of the predictors in the model. See help(calc.relimp) for details on the four measures of relative importance provided.
			# Calculate Relative Importance for Each Predictor
			library(relaimpo)
			calc.relimp(fit,type=c("lmg","last","first","pratt"),rela=TRUE)

			# Bootstrap Measures of Relative Importance (1000 samples) 
			boot <- boot.relimp(fit, b = 1000, type = c("lmg", "last", "first", "pratt"), rank = TRUE, diff = TRUE, rela = TRUE)
			booteval.relimp(boot) # print result
			plot(booteval.relimp(boot,sort=TRUE)) # plot result
		g) Graphic Enhancements:
			The car package offers a wide variety of plots for regression, including added variable plots, and enhanced diagnostic and scatter plots.
		h) Going Further:
			Nonlinear Regression:
				he nls package provides functions for nonlinear regression. See John Foxs Nonlinear Regression and Nonlinear Least Squares for an overview
			Robust Regression:
				There are many functions in R to aid with robust regression. For example, you can perform robust regression with the rlm( ) function in the MASS package.
3. polynomial regression:
		a) First we import the data into R:
			Year <- c(1959, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969)
			Population <- c(4835, 4970, 5085, 5160, 5310, 5260, 5235, 5255, 5235, 5210, 5175)
			sample1 <- data.frame(Year, Population)
		
		b) At this point may be useful to chart these values, to observe the trend and take an idea of the final polynomial function. For convenience we modify the column Year, creating a neighborhood of zero, thus:
			sample1$Year <- sample1$Year - 1964
		
		c) Put the values on a chart:
			plot(sample1$Year, sample1$Population, type="b")
		
		d) At what degree of the polynomial stop? Depends on the degree of precision that we seek. The greater the degree of the polynomial, the greater the accuracy of the model, but the greater the difficulty in calculating; we must also verify the significance of coefficients that are found
		
		e) In R for fitting a polynomial regression model (not orthogonal), there are two methods, among them identical. Suppose we seek the values of beta coefficients for a polynomial of degree 1, then 2nd degree, and 3rd degree:
			fit1 <- lm(sample1$Population ~ sample1$Year)
			fit2 <- lm(sample1$Population ~ sample1$Year + I(sample1$Year^2))
			fit3 <- lm(sample1$Population ~ sample1$Year + I(sample1$Year^2) + I(sample1$Year^3))
			Or we can write more quickly, for polynomials of degree 2 and 3:
			fit2b <- lm(sample1$Population ~ poly(sample1$Year, 2, raw=TRUE))
			fit3b <- lm(sample1$Population ~ poly(sample1$Year, 3, raw=TRUE))
		f) The function poly is useful if you want to get a polynomial of high degree, because it avoids explicitly write the formula. If we specify raw=TRUE, the two methods provide the same output, but if we do not specify raw=TRUE (or rgb(153, 0, 0);>raw=F), the function poly give us the values of the beta parameters of an orthogonal polynomials, which is different from the general formula I wrote above, although the models are both effective.
		
		g) After seeing the R-suared and beta values from model summary, we can compare the two model with an ANOVA table for better understanding:
			anova(fit2, fit3)
			
		h) The biggest problem now is to represent graphically the result. In fact, R does not exist (as far as I know) a function for plotting polynomials found. We must therefore proceed with graphic artifacts still valid, but somewhat laborious.
			-> First, we plotted the values, with the command seen before. This time only display the lines and not points, for convenience graphics:
				plot(sample1$Year, sample1$Population, type="l", lwd=3)
			-> Now add to this chart the progress of the 2nd degree polynomial, in this way:
				points(sample1$Year, predict(fit2), type="l", col="red", lwd=2)
			-> Lets add the graph of the polynomial of 3rd degree:
				points(sample1&Year, predict(fit3), type="l", col="blue", lwd=2)
			-> If we would instead obtain the graph of continuous functions obtained, we proceed in this manner:
				plot(sample1$Year, sample1$Population, type="p", lwd=3)
				pol2 <- function(x) fit2$coefficient[3]*x^2 + fit2$coefficient[2]*x + fit2$coefficient[1]
				curve(pol2, col="red", lwd=2)
				points(sample1$Year, sample1$Population, type="p", lwd=3)
			-> Now draw the graph of the polynomial of 3rd degree:
				plot(sample1$Year, sample1$Population, type="p", lwd=3)
				pol3 <- function(x) fit3$coefficient[4]*x^3 + fit3$coefficient[3]*x^2 + fit3$coefficient[2]*x + fit3$coefficient[1]
				curve(pol3, col="red", lwd=2)
				points(sample1$Year, sample1$Population, type="p", lwd=3)
			-> Also can create the interaction variable like:
				lm1 <- lm(y ~ r*s, data=d)
				lm2 <- lm(y ~ r + s + rs, data=d)
				
4. Evaluating Linear Regression Models or Regression validation:
		The validation process can involve using these 3 things:
		1. analyzing the goodness of fit of the regression (R-squared)
		2. analyzing whether the regression residuals are random (Residual plots)
		3. checking whether the models predictive performance deteriorates substantially when applied to data that were not used in model estimation (Out of time analysis)
		
		-> R-squared and Adjusted R-squared
		-> Residual plot vs fitted values
		-> F-test of overall significance:
				While R-squared provides an estimate of the strength of the relationship between your model and the response variable, it does not provide a formal hypothesis test for this relationship. The F-test of overall significance determines whether this relationship is statistically significant.
		-> Out-of-sample evaluation:
				Cross-validation is the process of assessing how the results of a statistical analysis will generalize to an independent data set. If the model has been estimated over some, but not all, of the available data, then the model using the estimated parameters can be used to predict the held-back data. If, for example, the out-of-sample mean squared error, also known as the mean squared prediction error, is substantially higher than the in-sample mean square error, this is a sign of deficiency in the model.
		
5. Assumptions of linear regression models:
		->  the residuals are normally distributed
		-> each observation is independent of the others
				Independence of the observations means that they are not related to one another or somehow clustered. If some observations are taken from one farm and others from a different farm, then the observations are not independent. To “control” for this violation of the assumption, the farm of origin must be included in the model.
		->  there is a linear relationship between the independent and dependent variables
				To test whether or not there is a linear relationship between the independent and dependent variables, we plot the standardized residuals against each independent observation
		-> the variance of the dependent (outcome) variable does not change with the value of the independent variable
		
		Assumptions (http://www.statisticssolutions.com/assumptions-of-linear-regression/):
		Linear regression makes several key assumptions:
			a)Linear relationship:
				linear regression needs the relationship between the independent and dependent variables to be linear.  It is also important to check for outliers since linear regression is sensitive to outlier effects.  The linearity assumption can best be tested with scatter plots,
			b) Multivariate normality:
				the linear regression analysis requires all variables to be multivariate normal.  This assumption can best be checked with a histogram and a fitted normal curve or a Q-Q-Plot.  Normality can be checked with a goodness of fit test, e.g., the Kolmogorov-Smirnof test.  When the data is not normally distributed a non-linear transformation, e.g., log-transformation might fix this issue, however it can introduce effects of multicollinearity.
			c) No or little multicollinearity:
				linear regression assumes that there is little or no multicollinearity in the data.  Multicollinearity occurs when the independent variables are not independent from each other.  A second important independence assumption is that the error of the mean has to be independent from the independent variables. If multicollinearity is found in the data centering the data, that is deducting the mean score might help to solve the problem.  Other alternatives to tackle the problems is conducting a factor analysis and rotating the factors to insure independence of the factors in the linear regression analysis.
			d) No auto-correlation:
				linear regression analysis requires that there is little or no autocorrelation in the data.  Autocorrelation occurs when the residuals are not independent from each other.  In other words when the value of y(x+1) is not independent from the value of y(x).  This for instance typically occurs in stock prices, where the price is not independent from the previous price.While a scatterplot allows you to check for autocorrelations, you can test the linear regression model for autocorrelation with the Durbin-Watson test.  
			e) Homoscedasticity:
				The last assumption the linear regression analysis makes is homoscedasticity.  The scatter plot is good way to check whether homoscedasticity (that is the error terms along the regression are equal) is given
6. The Disadvantages of Linear Regression:
	-> Only Looks at Linear Relationships (Non-Linearities)
	-> Only Looks at the Mean of the Dependent Variable
	-> Sensitive to Outliers
	-> Data Must Be Independent (Dependence Among Variables)
	