# 1.1)

teta<-1000
n0<-50
n<-60 # valeur arbitraire
p<-n0/teta
simu_binom<-rbinom(n, 1, p)
moy_emp<-sum(simu_binom)/n
var_emp<-sum((simu_binom-moy_emp)^2)/n
moy_theo<-p
var_theo<-(1-p)*p
print("moyenne empirique :")
print(moy_emp)
print("moyenne théorique :")
print(moy_theo)
print("variance empirique :")
print(var_emp)
print("variance empirique :")
print(var_theo)
print("nombre de poissons bagués parmi les n poissons pêchés :")
t=sum(simu_binom)
print(t)
estim_mom<-sum(simu_binom)/n
estim_vrai<-sum(simu_binom)/n
print("estimateur des moments :")
print(estim_mom)
print("estimateur de maximum de vraisemblance :")
print(estim_vrai)