diet <- read.csv("/Users/Jyanqa/Desktop/z_Assignment 4/dietary.csv",sep =';')
sectors <- read.csv("/Users/Jyanqa/Desktop/z_Assignment 4/sectors.csv",sep =';')
df1 <- subset(diet, select = -c(Country))
df2 <- subset(sectors, select = -c(Country))
install.packages("CCA")
library(lme4)
library(CCA) 
install.packages('CCP')
library(CCP) 

#checking the between and within set associations
cormat<-matcor(df1,df2)
round(cormat$Ycor, 2)
round(cormat$Xcor, 2)
round(cormat$XYcor, 2)
#---------------------------------------------
can_cor1=cc(df1,df2)
can_cor1$cor
can_cor1[3:4]
can_cor2=comput(df1,df2,can_cor1)
can_cor2[3:6] 
#----------

rho=can_cor1$cor
n=dim(df1)[1]
p=length(df1)
q=length(df2)
p.asym(rho,n,p,q,tstat="Wilks")



