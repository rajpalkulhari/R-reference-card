Subsetting in Data Frame:
	new<-subset(t_n,Team=="Team1" |Team=="Team2" |Team=="Team3",select=c(teamId))
	new<-which(t_n$Team=="Team1")

1. number of interrelated concepts:
	a)The three subsetting operators.
	b)The six types of subsetting.
	c)Important differences in behaviour for different objects (e.g., vectors, lists, factors, matrices, and data frames).
	d)The use of subsetting in conjunction with assignment.
	
2. This chapter helps you master subsetting by starting with the simplest type of subsetting: subsetting an atomic vector with [. It then gradually extends your knowledge, first to more complicated data types (like arrays and lists), and then to the other subsetting operators, [[ and $

3. Subsetting is a natural complement to str(). str() shows you the structure of any object, and subsetting allows you to pull out the pieces that you’re interested in.

Data types:
	A) Atomic vectors:
		There are five things that you can use to subset a vector:
		x <- c(2.1, 4.2, 3.3, 5.4)
		1. Positive integers return elements at the specified positions:
			x[c(3, 1)]
			# Real numbers are silently truncated to integers
			x[c(2.1, 2.9)]
			#> [1] 4.2 4.2
			
		2. Negative integers omit elements at the specified positions:
			x[-c(3, 1)]
		3. Logical vectors select elements where the corresponding logical value is TRUE
			x[c(TRUE, TRUE, FALSE, FALSE)]
			#> [1] 2.1 4.2
			x[x > 3]
			#> [1] 4.2 3.3 5.4
		If the logical vector is shorter than the vector being subsetted, it will be recycled to be the same length.
			x[c(TRUE, FALSE)]
			#> [1] 2.1 3.3
			# Equivalent to
			x[c(TRUE, FALSE, TRUE, FALSE)]
			#> [1] 2.1 3.3	
			
		4. Nothing returns the original vector.
			x[]
			#> [1] 2.1 4.2 3.3 5.4
			
		5. Zero returns a zero-length vector. This is not something you usually do on purpose, but it can be helpful for generating test data.
			x[0]
			#> numeric(0)
			
		If the vector is named, you can also use:
		6. Character vectors to return elements with matching names.
			(y <- setNames(x, letters[1:4]))
			#>   a   b   c   d 
			#> 2.1 4.2 3.3 5.4
			y[c("d", "c", "a")]
			#>   d   c   a 
			#> 5.4 3.3 2.1

			# Like integer indices, you can repeat indices
			y[c("a", "a", "a")]
			#>   a   a   a 
			#> 2.1 2.1 2.1

			# When subsetting with [ names are always matched exactly
			z <- c(abc = 1, def = 2)
			z[c("a", "d")]
			#> <NA> <NA> 
			#>   NA   NA
			
	B) Lists:
		Subsetting a list works in the same way as subsetting an atomic vector. Using [ will always return a list; [[ and $, as described below, let you pull out the components of the list.
		
		
	C) Matrices and arrays:
		You can subset higher-dimensional structures in three ways:
			With multiple vectors.
			With a single vector.
			With a matrix.
		1. The most common way of subsetting matrices (2d) and arrays (>2d) is a simple generalisation of 1d subsetting: you supply a 1d index for each dimension, separated by a comma. Blank subsetting is now useful because it lets you keep all rows or all columns.
		
	D) Data frames:
		Data frames possess the characteristics of both lists and matrices: if you subset with a single vector, they behave like lists; if you subset with two vectors, they behave like matrices.
		
	E) S3 objects
	F) S4 objects

Subsetting operators:
	1. There are two other subsetting operators: [[ and $. [[ is similar to [, except it can only return a single value and it allows you to pull pieces out of a list. $ is a useful shorthand for [[ combined with character subsetting.

	2. You need [[ when working with lists. This is because when [ is applied to a list it always returns a list: it never gives you the contents of the list. To get the contents, you need [[:
	
	3. Because data frames are lists of columns, you can use [[ to extract a column from data frames: mtcars[[1]], mtcars[["cyl"]].
	
Simplifying vs. preserving subsetting:
	1. It’s important to understand the distinction between simplifying and preserving subsetting. Simplifying subsets returns the simplest possible data structure that can represent the output, and is useful interactively because it usually gives you what you want. Preserving subsetting keeps the structure of the output the same as the input, and is generally better for programming because the result will always be the same type. Omitting drop = FALSE when subsetting matrices and data frames is one of the most common sources of programming errors. (It will work for your test cases, but then someone will pass in a single column data frame and it will fail in an unexpected and unclear way.)
	
	2. Unfortunately, how you switch between simplifying and preserving differs for different data types, as summarised in the table below.

						Simplifying					Preserving
		Vector				x[[1]]						x[1]
		List				x[[1]]						x[1]
		Factor				x[1:4, drop = T]			x[1:4]
		Array				x[1, ] or x[, 1]			x[1, , drop = F] or x[, 1, drop = F]
		Data frame			x[, 1] or x[[1]]			x[, 1, drop = F] or x[1]
	
	
$:
		1. $ is a shorthand operator, where x$y is equivalent to x[["y", exact = FALSE]]. It’s often used to access variables in a data frame, as in mtcars$cyl or diamonds$carat.

		2. One common mistake with $ is to try and use it when you have the name of a column stored in a variable:
			var <- "cyl"
			# Doesn't work - mtcars$var translated to mtcars[["var"]]
			mtcars$var
			#> NULL

			# Instead use [[
			mtcars[[var]]
			#>  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
		
		3. There’s one important difference between $ and [[. $ does partial matching:
			x <- list(abc = 1)
			x$a
			#> [1] 1
			x[["a"]]
			#> NULL
		
subset() is a specialised shorthand function for subsetting data frames, and saves some typing because you don’t need to repeat the name of the data frame. 

Which:
	which() allows you to convert a boolean representation to an integer representation. 
		x <- sample(10) < 4
		which(x)
		#> [1]  3  7 10
		