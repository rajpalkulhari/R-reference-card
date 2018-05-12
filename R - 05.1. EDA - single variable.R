Histograms (are used for univariate numerical data):
	1. qplot(x=friend_count,data=pf,xlim=c(0,1000)) - xlim is to limit data in x axes from 0 to 1000

	2. qplot(x=friend_count,data=pf)+scale_x_continuous((limits=c(0,1000))) - scale_x_continuous to limit data in x axes from 0 to 1000

	3. qplot(x=friend_count,data=pf,binwidth=25)+scale_x_continuous((limits=c(0,1000)),breaks=seq(0,1000,50)) - here binwidth is for width of bin and breaks is to break points on x axes by 50 (0,50,100....)
	
	4. qplot(x=friend_count,data=pf,binwidth=25)+scale_x_continuous((limits=c(0,1000)),breaks=seq(0,1000,50))+facet_wrap(~gender) - Here we are adding more layers in our plot and facet_wrap will devide our histogrames into number of gender (formula)/categorical variable

	5. qplot(x=friend_count,data=subset(pf,!is.na(gender)),binwidth=25)+scale_x_continuous((limits=c(0,1000)),breaks=seq(0,1000,50))+facet_wrap(~gender)  
	
				OR
		qplot(x=friend_count,data=na.omit(pf),binwidth=25)+scale_x_continuous((limits=c(0,1000)),breaks=seq(0,1000,50))+facet_wrap(~gender)   -> Both these will remove na from data
		
	6. qplot(x=friend_count,data=pf,color=I('black'),fill=I('#99908'))
	
	7. qplot(x=friend_count,data=pf,xlab="x",ylab="y",color=I('black'),fill=I('#99908'))+scale_x_continuous((limits=c(0,1000)),breaks=seq(0,1000,50))
	
	8. gridExtra -> package for multiple histogrames in one screen
		p1<-qplot(x=friend_count,data=pf)
		p2<-qplot(x=log10(friend_count+1),data=pf)
		p3<-qplot(x=sqrt(friend_count),data=pf)
		grid.arrange(p1,p2,p3,ncol=1) - x axis count will change as per log/sqrt
		OR
		p1<- ggplot(aes(x=friend_count),data=pf)+geom_histograms
		p2<-p1 + scale_x_log10()
		p3<-p1 + scale_x_sqrt()
		grid.arrange(p1,p2,p3,ncol=1)  - x axis count would be actual friend_count
		
	frequency polygons:
	9. qplot(x=friend_count,y= ..count/sum(..count..),data=subset(pf,!is.na(gender)),binwidth=25,geom='freqpoly',color=gender)+scale_x_continuous((limits=c(0,1000)),breaks=seq(0,1000,50))
	
	Box Plots:
	10. qplot(x=gender,y=friend_count,data = subset(pf,!is.na(gender)),geom='boxplot') - generats box plot
	
	11. qplot(x=gender,y=friend_count,data = subset(pf,!is.na(gender)),geom='boxplot',ylim=c(0,1000)) -> cutting point above 1000 for friend_count
	
	12. qplot(x=gender,y=friend_count,data = subset(pf,!is.na(gender)),geom='boxplot')+scale_x_continuous(limits=c(0,1000)) - same as above
	
	13. qplot(x=gender,y=friend_count,data = subset(pf,!is.na(gender)),geom='boxplot')+coord_cartesian(ylim=c(0,1000)) -> here coord_cartesian does not cut the points above 1000 but will show only upto 1000 in graph (means points above 1000 are used to calculate median and quatiles but not shown on the plot)
	
	