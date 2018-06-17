data wrangling is a process that includes six core activities:
	1. Discovering
	2. Structuring
	3. Cleaning
	4. Enriching
	5. Validating
	6. Publishing

1a. Create data frame:
	1) 	set.seed(1)
		d <- data.frame(year = rep(2000:2002, each = 3),
		count = round(runif(9, 0, 20)))
	2)	dfx <- data.frame(
		   group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
		   sex = sample(c("M", "F"), size = 29, replace = TRUE),
		   age = runif(n = 29, min = 18, max = 54)
		)
1b. Create matrix:
	matrix(data, nrow, ncol, byrow)
	
	1) B = matrix(c(2, 4, 3, 1, 5, 7), nrow=3, ncol=2) 
	2) m <- matrix(seq(1:6),nrow=3)
	3) mat <- matrix(rnorm(20), 4)
	
2. Reading files:
	read.csv("file name",header=T, quote="\"",colClasses=c("character"))
	read.delim("file name",header=T, quote="\"",colClasses=c("character"))
	read.table("file name",header=T, quote="\"",colClasses=c("character"),sep="\n")

3. read.table(file, header = FALSE, sep = "", quote = "\"'",na.strings=c('NA',''),stringsAsFactors=FALSE)
           
4. scan:
	Read data into a vector or list from the console or file.
	 scan(file = "", what = double(), nmax = -1, n = -1, sep = "",
     quote = if(identical(sep, "\n")) "" else "'\"", dec = ".",
     skip = 0, nlines = 0, na.strings = "NA",
     flush = FALSE, fill = FALSE, strip.white = FALSE,
     quiet = FALSE, blank.lines.skip = TRUE, multi.line = TRUE,
     comment.char = "", allowEscapes = FALSE,
     fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)
	 
5. plyr: split-apply-combine:
	a) plyr is a set of tools that solves a common set of problems: you need to break a big problem down into manageable pieces, operate on each piece and then put all the pieces back together. Its already possible to do this with split and the apply functions, but plyr just makes it all a bit easier.
	
	b) plyr builds on the built-in apply functions by giving you control over the input and output formats and keeping the syntax consistent across all variations. It also adds some niceties like error processing, parallel processing, and progress bars.
	
	c) The basic format is two letters followed by ply(). The first letter refers to the format in and the second to the format out.
	The three main letters are:
	i)   d = data frame
	ii)  a = array (includes matrices)
	iii) l = list
	So, ddply means: take a data frame, split it up, do something to it, and return a data frame and ldply means: take a list, split it up, do something to it, and return a data frame.
	
	Example:
		a) We will take a data frame, split it up by year, calculate the coefficient of variation of the count, and return a data frame. 
		
		set.seed(1)
		d <- data.frame(year = rep(2000:2002, each = 3),
		  count = round(runif(9, 0, 20)))
		print(d)
		
		library(plyr)
		ddply(d, "year", function(x) {
		  mean.count <- mean(x$count)
		  sd.count <- sd(x$count)
		  cv <- sd.count/mean.count
		  data.frame(cv.count = cv)
		})
		
		#output:
			#   year cv.count
			# 1 2000   0.3985
			# 2 2001   0.6062
			# 3 2002   0.2309
			
		b) df<-ddply(df, .(citycode, new_rating), transform,
            N    = length(price),
            q1 = quantile(price,probs=0.15,na.rm = T),
            q2 = quantile(price,probs=0.60,na.rm = T),
            q3 = quantile(price,probs=0.9,na.rm = T))
			
		c) # An example using a formula for .variables
			ddply(baseball[1:100,], ~ year, nrow)
			# Applying two functions; nrow and ncol
			ddply(baseball, .(lg), c("nrow", "ncol"))
			
		d) # Calculate mean runs batted in for each year
			rbi <- ddply(baseball, .(year), summarise,
						 mean_rbi = mean(rbi, na.rm = TRUE))
						 
						 
	d) transform and summarise:
		It is often convenient to use these functions within one of the **ply functions. transform acts as it would normally as the base R function and modifies an existing data frame. summarise creates a new condensed data frame.
		
		Example a) ddply(d, "year", summarise, mean.count = mean(count))
					#   year   mean.count
					# 1 2000      7.667
					# 2 2001     13.333
					# 3 2002     15.000
					
				b) ddply(d, "year", transform, total.count = sum(count))
					#   year count    total.count
					# 1 2000     5          23
					# 2 2000     7          23
					# 3 2000    11          23
					# 4 2001    18          40
					# 5 2001     4          40
					# 6 2001    18          40
					# 7 2002    19          45
					# 8 2002    13          45
					# 9 2002    13          45
					
					
	e) Bonus function: mutate:
		mutate works like transform but lets you build on columns.
		
		Example: ddply(d, "year", mutate, mu = mean(count), sigma = sd(count),cv = sigma/mu)
			output: 
					#   year count     mu sigma     cv
					# 1 2000     5  7.667 3.055 0.3985
					# 2 2000     7  7.667 3.055 0.3985
					# 3 2000    11  7.667 3.055 0.3985
					# 4 2001    18 13.333 8.083 0.6062
					# 5 2001     4 13.333 8.083 0.6062
					# 6 2001    18 13.333 8.083 0.6062
					# 7 2002    19 15.000 3.464 0.2309
					# 8 2002    13 15.000 3.464 0.2309
					# 9 2002    13 15.000 3.464 0.2309
		
	f) Plotting with plyr:
		You can use plyr to plot data by throwing away the output with an underscore (_). This is a bit cleaner than a for loop since you dont have to subset the data manually.
		
		Example:
			par(mfrow = c(1, 3), mar = c(2, 2, 1, 1), oma = c(3, 3, 0, 0))
			d_ply(d, "year", transform, plot(count, main = unique(year), type = "o"))
			mtext("count", side = 1, outer = TRUE, line = 1)
			mtext("frequency", side = 2, outer = TRUE, line = 1)
		
	g) Nested chunking of the data:
		The basic syntax can be easily extended to break apart the data based on multiple columns:
		
		Example: 
				baseball.dat <- subset(baseball, year > 2000) # data from the plyr package
				x <- ddply(baseball.dat, c("year", "team"), summarize,
				  homeruns = sum(hr))
				head(x)
				
	h) Parallel processing:
		In conjunction with a package such as doParallel you can run your function separately on each core of your computer. On a dual core machine this make your code up to twice as fast. Simply register the cores and then set .parallel = TRUE
		
		Example:
			library(doParallel)
			registerDoParallel(cores = 2)
			system.time(llply(x, wait, .parallel = TRUE))
			
