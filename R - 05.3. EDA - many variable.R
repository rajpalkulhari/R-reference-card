1. ggplot(aes(x=gender,y=age),data=pf)+geom_line(aes(color=gender),stat=summary,fun.y=median)

2. library(reshape2) - for reshape data wide-long

3. 