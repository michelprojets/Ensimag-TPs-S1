---
title: "Formulaire de réponse pour le test 2"
output:
  html_document: default
  pdf_document: default
---

** **

##### Michel Yoeung Groupe 2



##### Question 1

* Calculer la probabilité de battre un record à l'épreuve $m$

###### Réponse : 
La probabilité de battre un record à l'épreuve $m$ vaut $\frac{1}{m}$.

** **

##### Question 2

* Donner l'espérance de $N$ pour $n = 27$. 

###### Réponse : 
L'espérance de $N$ pour $n = 27$ vaut $\sum_{i=1}^{27}\frac{1}{i} \approx 3,89$ records battus.

** **

##### Question 3

* Calculer ${\rm E}[Y_n]$.


###### Réponse : 
${\rm E}[Y_n] = \frac{n-1}{2}$.

** **

##### Question 4

* Calculer la valeur de la variance Var$[Y_3]$.

###### Réponse : 
Var$[Y_3] = \frac{1}{3}$.

** **

##### Question 5

* Calculer Var$[Y_n]$ pour tout $n \geq 2$.

###### Réponse : 
Var$[Y_n] = \frac{n+1}{12}$.

** **



##### Question 6

* Combien de tirages suffisent pour qu'avec une probabilité supérieure à 0.99, $A_{n-1}$ soit proche de la valeur 1/2 à $10^{-2}$ près. 

###### Réponse : 
En résolvant l'équation $\frac{n+1}{12(n-1)^2} = 0,99*10^{-4}$, on trouve $n \approx$ 842 tirages.

** **


##### Question 7

* Déterminer la valeur de $c$.



###### Réponse : 
$c = 10$.

** ** 


##### Question 8

* Déterminer la fonction de répartition de la variable $Y$. Donner sa valeur au point $t = 2/3$. 

###### Réponse : 
La fonction de répartition de la variable $Y$ est $F_Y(t) = t^5$.

Si $t = \frac{2}{3}$, $F_Y(t) = \frac{32}{243}$.


** **


##### Question 9


* Ecrire un algorithme de simulation d'un couple de densité $f(x,y)$.  

###### Réponse : 
On a $f_{X}^{Y=y}(x) = \frac{10x*1_{x<y}(x,y)}{y^3}$.

Soit $c = {\rm E}[Nb rejets]$.

On commence par simuler $Y$ puis $X$ sachant $Y = y$ :

    Répéter
      U <-- random()
      V <-- random()
    Jusqu'à (c*V < 5*(U^4))
      Y <-- U
      
    Répeter
      U <-- random()
      V <-- random()
    Jusqu'à (c*V < (10*U)/(Y^3) et U < Y)
      X <-- U

** **

##### Question 10


* On pose $Z =  X Y$. Déterminer la densité de la loi de la variable $Z$.
   
###### Réponse : 


** ** 