6. reshape2: 
	Converting data between wide and long format
	Example:
		x = data.frame(subject = c("John", "Mary"), 
               time = c(1,1),
               age = c(33,NA),
               weight = c(90, NA),
               height = c(2,2))
	a)	molten = melt(x, id = c("subject", "time"))
	b)	molten = melt(x, id = c("subject", "time"), na.rm = TRUE)
	c) dcast(molten, formula = time + subject ~ variable)

7. handling NA/missing values:
	a) NA (Not available) is generally interpreted as a missing value and has various forms - NA_integer_, NA_real_, etc.
	b) NaN (Not a Number) means 0/0 
	Of note, is.na() returns TRUE for both NA and NaN, which differs from is.nan()
	c) Finite, Infinite (Inf and -Inf):
		(Inf) - Infinite
		Associated functions is.finite() and is.infinite()
		pi / 0 ## = Inf a non-zero number divided by zero creates infinity
		0 / 0  ## =  NaN
		1/0 + 1/0 # Inf
		1/0 - 1/0 # NaN
	d) NULL: Note that NULL is different from the other two. NULL means that there is no value, while NA and NaN mean that there is some value, although one that is perhaps not usable
		is.null(x)
		# TRUE
		is.na(y)
		# TRUE
		is.nan(z)
		# TRUE
	Example:
		One function to detect NaN, NA, Inf, -Inf, etc.? - 
		answer is - is.finite() [well-formed number]
			> is.finite(NA)
			[1] FALSE
			> is.finite(NaN)
			[1] FALSE
			> is.finite(Inf)
			[1] FALSE
			> is.finite(1L)
			[1] TRUE
			> is.finite(1.0)
			[1] TRUE
			> is.finite("A")
			[1] FALSE
			> is.finite(pi)
			[1] TRUE
			> is.finite(1+0i)
			[1] TRUE
	e) Handling missing values:
		Methods: Testing for Missing Values - is.na(x)
				Recoding Values to Missing:
					# recode 99 to missing for variable v1
					# select rows where v1 is 99 and recode column v1 
					mydata$v1[mydata$v1==99] <- NA
				Excluding Missing Values from Analyses:
					x <- c(1,2,NA,3)
					mean(x) # returns NA
					mean(x, na.rm=TRUE) # returns 2
				complete.cases() returns a logical vector indicating which cases are complete:
					# list rows of data that have missing values 
					mydata[!complete.cases(mydata),]
				na.omit() returns the object with listwise deletion of missing values:
					# create new dataset without missing data 
					newdata <- na.omit(mydata)
		Another way to impute the missing value - from mean/random forest/or some other way
		
	f)	## Visualize Missing Values
		library(ggplot2)
		missing <- data.frame(matrix(NA, nrow=54, ncol=2))
		for(i in 1:p){
			# calcaulate the missing number
			missing[i,2] <- sum(is.na(a[,i]))/nrow(a)
		}
		missing[,1] <- colnames(a)
		names(missing) <- c('names','percentage')
		ggplot(missing, aes(x=reorder(names, percentage), y=percentage)) +geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Missing Value Percentage")

		
