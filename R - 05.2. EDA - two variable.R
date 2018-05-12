1. for two continoues variable we create scatter plot

2. qplot(x=age,y=friends_count,data=df) -> creates scatter plot -> ggplot() is another function like qplot but with different paramters

3. ggplot(aes(x=age,y=friends_count),data=df)+geom_point()  -> same as above command

4. ggplot(aes(x=age,y=friends_count),data=df)+geom_point()+xlim(13,90)

5. overplotted graph -> when we have two many points upon each other. to overcome this we use tranperancy using alpha in geomm paramter:
	ggplot(aes(x=age,y=friends_count),data=df)+geom_point(alpha = 1/20)+xlim(13,90) -> now 20 points represent one black point in graph
	
6. geomm_jitter() -> to disparse out our data

7. ggplot(aes(x=age,y=friends_count),data=df)+geom_point(alpha = 1/20)+xlim(13,90)+coord_trans(y=sqrt) -> for transfomation on y axis 

8. dplyr package:- to run funtion on subset of data
	a. filter()
	b. group_by()
	c. mutate()
	d. arrange()
	
9. Conditional mean relationship
	library(dplyr)
	age_groups <- group_by(pf,age)
	pf.fc_by_age <- summarise(age_groups,friends_count_mean=mean(friends_count),friends_count_median=median(friends_count),n=n())
	pf.fc_by_age <- arrange(pf.fc_by_age,age)
	ggplot(aes(x=age,y=friends_count_mean),data=pf.fc_by_age)+geom_line() -> for line plot
	
10. ggplot(aes(x=age,y=friends_count),data=df)+geom_point(alpha = 1/20,position=position_jitter(h=0),color='orange')+xlim(13,90)+coord_trans(y=sqrt)+geom_line(stat='summary',fun.y=mean) -> will draw a line on plot according to y axis 

11. ggplot(aes(x=age,y=friends_count),data=df)+geom_point(alpha = 1/20,position=position_jitter(h=0),color='orange')+xlim(13,90)+coord_trans(y=sqrt)+geom_line(stat='summary',fun.y=mean)+geom_line(stat='summary',fun.y=quantile,prob=.1,linetype=2,color='blue')

12. corelation between two variables:
	cor.test(df$age,df$friends_count,method='pearson')  
	OR
	with(df,cor.test(age,friends_count,method='pearson'))  -> ( r<=.3 then not good corelation, if r<=.5 then moderate and if r>=.7 then highly corelated - also same in negative)
	
13. corelation on subset data
	with(subset(df,age<=70),cor.test(age,friends_count,method='pearson'))
	
14. Non linear or monotonic relationship between two variables:
	with(subset(df,age<=70),cor.test(age,friends_count,method='spearman'))
	
15. taking only 95% of the data for graph (to remove outliers):
	ggplot(aes(x=age,y=friends_count),data=df)+geom_point()+xlim(0,quantile(pf$age,0.95))+ylim(0,quantile(pf$friends_count,0.95))
	
16. ggplot(aes(x=age,y=friends_count),data=df)+geom_point()+xlim(0,quantile(pf$age,0.95))+ylim(0,quantile(pf$friends_count,0.95))+geomm_smooth(method='lm',color='red')  -> to show the corelation line by lm (linear regrssion)

17. 