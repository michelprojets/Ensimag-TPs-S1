donnees<-c(91.6, 35.7, 251.3, 24.3, 5.4, 67.3, 170.9, 9.5, 118.4, 57.1)
sort(donnees)
n<-10
moy<-sum(donnees)/n
estim_vrai<-1/moy
estim_opti<-(n-1)/sum(donnees)
alphas<-c(0.5, 0.1, 0.5, 0.1)

intervalles<-matrix(nrow=4, ncol=6)
for (i in 1:4){
    intervalles[i,1]=qchisq(alphas[i]/2, 2*n)/(2*n*moy)
    intervalles[i,2]=qchisq(1-(alphas[i]/2), 2*n)/(2*n*moy)
    intervalles[i,3]=0
    intervalles[i,4]=qchisq(1-alphas[i], 2*n)/(2*n*moy)
    intervalles[i,5]=qchisq(alphas[i], 2*n)/(2*n*moy)
    intervalles[i,6]=Inf
}

m<-5  # faire varier le nombre d'échantillon m
taille<-20  # faire varier la taille de l'échantillon taille
pourcentages<-seq(1:m)
for (i in 1:m){
    cpt<-0
    realisations<-rexp(taille)
    for (j in 1:taille){
        # faire varier la ligne de intervalles pour faire varier alpha
        if (intervalles[1,1]<=realisations[j] && realisations[j]<=intervalles[1,2]){
            cpt<-cpt+1
        }
    }
    pourcentages[i]=(cpt/taille)*100
}
pourcentage_moy<-sum(pourcentages)/m