8. Data transformation and/or variable creation: (Also can use cut function)
	Example: g.data$amt.fac <- as.factor(ifelse(amount <= 2500, "0-2500", ifelse(amount <= 5000, "2600-5000", "5000+")))
			g.data$age.fac <- as.factor(ifelse(age<=30, '0-30', ifelse(age <= 40, '30-40', '40+')))
9. Feature Engineering: How to transform variables and create new ones:
		a) Feature engineering is the science (and art) of extracting more information from existing data.
		
		b) Process of Feature Engineering:
			You perform feature engineering once you have completed the first 5 steps in data exploration – Variable Identification, Univariate, Bivariate Analysis, Missing Values Imputation and Outliers Treatment. Feature engineering itself can be divided in 2 steps:
				-> Variable transformation
				-> Variable / Feature creation.
			Variable Transformation:
				In data modelling, transformation refers to the replacement of a variable by a function.In other words, transformation is a process that changes the distribution or relationship of a variable with others.
				When should we use Variable Transformation:
					-> When we want to change the scale of a variable or standardize the values of a variable for better understanding. While this transformation is a must if you have data in different scales, this transformation does not change the shape of the variable distribution
					-> When we can transform complex non-linear relationships into linear relationships. Existence of a linear relationship between variables is easier to comprehend compared to a non-linear or curved relation. 
					-> Symmetric distribution is preferred over skewed distribution as it is easier to interpret and generate inferences. Some modeling techniques requires normal distribution of variables. So, whenever we have a skewed distribution, we can use transformations which reduce skewness. For right skewed distribution, we take square / cube root or logarithm of variable and for left skewed, we take square / cube or exponential of variables.
					-> Binning of Variables: Variable Transformation is also done from an implementation point of view (Human involvement). Let’s understand it more clearly. In one of my project on employee performance, I found that age has direct correlation with performance of the employee i.e. higher the age, better the performance. From an implementation stand point, launching age based progamme might present implementation challenge. However, categorizing the sales agents in three age group buckets of <30 years, 30-45 years and >45  and then formulating three different strategies for each group is a judicious approach. This categorization technique is known as Binning of Variables.
				common methods of Variable Transformation:
					-> Logarithm
					-> Square / Cube root
					-> Binning: It is used to categorize variables. It is performed on original values, percentile or frequency. Decision of categorization technique is based on business understanding.
			
			What is Feature / Variable Creation:
				Feature / Variable creation is a process to generate a new variables / features based on existing variable(s). For example, say, we have date(dd-mm-yy) as an input variable in a data set. We can generate new variables like day, month, year, week, weekday that may have better relationship with target variable. This step is used to highlight the hidden relationship in a variable.
				Techniques to create new features:
					-> Creating derived variables:
						This refers to creating new variables from existing variable(s) using set of functions or different methods.
					-> Creating dummy variables:
						One of the most common application of dummy variable is to convert categorical variable into numerical variables. Dummy variables are also called Indicator Variables. It is useful to take categorical variable as a predictor in statistical models.  Categorical variable can take values 0 and 1. Let’s take a variable ‘gender’. We can produce two variables, namely, “Var_Male” with values 1 (Male) and 0 (No male) and “Var_Female” with values 1 (Female) and 0 (No Female). We can also create dummy variables for more than two classes of a categorical variables with n or n-1 dummy variables
		c) 5 Simple manipulations to extract maximum information out of your data:
			1. Create variables for difference in date, time and addresses
			2. Create new ratios and proportions
			3. Apply standard transformations: By looking at variations and plots of a variable along with output, you can see if applying basic transformations on variables creates a better relationship. 
			4. Include effect of influencer
			5. Check variables for seasonality and create the model for right period
			
