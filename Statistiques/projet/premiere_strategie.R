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
print(moy_emp)
print(moy_theo)
print(var_emp)
print(var_theo)
t=sum(simu_binom)
print(t)

