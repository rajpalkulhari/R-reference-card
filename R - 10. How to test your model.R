http://www.win-vector.com/blog/2015/09/willyourmodelworkpart1/
http://winvector.github.io/KDD2009/KDD2009vtreat.html
http://winvector.github.io/KDD2009/

Part 1: Defining the scoring problem
	Choice of utility metric
	
Part 2: In-training set measures
	The most tempting procedure is to score your model on the data used to train it. The attraction is this avoids the statistical inefficiency of denying some of your data to the training procedure
	
	A common way to asses score quality is to run your scoring function on the data used to build your model. We might try comparing several models scored by AUC or deviance (normalized to factor out sample size) on their own training data
	
	What we have done is take five popular machine learning techniques (random forest, logistic regression, gbm, GAM logistic regression, and elastic net logistic regression) and plotted their performance in terms of AUC and normalized deviance on their own training data. For AUC larger numbers are better, and for deviance smaller numbers are better. Because we have evaluated multiple models we are starting to get a sense of scale. We should suspect an AUC of 0.7 on training data is good (though random forest achieved an AUC on training of almost 1.0), and we should be acutely aware that evaluating models on their own training data has an upward bias (the model has seen the training data, so it has a good chance of doing well on it; or training data is not exchangeable with future data for the purpose of estimating model performance).
	
	There are two more Gedankenexperiment models that any machine data scientist should always have in mind:

	a) The null model (on the graph as “null model”). This is the performance of the best constant model (model that returns the same answer for all datums). In this case it is a model scores each and every row as having an identical 7% chance of churning. This is an important model that you want to better than. It is also a model you are often competing against as a data science as it is the “what if we treat everything in this group the same” option (often the business process you are trying to replace).
	The data scientist should always compare their work to the null model on deviance (null model AUC is trivially 0.5) and packages like logistic regression routinely report this statistic.

	b) The best single variable model (on the graph as “best single variable model”). This is the best model built using only one variable or column (in this case using a GAM logistic regression as the modeling method). This is another model the data scientist wants to out perform as it represents the “maybe one of the columns is already the answer case” (if so that would be very good for the business as they could get good predictions without modeling infrastructure).
	The data scientist should definitely compare their model to the best single variable model. Until you significantly outperform the best single variable model you have not outperformed what an analyst can find with a single pivot table.
	
	“Score once on training data” has started to show us things. 
	
	
Part 3: Out of sample procedures
	Let’s try working “out of sample” or with data not seen during training or construction of our model. The attraction of these procedures is they represent a principled attempt at simulating the arrival of new data in the future.
	Hold out tests are a staple for data scientists. You reserve a fraction of your data (say 10%) for evaluation and don’t use that data in any way during model construction and calibration
Part 4: Cross-validation techniques:
	http://www.r-bloggers.com/how-do-you-know-if-your-model-is-going-to-work-part-4-cross-validation-techniques/ 