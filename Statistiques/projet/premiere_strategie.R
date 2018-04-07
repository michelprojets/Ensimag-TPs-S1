# 1.1)
theta<-1000
n0<-50
n<-60 # valeur arbitraire
p<-n0/theta
# simu_binom<-rbinom(n, 1, p) # pour recuperer un echantillon
simu_binom<-c(0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
print("echantillon :")
print(simu_binom)
moy_emp<-sum(simu_binom)/n
var_emp<-sum((simu_binom-moy_emp)^2)/n
moy_theo<-p
var_theo<-(1-p)*p
print("moyenne empirique :")
print(moy_emp)
print("moyenne theorique :")
print(moy_theo)
print("variance empirique :")
print(var_emp)
print("variance empirique :")
print(var_theo)

# 1.2)
t=sum(simu_binom)
print("nombre de poissons bagues parmi les n poissons pêches :")
print(t)

# 1.3)
estim_mom<-(n0*n)/sum(simu_binom)
estim_vrai<-(n0*n)/sum(simu_binom)
print("estimateur des moments :")
print(estim_mom)
print("estimateur de maximum de vraisemblance :")
print(estim_vrai)

# 1.4)
T=sum(simu_binom)
alphas<-c(0.01, 0.05, 0.1, 0.2)
intervalles_exact<-matrix(nrow=4, ncol=2) # un intervalle par colonne
for (i in 1:4){
  intervalles_exact[i,1]<-n0*(1+(((n-T)/(T+1))*qf(alphas[i]/2,2*(n-T),2*(T+1))))
  intervalles_exact[i,2]<-n0*(1+(((n-T+1)/T)*qf(1-(alphas[i]/2),2*(n-T+1),2*T)))
  print("intervalle de confiance exact pour theta de seuil :")
  print(alphas[i])
  print(intervalles_exact[i,1])
  print(intervalles_exact[i,2])
}
intervalles_asymp<-matrix(nrow=4, ncol=2) # un intervalle par colonne
for (i in 1:4){
  intervalles_asymp[i,1]<-n0/(moy_emp+(qnorm(1-alphas[i]/2)*sqrt(moy_emp*(1-moy_emp)/n)))
  intervalles_asymp[i,2]<-n0/(moy_emp-(qnorm(1-alphas[i]/2)*sqrt(moy_emp*(1-moy_emp)/n)))
  print("intervalle de confiance asymptotique pour theta de seuil :")
  print(alphas[i])
  print(intervalles_asymp[i,1])
  print(intervalles_asymp[i,2])
}

# 1.5)
proba_esti_inf<-(1-(n0/theta))^n
print("probabilite que l'estimateur vale +infini :")
print(proba_esti_inf)

# 1.6)
n_min=floor(-(log(2)/(log(1-(n0/theta)))))  # on prend la partie entière
print("pour que la probalilite que l'estimateur vale +infini soit strictement superieure à 1/2, n doit être inferieur à :")
print(n_min)
proba_esti_inf_n_min<-(1-(n0/theta))^n_min
print("probabilite que l'estimateur vale +infini avec cette valeur de n :")
print(proba_esti_inf_n_min)