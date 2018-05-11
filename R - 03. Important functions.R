http://www.sr.bham.ac.uk/~ajrs/R/r-function_list.html

1. See your data frame:
	summary(data)
	dim(data)
	class(data)
	str(data)
	head(data) - first 6 rows
	tail(data)
	View(data)

2. Sampling in R:
	Example:
		t<-sort(sample(nrow(df),nrow(df)*0.7)) #takes 70% of the data 
		dev <- df[t,]
		val <- df[-t,]
	Example:
		set.seed(729375)
		d$rgroup = runif(dim(t)[[1]])
		dTrainM = subset(t,rgroup<=0.5)  # set for building models
		dTrainC = subset(t,(rgroup>0.5) & (rgroup<=0.9)) # set for impact coding
		dTest = subset(t,rgroup>0.9) # set for evaluation
	Example:
		ind <- sample(2, nrow(train), replace=T, prob=c(0.60,0.40))
		trainData<-train[ind==1,]
		testData <- train[ind==2,]

3. table(df$gender) - count male and female

4. By:
	by(df$friend_count,df$gender,summary)  - signature is like by(variable,categorical_variable,funtion)
	The by( ) function applys a function to each level of a factor or factors
	
	Example:
		by(mydata, mydatat$byvar, function(x) mean(x))
5. With:
	The with( ) function applys an expression to a dataset
	Example:
		# with(data, expression)
		# example applying a t-test to a data frame mydata 
		with(mydata, t.test(y ~ group))

6. cut: Convert Numeric to Factor:
	cut divides the range of x into intervals and codes the values in x according to which interval they fall. The leftmost interval corresponds to level one, the next leftmost to level two and so on.
	
	Example: 
		a)	Z <- stats::rnorm(10000)
			table(cut(Z, breaks = -6:6))
		b)	table(cut(Z, 4))
		c)	tx0 <- c(9, 4, 6, 5, 3, 10, 5, 3, 5)
			x <- rep(0:8, tx0)
7. quantile: Sample Quantiles:
	The generic function quantile produces sample quantiles corresponding to the given probabilities. The smallest observation corresponds to a probability of 0 and the largest to a probability of 1.
	
	quantile(x, probs = seq(0, 1, 0.25), na.rm = FALSE,names = TRUE)
	
	Example:
		a) quantile(x <- rnorm(1001)) # Extremes & Quartiles by default
		b) quantile(x,  probs = c(0.1, 0.5, 1, 2, 5, 10, 50, NA)/100)

8. merge: 
	Merge two data frames by common columns or row names, or do other versions of database join operations.
	
	merge(x, y, by = intersect(names(x), names(y)),by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all,sort = TRUE,incomparables = NA)
	#here incomparables removes NA for matching condition 
		
9. reshape2: 
	Converting data between wide and long format
	x = data.frame(subject = c("John", "Mary"), 
               time = c(1,1),
               age = c(33,NA),
               weight = c(90, NA),
               height = c(2,2))
	molten = melt(x, id = c("subject", "time"))
	molten = melt(x, id = c("subject", "time"), na.rm = TRUE)
	
	dcast(molten, formula = time + subject ~ variable)

	
Distributions:
	To generate random samples from a variety of distributions
	rnorm(n,mean,sd)
	rbinom(n,size,p)
	sample(x, size, replace = FALSE, prob = NULL)      #samples with or without replacement

		
grep()     # Pattern matching
identical()  # Test if 2 objects are *exactly* equal
jitter()     # Add a small amount of noise to a numeric vector
julian()     # Return Julian date
floor(x), ceiling(x), round(x), signif(x), trunc(x)   # rounding functions


Fitting / regression / optimisation:
	lm		# Fit liner model
	glm		# Fit generalised linear model
	nls		# non-linear (weighted) least-squares fitting
	lqs		# "library(MASS)" resistant regression

FOR THE LOVE OF GRAPHICS:
	par( ) – set or query graphical parameters, probably my favourite
	points(x,y)  – add a set of points to an existing graph
	abline( ) – adds a straight line to an existing graph, where specified
	hist(x) – plot a histogram of x
	pdf(); png( ); jpeg( ) – plot to pdf file, PNG file, or JPEG file, repsectively
	image( ) – plot an image

	
	
Distributions:
	beta(a, b)
	gamma(x)
	choose(n, k)
	factorial(x)

	dnorm(x, mean=0, sd=1, log = FALSE)      #normal distribution
	pnorm(q, mean=0, sd=1, lower.tail = TRUE, log.p = FALSE)
	qnorm(p, mean=0, sd=1, lower.tail = TRUE, log.p = FALSE)
	rnorm(n, mean=0, sd=1)


	dunif(x, min=0, max=1, log = FALSE)      #uniform distribution
	punif(q, min=0, max=1, lower.tail = TRUE, log.p = FALSE)
	qunif(p, min=0, max=1, lower.tail = TRUE, log.p = FALSE)
	runif(n, min=0, max=1)
	
