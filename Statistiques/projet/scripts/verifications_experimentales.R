# 4.1)
# on ne fait varier qu'un parametre a la fois et les valeurs par defauts des parametres sont :
# theta <- 1000 donc theta[1]
# n0 <- 100 donc n0[1]
# n <- 100 donc n[1]
# m <- 100 donc n[1]
# alpha <- 0.05 donc n[1]
theta<-c(1000,1200,1400,1600,1800,2000)
n0<-c(100,200,300,400,500,600)
n<-c(100,500,1000,5000,10000,100000)
m<-c(100,200,500,1000,5000,10000)
alphas<-c(0.01,0.05,0.1,0.2,0.5,0.8)
proportions<-c(0,0,0,0,0,0) # les proportions d'appartenance aux intervalles de confiance qui vont etre calcules

# on fait varier theta et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(theta)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[1]){
    p<-n0[1]/theta[i]
    T=sum(rbinom(n[1], 1, p))
    intervalle_exact_a<-n0[1]*(1+(((n[1]-T)/(T+1))*qf(alphas[2]/2,2*(n[1]-T),2*(T+1))))
    intervalle_exact_b<-n0[1]*(1+(((n[1]-T+1)/T)*qf(1-(alphas[2]/2),2*(n[1]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[i]) && (theta[i] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[1])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de theta (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(theta)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[1]){
    p<-n0[1]/theta[i]
    moy_emp<-sum(rbinom(n[1], 1, p))/n[1]
    intervalle_asymp_a<-n0[1]/(moy_emp+(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[1])))
    intervalle_asymp_b<-n0[1]/(moy_emp-(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[1])))
    if ((intervalle_asymp_a <= theta[i]) && (theta[i] <= intervalle_asymp_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[1])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de theta (intervalles de confiance asymptotiques) :")
print(proportions)

# on fait varier n0 et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(n0)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[1]){
    p<-n0[i]/theta[1]
    T=sum(rbinom(n[1], 1, p))
    intervalle_exact_a<-n0[i]*(1+(((n[1]-T)/(T+1))*qf(alphas[2]/2,2*(n[1]-T),2*(T+1))))
    intervalle_exact_b<-n0[i]*(1+(((n[1]-T+1)/T)*qf(1-(alphas[2]/2),2*(n[1]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[1]) && (theta[1] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[1])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de n0 (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(n0)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[1]){
    p<-n0[i]/theta[1]
    moy_emp<-sum(rbinom(n[1], 1, p))/n[1]
    intervalle_asymp_a<-n0[i]/(moy_emp+(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[1])))
    intervalle_asymp_b<-n0[i]/(moy_emp-(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[1])))
    if ((intervalle_asymp_a <= theta[1]) && (theta[1] <= intervalle_asymp_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[1])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de n0 (intervalles de confiance asymptotiques) :")
print(proportions)

# on fait varier n et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(n)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[1]){
    p<-n0[1]/theta[1]
    T=sum(rbinom(n[i], 1, p))
    intervalle_exact_a<-n0[1]*(1+(((n[i]-T)/(T+1))*qf(alphas[2]/2,2*(n[i]-T),2*(T+1))))
    intervalle_exact_b<-n0[1]*(1+(((n[i]-T+1)/T)*qf(1-(alphas[2]/2),2*(n[i]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[1]) && (theta[1] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[1])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de n (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(n)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[1]){
    p<-n0[1]/theta[1]
    moy_emp<-sum(rbinom(n[i], 1, p))/n[i]
    intervalle_asymp_a<-n0[1]/(moy_emp+(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[i])))
    intervalle_asymp_b<-n0[1]/(moy_emp-(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[i])))
    if ((intervalle_asymp_a <= theta[1]) && (theta[1] <= intervalle_asymp_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[1])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de n (intervalles de confiance asymptotiques) :")
print(proportions)

# on fait varier m et on fixe les autres parametres par leur valeur par defaut
for (i in 1:length(n0)){
  # intervalle exact
  cpt<-0
  for (cpt_simu in 1:m[i]){
    p<-n0[1]/theta[1]
    T=sum(rbinom(n[1], 1, p))
    intervalle_exact_a<-n0[1]*(1+(((n[1]-T)/(T+1))*qf(alphas[2]/2,2*(n[1]-T),2*(T+1))))
    intervalle_exact_b<-n0[1]*(1+(((n[1]-T+1)/T)*qf(1-(alphas[2]/2),2*(n[1]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[1]) && (theta[1] <= intervalle_exact_b)){
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
    p<-n0[1]/theta[1]
    moy_emp<-sum(rbinom(n[1], 1, p))/n[1]
    intervalle_asymp_a<-n0[1]/(moy_emp+(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[1])))
    intervalle_asymp_b<-n0[1]/(moy_emp-(qnorm(1-alphas[2]/2)*sqrt(moy_emp*(1-moy_emp)/n[1])))
    if ((intervalle_asymp_a <= theta[1]) && (theta[1] <= intervalle_asymp_b)){
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
  for (cpt_simu in 1:m[1]){
    p<-n0[1]/theta[1]
    T=sum(rbinom(n[1], 1, p))
    intervalle_exact_a<-n0[1]*(1+(((n[1]-T)/(T+1))*qf(alphas[i]/2,2*(n[1]-T),2*(T+1))))
    intervalle_exact_b<-n0[1]*(1+(((n[1]-T+1)/T)*qf(1-(alphas[i]/2),2*(n[1]-T+1),2*T)))
    if ((intervalle_exact_a <= theta[1]) && (theta[1] <= intervalle_exact_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[1])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de alpha (intervalles de confiance exacts) :")
print(proportions)
for (i in 1:length(alphas)){
  # intervalle asymptotique
  cpt<-0
  for (cpt_simu in 1:m[1]){
    p<-n0[1]/theta[1]
    moy_emp<-sum(rbinom(n[1], 1, p))/n[1]
    intervalle_asymp_a<-n0[1]/(moy_emp+(qnorm(1-alphas[i]/2)*sqrt(moy_emp*(1-moy_emp)/n[1])))
    intervalle_asymp_b<-n0[1]/(moy_emp-(qnorm(1-alphas[i]/2)*sqrt(moy_emp*(1-moy_emp)/n[1])))
    if ((intervalle_asymp_a <= theta[1]) && (theta[1] <= intervalle_asymp_b)){
      cpt<-cpt+1  # compte le nombre de fois ou l'appartenance est validee
    }
  }
  proportions[i]<-(cpt/m[1])*100
}
print("proportions (en pourcentage) en fonction de l'augmentation de alpha (intervalles de confiance asymptotiques) :")
print(proportions)

# 4.2)
m<-100
p<-0.05
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
m<-100
p<-0.05
n<-c(5,30,50,100,1000,10000)
epsilon<-0.01
moy_emps<-c()
par(mfrow=c(2,3))
for (i in 1:length(n)){
  for (j in 1:m){
    moy_emps[j]<-sum(rbinom(n[i], 1, p))/n[i]
  }
  # on trie les donnees
  moy_emps<-sort(moy_emps)
  # histogrammes de meme largeur
  # regles de sturges
  nb<-ceiling(log2(length(moy_emps)))
  a_min<-moy_emps[1]-0.025*(moy_emps[m]-moy_emps[1])
  a_max<-moy_emps[m]+0.025*(moy_emps[m]-moy_emps[1])
  h<-(a_max-a_min)/nb
  bornes<-seq(a_min,a_max,h)
  # hist(moy_emps, prob=T, breaks=bornes) # A DECOMMENTER
  # graphe de probabilités pour la loi normale
  plot(qnorm(moy_emps),qnorm(seq(1:m)/m)) # A DECOMMENTER
}