10. When we have long tail data (higher dispersion of data) we generally perform transformation.
		summary(pf$friend_count)
		or
		summary(log10(pf$friend_count+1))
		or
		summary(sqrt(pf$friend_count))
11. Outlier Removal:
	#video : https://www.youtube.com/watch?v=haGaPUamYAg 
	#function 
	remove_outliers <- function(x, na.rm = TRUE, ...) {
	  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
	  H <- 1.5 * IQR(x, na.rm = na.rm)
	  y <- x
	  y[x < (qnt[1] - H)] <- NA
	  y[x > (qnt[2] + H)] <- NA
	  y
	}
	#example 
	set.seed(1)
	x <- rnorm(100)
	print(x)
	x <- c(-10, x, 10)
	y <- remove_outliers(x)
	## png()
	par(mfrow = c(1, 2))
	boxplot(x)
	boxplot(y)
	
12. Outlier Detection:
	The LOF algorithm (Local Outlier Factor):
		#http://www.rdatamining.com/examples/outlier-detection
		LOF (Local Outlier Factor) is an algorithm for identifying density-based local outliers [Breunig et al., 2000]. With LOF, the local density of a point is compared with that of its neighbors. If the former is signi.cantly lower than the latter (with an LOF value greater than one), the point is in a sparser region than its neighbors, which suggests it be an outlier.

		Function lofactor(data, k) in packages DMwR and dprep calculates local outlier factors using the LOF algorithm, where k is the number of neighbors used in the calculation of the local outlier factors.
		
		Calculate Outlier Scores:
				> library(DMwR)
				> # remove "Species", which is a categorical column
				> iris2 <- iris[,1:4]
				> outlier.scores <- lofactor(iris2, k=5)
				> plot(density(outlier.scores))
		
				> # pick top 5 as outliers
				> outliers <- order(outlier.scores, decreasing=T)[1:5]
				> # who are outliers
				> print(outliers)
				[1] 42 107 23 110 63
				
		Visualize Outliers with Plots:
				> n <- nrow(iris2)
				> labels <- 1:n
				> labels[-outliers] <- "."
				> biplot(prcomp(iris2), cex=.8, xlabs=labels)
				
		We can also show outliers with a pairs plot as below, where outliers are labeled with "+" in red.:
				> pch <- rep(".", n)
				> pch[outliers] <- "+"
				> col <- rep("black", n)
				> col[outliers] <- "red"
				> pairs(iris2, pch=pch, col=col)
		Parallel Computation of LOF Scores:
			Package Rlof provides function lof(), a parallel implementation of the LOF algorithm. Its usage is similar to the above lofactor(), but lof() has two additional features of supporting multiple values of k and several choices of distance metrics. Below is an example of lof(). 
			> library(Rlof)
			> outlier.scores <- lof(iris2, k=5)
			> # try with different number of neighbors (k = 5,6,7,8,9 and 10)
			> outlier.scores <- lof(iris2, k=c(5:10))
			
			
13. Ways to deal with Continuous Variables in Predictive Modeling:
	http://www.analyticsvidhya.com/blog/2015/11/8-ways-deal-continuous-variables-predictive-modeling/?utm_content=buffer435ca&utm_medium=social&utm_source=facebook.com&utm_campaign=buffer 
	

14. Methods to deal with Categorical Variables in Predictive Modeling:
	http://www.analyticsvidhya.com/blog/2015/11/easy-methods-deal-categorical-variables-predictive-modeling/