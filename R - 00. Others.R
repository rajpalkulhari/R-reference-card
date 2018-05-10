“Analytics” can be defined as the science of extracting insights from raw data. The spectrum of analytics starts from capturing data and evolves into using insights / trends from this data to make informed decisions.


In classification problems, we use two types of algorithms (dependent on the kind of output it creates):

A. 		Class output : Algorithms like SVM and KNN create a class output. For instance, in a binary classification problem, the outputs will 		be either 0 or 1. However, today we have algorithms which can convert these class outputs to probability. But these algorithms are not 			well accepted by the statistics community.
B. 		Probability output : Algorithms like Logistic Regression, Random Forest, Gradient Boosting, Adaboost etc. give probability outputs. 		Converting probability outputs to class output is just a matter of creating a threshold probability.


Distance calculation between different variables:
			http://www.ise.bgu.ac.il/faculty/liorr/hbchap15.pdf
		
		
Distance Measures for Binary Attributes:
	The distance measure described in the last section may be easily computed
	for continuous-valued attributes. In the case of instances described by categorical,
	binary, ordinal or mixed type attributes, the distance measure should be
	revised.
	In the case of binary attributes, the distance between objects may be calculated
	based on a contingency table. A binary attribute is symmetric if both of its
	states are equally valuable. In that case, using the simple matching coefficient
	can assess dissimilarity between two objects:
	d(xi, xj ) = (r + s)/(q + r + s + t)
	where q is the number of attributes that equal 1 for both objects; t is the number
	of attributes that equal 0 for both objects; and s and r are the number of
	attributes that are unequal for both objects.
	A binary attribute is asymmetric, if its states are not equally important (usually
	the positive outcome is considered more important). In this case, the denominator
	ignores the unimportant negative matches (t). This is called the
	Jaccard coefficient:
	d(xi, xj ) = (r + s)/(q + r + s)
	
Distance Measures for Nominal Attributes:
		When the attributes are nominal, two main approaches may be used:
	1. Simple matching:
	d(xi, xj ) = (p − m)/p
	where p is the total number of attributes and m is the number of matches.
	2. Creating a binary attribute for each state of each nominal attribute and
	computing their dissimilarity as described above.

Distance Metrics for Ordinal Attributes:
		When the attributes are ordinal, the sequence of the values is meaningful.
		In such cases, the attributes can be treated as numeric ones after mapping their
		range onto [0,1]. Such mapping may be carried out as follows:
		zi,n =(ri,n − 1)/(Mn − 1)
		where zi,n is the standardized value of attribute an of object i. ri,n is that value
		before standardization, and Mn is the upper limit of the domain of attribute an
		(assuming the lower limit is 1).

		
Association Rule Mining:
		