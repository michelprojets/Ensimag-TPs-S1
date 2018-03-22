donnees<-c(91.6, 35.7, 251.3, 24.3, 5.4, 67.3, 170.9, 9.5, 118.4, 57.1)
sort(donnees)
n<-10
moy<-sum(donnees)/n
estim_vrai<-1/moy
estim_opti<-(n-1)/sum(donnees)
alphas<-c(0.5, 0.1, 0.5, 0.1)

intervalles<-matrix(c(0, 0, 0, 0, 0, 0), 4, 6)
for (i in 1:4){
    intervalles[i][1]=qchisq(alphas[i]/2, df=2)/(2*n*moy)
    intervalles[i][2]=qchisq(1-(alphas[i]/2), df=2)/(2*n*moy)
    intervalles[i][3]=0
    intervalles[i][4]=qchisq(1-alphas[i], df=2)/(2*n*moy)
    intervalles[i][5]=qchisq(alphas[i], df=2)/(2*n*moy)
    intervalles[i][6]=Inf
}

pexp(x, 10)
rexp(5)