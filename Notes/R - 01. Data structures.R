Google`s R videos : https://www.youtube.com/playlist?list=PLOU2XLYxmsIK9qQfztXeybpHvru-TrqAP
http://adv-r.had.co.nz/Data-structures.html 

Data types:
	"logical", "character", "numeric", "integer"

Data Types (these all are objects (everything in R is objects) )
	1. vectors (v<-c(1,2)) (could be numerical or character)
	2. sequence (s<-seq(1:6))
	3. list (l<-list(v1,v2))
	4. Data Frame (df<-data.frame(can give vectors))
	5. matrix (m<-matrix(data,nrow,ncol,byrow))   - (also have array)
	-> List can contain elements of different types where in vectors (atomic vectors) all elements must be of the same time
	-> Lists are vectors, and the basic vector types are referred to as atomic vectors where it is necessary to exclude lists.


R’s base data structures can be organised by their dimensionality (1d, 2d, or nd) and whether they’re homogeneous (all contents must be of the same type) or heterogeneous (the contents can be of different types). This gives rise to the five data types most often used in data analysis:

	Homogeneous				Heterogeneous
1d)	Atomic vector				List
2d)	Matrix						Data frame
nd)	Array

 Note that R has no 0-dimensional, or scalar types. Individual numbers or strings, which you might think would be scalars, are actually vectors of length one.

Quiz:
	1)What are the three properties of a vector, other than its contents?
	ans) The three properties of a vector are type, length, and attributes.
	
	2)What are the four common types of atomic vectors? What are the two rare types?
	a)The four common types of atomic vector are logical, integer, double (sometimes called numeric), and character. The two rarer types are complex and raw.
	
	3)How is a list different from an atomic vector? How is a matrix different from a data frame?
	a)The elements of a list can be any type (even a list); the elements of an atomic vector are all of the same type. Similarly, every element of a matrix must be the same type; in a data frame, the different columns can have different types.
	
Vectors:
	1. Vectors come in two flavours: atomic vectors and lists.
	2. is.vector() does not test if an object is a vector. Instead it returns TRUE only if the object is a vector with no attributes apart from names. Use is.atomic(x) || is.list(x) to test if an object is actually a vector.
	3. Atomic vectors are usually created with c(), short for combine:
	4. Atomic vectors are always flat, even if you nest c()’s:
	   ex:
		c(1, c(2, c(3, 4)))
		#> [1] 1 2 3 4
		# the same as
		c(1, 2, 3, 4)
		#> [1] 1 2 3 4
	5.Missing values are specified with NA, which is a logical vector of length 1. NA will always be coerced to the correct type if used inside c(), or you can create NAs of a specific type with NA_real_ (a double vector), NA_integer_ and NA_character_.
	6. Given a vector, you can determine its type with typeof(), or check if it’s a specific type with an “is” function: is.character(), is.double(), is.integer(), is.logical(), or, more generally, is.atomic().
	7. NB: is.numeric() is a general test for the “numberliness” of a vector and returns TRUE for both integer and double vectors. It is not a specific test for double vectors, which are often called numeric.
	8. All elements of an atomic vector must be the same type, so when you attempt to combine different types they will be coerced to the most flexible type. Types from least to most flexible are: logical, integer, double, and character.

	For example, combining a character and an integer yields a character:
	str(c("a", 1))
	#>  chr [1:2] "a" "1"
	
List:
	1. Lists are different from atomic vectors because their elements can be of any type, including lists. You construct lists by using list() instead of c():
		x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
		str(x)
		#> List of 4
		#>  $ : int [1:3] 1 2 3
		#>  $ : chr "a"
		#>  $ : logi [1:3] TRUE FALSE TRUE
		#>  $ : num [1:2] 2.3 5.9
	
	2.Lists are sometimes called recursive vectors, because a list can contain other lists. This makes them fundamentally different from atomic vectors.
	
	3. c() will combine several lists into one. If given a combination of atomic vectors and lists, c() will coerce the vectors to lists before combining them. Compare the results of list() and c():
		x <- list(list(1, 2), c(3, 4))
		y <- c(list(1, 2), c(3, 4))
		str(x)
		#> List of 2
		#>  $ :List of 2
		#>   ..$ : num 1
		#>   ..$ : num 2
		#>  $ : num [1:2] 3 4
		str(y)
		#> List of 4
		#>  $ : num 1
		#>  $ : num 2
		#>  $ : num 3
		#>  $ : num 4
	
	4. The typeof() a list is list. You can test for a list with is.list() and coerce to a list with as.list(). You can turn a list into an atomic vector with unlist(). If the elements of a list have different types, unlist() uses the same coercion rules as c().
	
Attributes:
	1.All objects can have arbitrary additional attributes, used to store metadata about the object. Attributes can be thought of as a named list (with unique names). Attributes can be accessed individually with attr() or all at once (as a list) with attributes().
	2.Each of these attributes has a specific accessor function to get and set values. When working with these attributes, use names(x), dim(x), and class(x), not attr(x, "names"), attr(x, "dim"), and attr(x, "class").

Names:
	1. You can name a vector in three ways:

		When creating it: x <- c(a = 1, b = 2, c = 3).
		By modifying an existing vector in place: x <- 1:3; names(x) <- c("a", "b", "c").
		By creating a modified copy of a vector: x <- setNames(1:3, c("a", "b", "c")).
	2. Names don’t have to be unique. However, character subsetting, described in subsetting, is the most important reason to use names and it is most useful when the names are unique.
	3. Not all elements of a vector need to have a name. If some names are missing, names() will return an empty string for those elements. If all names are missing, names() will return NULL.
	
Factors:
	1.  A factor is a vector that can contain only predefined values, and is used to store categorical data. Factors are built on top of integer vectors using two attributes: the class(), “factor”, which makes them behave differently from regular integer vectors, and the levels(), which defines the set of allowed values.
	2. Factors are useful when you know the possible values a variable may take, even if you don’t see all values in a given dataset
	3. Sometimes when a data frame is read directly from a file, a column you’d thought would produce a numeric vector instead produces a factor. This is caused by a non-numeric value in the column, often a missing value encoded in a special way like . or -. To remedy the situation, coerce the vector from a factor to a character vector, and then from a character to a double vector. (Be sure to check for missing values after this process.) Of course, a much better plan is to discover what caused the problem in the first place and fix that; using the na.strings argument to read.csv() is often a good place to start.
	
	4. Unfortunately, most data loading functions in R automatically convert character vectors to factors. This is suboptimal, because there’s no way for those functions to know the set of all possible levels or their optimal order. Instead, use the argument stringsAsFactors = FALSE to suppress this behaviour, and then manually convert character vectors to factors using your knowledge of the data. A global option, options(stringsAsFactors = FALSE), is available to control this behaviour, but I don’t recommend using it. Changing a global option may have unexpected consequences when combined with other code (either from packages, or code that you’re source()ing), and global options make code harder to understand because they increase the number of lines you need to read to understand how a single line of code will behave.
	
	5.While factors look (and often behave) like character vectors, they are actually integers. Be careful when treating them like strings. Some string methods (like gsub() and grepl()) will coerce factors to strings, while others (like nchar()) will throw an error, and still others (like c()) will use the underlying integer values. For this reason, it’s usually best to explicitly convert factors to character vectors if you need string-like behaviour. In early versions of R, there was a memory advantage to using factors instead of character vectors, but this is no longer the case.
	
Matrices and arrays:
	1. Adding a dim() attribute to an atomic vector allows it to behave like a multi-dimensional array. A special case of the array is the matrix, which has two dimensions.
	
	2. Matrices and arrays are created with matrix() and array(), or by using the assignment form of dim():
	
		# Two scalar arguments to specify rows and columns
		a <- matrix(1:6, ncol = 3, nrow = 2)
		# One vector argument to describe all dimensions
		b <- array(1:12, c(2, 3, 2))

		# You can also modify an object in place by setting dim()
		c <- 1:6
		dim(c) <- c(3, 2)
		c
		#>      [,1] [,2]
		#> [1,]    1    4
		#> [2,]    2    5
		#> [3,]    3    6
		dim(c) <- c(2, 3)
		c
		#>      [,1] [,2] [,3]
		#> [1,]    1    3    5
		#> [2,]    2    4    6
	
	3. length() and names() have high-dimensional generalisations:
		length() generalises to nrow() and ncol() for matrices, and dim() for arrays.
		names() generalises to rownames() and colnames() for matrices, and dimnames(), a list of character vectors, for arrays.
		
	4. While atomic vectors are most commonly turned into matrices, the dimension attribute can also be set on lists to make list-matrices or list-arrays:
		l <- list(1:3, "a", TRUE, 1.0)
		dim(l) <- c(2, 2)
		l
		#>      [,1]      [,2]
		#> [1,] Integer,3 TRUE
		#> [2,] "a"       1
		
Data frames:
	1.Under the hood, a data frame is a list of equal-length vectors. This makes it a 2-dimensional structure, so it shares properties of both the matrix and the list. This means that a data frame has names(), colnames(), and rownames(), although names() and colnames() are the same thing. The length() of a data frame is the length of the underlying list and so is the same as ncol(); nrow() gives the number of rows.
	
	2.Creation: You create a data frame using data.frame(), which takes named vectors as input:
		df <- data.frame(x = 1:3, y = c("a", "b", "c"))
		str(df)
		#> 'data.frame':    3 obs. of  2 variables:
		#>  $ x: int  1 2 3
		#>  $ y: Factor w/ 3 levels "a","b","c": 1 2 3
	
	3. Beware data.frame()’s default behaviour which turns strings into factors. Use stringAsFactors = FALSE to suppress this behaviour:
	
	4. Combining data frames:
		You can combine data frames using cbind() and rbind():
	5. It’s a common mistake to try and create a data frame by cbind()ing vectors together. This doesn’t work because cbind() will create a matrix unless one of the arguments is already a data frame. Instead use data.frame() directly:
	
	6. Special columns
	Since a data frame is a list of vectors, it is possible for a data frame to have a column that is a list:
		df <- data.frame(x = 1:3)
		df$y <- list(1:2, 1:3, 1:4)
		df
		#>   x          y
		#> 1 1       1, 2
		#> 2 2    1, 2, 3
		#> 3 3 1, 2, 3, 4
	
	