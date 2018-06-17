1. Categorical data are either nominal (unranked) or ordinal (ranked). Categorical data are often visualized using bar charts. Numerical data are either discrete or continuous. Common ways to visualize numerical data are histograms, boxplots, or scatter plots.  

2. For exploratory data analysis, we will introduce histograms and boxplots for univariate numerical data, scatterplots for bivariate numerical data, and pivot tables combined with bar charts for categorical data.

3. For Numerical variables: numerical variables by finding the minimum and maximum value, the mean, median, and standard deviation, and the first and third quartile (i.e., the 25th and 75th percentile). This information can be visualized with box plots

4. For categorical variables: Pivot tables are helpful to find counts of categorical data, which can then be displayed as bar charts where the height of each bar is proportional to the frequency in the respective category

5. When we have long tail data (higher dispersion of data) we generally perform transformation.
		summary(pf$friend_count)
		or
		summary(log10(pf$friend_count+1))
		or
		summary(sqrt(pf$friend_count))

6. R provides many functions to plot categorical data:
	Mosaic Plots: or extended mosaic plots, use mosaic(x, condvar=, data=) where x is a table or formula, condvar= is an optional conditioning variable, and data= specifies a data frame or a table. Include shade=TRUE to color the figure, and legend=TRUE to display a legend for the Pearson residuals.
	
	mosaicplot(Titanic, main = "Survival on the Titanic", color = TRUE)
	mosaicplot(default ~ age.fac, col = T)
	mosaicplot(default ~ job, col = T)
	mosaicplot(default ~ chk_acct, col = T)

	We can also use a spine plot.
	spineplot(default ~ age.fac)

	We can also check the relations between variables
	library(lattice)
	xyplot(amount ~ age)

	In case you dont have the "lattice" library installed, you can download it by running
	install.packages("lattice")

	We can also condition on a variable and see the interaction
	xyplot(amount ~ age | default)

	"lattice" package also has the option for a barchart and it lets you plot the barchart and a histogram for factor variable type as well.
	barchart(age.fac, col = "grey")
	barchart(amt.fac, col = "grey")

	histogram(employment, col = "grey")
	histogram(sav_acct, col = "grey")

7. Data Exploration and Visualization
	-> Summary and stats
	-> Various charts like pie charts and histograms
	-> Exploration of multiple variables
	-> Level plot, contour plot and 3D plot
	-> Saving charts into files of various formats
	
	a) Have a Look at Data:
		dim(iris)
		names(iris)
		str(iris)
		attributes(iris)
		iris[1:3, ]
		head(iris, 3)
		tail(iris, 3)
		iris[1:10, "Sepal.Length"] - one attributes value
		iris$Sepal.Length[1:10]
	b) Explore Individual Variables:
		summary():
			-> numeric variables: minimum, maximum, mean, median, and the first (25%) and third (75%) quartiles
			-> I categorical variables (factors): frequency of every level
		library(Hmisc)
		describe(iris[, c(1, 5)]) # check columns 1 & 5
		
		Mean, Median, Range and Quartiles:
			range(iris$Sepal.Length)
			quantile(iris$Sepal.Length)
			quantile(iris$Sepal.Length, c(0.1, 0.3, 0.65))
		Variance and Histogram:
			var(iris$Sepal.Length)
			hist(iris$Sepal.Length)
		Density:
			plot(density(iris$Sepal.Length))
		Pie Chart:
			table(iris$Species) - 	Frequency of factors: table()
			pie(table(iris$Species))
		Bar Chart:
			barplot(table(iris$Species))
	c) Explore Multiple Variables:
		Correlation: Covariance and correlation: cov() and cor()
			cov(iris$Sepal.Length, iris$Petal.Length)
			cor(iris$Sepal.Length, iris$Petal.Length)
			cov(iris[, 1:4])
		Aggreation: (Stats of Sepal.Length for every Species with aggregate())
			aggregate(Sepal.Length ~ Species, summary, data = iris)
		Boxplot:
			boxplot(Sepal.Length ~ Species, data = iris)
		Scatter Plot:
			with(iris, plot(Sepal.Length, Sepal.Width, col = Species,pch = as.numeric(Species)))
		A Matrix of Scatter Plots:
			pairs(iris)
	d) More Explorations:
		3D Scatter plot:
			library(scatterplot3d)
			scatterplot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)
		Interactive 3D Scatter Plot: (Package rgl supports interactive 3D scatter plot with plot3d())
			library(rgl)
			plot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)
		Heat Map: (Calculate the similarity between different flowers in the iris data with dist() and then plot it with a heat map)
			dist.matrix <- as.matrix(dist(iris[, 1:4]))
			heatmap(dist.matrix)
		Level Plot:(Function rainbow() creates a vector of contiguous colors.)
			library(lattice)
			levelplot(Petal.Width ~ Sepal.Length * Sepal.Width, iris, cuts = 9,col.regions = rainbow(10)[10:1])
		Contour:(contour() and filled.contour() in package graphics contourplot() in package lattice)
			filled.contour(volcano, color = terrain.colors, asp = 1, plot.axes = contour(volcano,add = T))
		3D Surface:
			persp(volcano, theta = 25, phi = 30, expand = 0.5, col = "lightblue")
		Parallel Coordinates:
			library(MASS)
			parcoord(iris[1:4], col = iris$Species)
		Visualization with Package ggplot2:
			library(ggplot2)
			qplot(Sepal.Length, Sepal.Width, data = iris, facets = Species ~ .)
	e) Save Charts to Files:
		Save charts to PDF and PS files: pdf() and postscript()
		BMP, JPEG, PNG and TIFF files: bmp(), jpeg(), png() and tiff()
		Close files (or graphics devices) with graphics.off() or dev.off() after plotting
		
			
8. Data Visualization in R (http://www.analyticsvidhya.com/blog/2015/07/guide-data-visualization-r/):
			Basic Visualization
				a) Histogram
				b) Bar / Line Chart
				c) Box plot
				d) Scatter plot
			Advanced Visualization
				a) Heat Map
				b) Mosaic Map
				c) Map Visualization
				d) 3D Graphs
				e) Correlogram
			R tip:  The 'HistData' package provides a collection of small data sets that are interesting and important in the history of statistics and data visualization.	
			a) Basic graphs in R can be created quite easily. The plot command is the command to note.
			b) It takes in many parameters from x axis data , y axis data, x axis labels, y axis labels, color and title. To create line graphs, simply use the parameter, type=l.
			c) If you want a boxplot, you can use the word boxplot, and for barplot use the barplot function.
			
		
		