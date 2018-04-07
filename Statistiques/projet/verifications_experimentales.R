# 4.1)
# on ne fait varier qu'un parametre a la fois et les valeurs par defauts des parametres sont :
# theta <- 1000 donc theta[3]
# n0 <- 50 donc n0[2]
# n <- 60 donc n[2]
# m <- 50 donc n[2]
# alpha <- 0.05 donc n[2]
theta<-c(1000,2000,5000,10000,50000,100000)
n0<-c(5,10,50,100,150,250)
n<-c(5,60,100,500,750,1000)
m<-c(5,50,500,1000,10000,10000)
alphas<-c(0.01,0.05,0.1,0.2,0.5,0.8)
proportions<-c(0,0,0,0,0,0) # les proportions d'appartenance aux intervalles de confiance qui vont etre calcules

# on fait varier theta et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(theta)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[2]){
    p<-n0[2]/theta[i]
    T=sum(rbinom(n[2], 1, p))
    intervalle_exact_a<-n0[2]*(1+(((n[2]-T)/(T+1))*qf(alphas[2]/2,2*(n[2]-T),2*(T+1))))
    intervalle_exact_b<-n0[2]*(1+(((n[2]-T+1)/T)*qf(1-(alphas[2]/2),2*(n[2]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[i]) && (theta[i] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[2])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de theta (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(theta)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[2]){
    p<-n0[2]/theta[i]
    moy_emp<-sum(rbinom(n[2], 1, p))/n[2]
    intervalle_asymp_a<-n0[2]/(moy_emp+(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[2])))
    intervalle_asymp_b<-n0[2]/(moy_emp-(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[2])))
    if ((intervalle_exact_a <= theta[i]) && (theta[i] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[2])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de theta (intervalles de confiance asymptotiques) :")
print(proportions)

# on fait varier n0 et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(n0)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[2]){
    p<-n0[i]/theta[3]
    T=sum(rbinom(n[2], 1, p))
    intervalle_exact_a<-n0[i]*(1+(((n[2]-T)/(T+1))*qf(alphas[2]/2,2*(n[2]-T),2*(T+1))))
    intervalle_exact_b<-n0[i]*(1+(((n[2]-T+1)/T)*qf(1-(alphas[2]/2),2*(n[2]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[3]) && (theta[3] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[2])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de n0 (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(n0)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[2]){
    p<-n0[i]/theta[3]
    moy_emp<-sum(rbinom(n[2], 1, p))/n[2]
    intervalle_asymp_a<-n0[i]/(moy_emp+(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[2])))
    intervalle_asymp_b<-n0[i]/(moy_emp-(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[2])))
    if ((intervalle_exact_a <= theta[3]) && (theta[3] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[2])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de n0 (intervalles de confiance asymptotiques) :")
print(proportions)

# on fait varier n et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(n)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[2]){
    p<-n0[2]/theta[3]
    T=sum(rbinom(n[i], 1, p))
    intervalle_exact_a<-n0[2]*(1+(((n[i]-T)/(T+1))*qf(alphas[2]/2,2*(n[i]-T),2*(T+1))))
    intervalle_exact_b<-n0[2]*(1+(((n[i]-T+1)/T)*qf(1-(alphas[2]/2),2*(n[i]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[3]) && (theta[3] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[2])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de n (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(n)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[2]){
    p<-n0[2]/theta[3]
    moy_emp<-sum(rbinom(n[i], 1, p))/n[i]
    intervalle_asymp_a<-n0[2]/(moy_emp+(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[i])))
    intervalle_asymp_b<-n0[2]/(moy_emp-(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[i])))
    if ((intervalle_exact_a <= theta[3]) && (theta[3] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[2])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de n (intervalles de confiance asymptotiques) :")
print(proportions)

# on fait varier m et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(n0)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[i]){
    p<-n0[2]/theta[3]
    T=sum(rbinom(n[2], 1, p))
    intervalle_exact_a<-n0[2]*(1+(((n[2]-T)/(T+1))*qf(alphas[2]/2,2*(n[2]-T),2*(T+1))))
    intervalle_exact_b<-n0[2]*(1+(((n[2]-T+1)/T)*qf(1-(alphas[2]/2),2*(n[2]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[3]) && (theta[3] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[i])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de m (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(m)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[i]){
    p<-n0[2]/theta[3]
    moy_emp<-sum(rbinom(n[2], 1, p))/n[2]
    intervalle_asymp_a<-n0[2]/(moy_emp+(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[2])))
    intervalle_asymp_b<-n0[2]/(moy_emp-(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[2])))
    if ((intervalle_exact_a <= theta[3]) && (theta[3] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[i])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de m (intervalles de confiance asymptotiques) :")
print(proportions)

# on fait varier alpha et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(alphas)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[2]){
    p<-n0[2]/theta[3]
    T=sum(rbinom(n[2], 1, p))
    intervalle_exact_a<-n0[2]*(1+(((n[2]-T)/(T+1))*qf(alphas[i]/2,2*(n[2]-T),2*(T+1))))
    intervalle_exact_b<-n0[2]*(1+(((n[2]-T+1)/T)*qf(1-(alphas[i]/2),2*(n[2]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[3]) && (theta[3] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[2])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de alpha (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(alphas)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[2]){
    p<-n0[2]/theta[3]
    moy_emp<-sum(rbinom(n[2], 1, p))/n[2]
    intervalle_asymp_a<-n0[2]/(moy_emp+(qnorm(1-alphas[i]/2)*sqrt(moy_emp*(1-moy_emp)/n[2])))
    intervalle_asymp_b<-n0[2]/(moy_emp-(qnorm(1-alphas[i]/2)*sqrt(moy_emp*(1-moy_emp)/n[2])))
    if ((intervalle_exact_a <= theta[3]) && (theta[3] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[2])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de alpha (intervalles de confiance asymptotiques) :")
print(proportions)

# 4.2)
m<-100
n0<-50
theta<-1000
p<-n0/theta
n<-c(5,10,100,1000,10000,100000)
epsilon<-0.01
proportions<-c(0,0,0,0,0,0)
for (i in 1:length(n)){
  esperance<-p
  cpt<-0  # compte le nombre de fois ou l'ecart entre l'esperance et la moyenne empirique est respectee
  for (j in 1:m){
    moy_emp<-sum(rbinom(n[i], 1, p))/n[i]
      if (abs(moy_emp-esperance) <= epsilon){
      cpt<-cpt+1
    }
  }
  proportions[i]<-(cpt/m)*100
}
print("valeur de n :")
print(n)
print("proportions (en pourcentage) en fonction de n :")
print(proportions)

# 4.3)
  