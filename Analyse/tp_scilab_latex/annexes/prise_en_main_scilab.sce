// question 1

// spec permet de renvoyer les valeurs propres d'une matrice
eye(4,4) // matrice identité 4x4

// question 2

// 1)

A = [1,0,3,1;1,2,0,1;0,1,3,0]
size(A) // taille matrice A

// 2)

A(1,:) // première ligne
A(:,4) // dernière colonne
A(2,3) // élément deuxième ligne troisième colonne

// 3)

diag(A) // diagonale matrice A
triu(A) // triangulaire supérieure
tril(A) // triangulaire inférieure

// question 3

// matrice identité 10x10
B=ones(1,10)
C=diag(B)

// question 4

// traçage courbe fonction sin sur [0,2pi] pour 6 points de discrétisation puis 21 points de discrétisation (en une autre couleur) avec titre et légendes
x=linspace(0,2*%pi,6)
y=linspace(0,2*%pi,21)
plot(x, sin(x), "r", y, sin(y), "b")
xtitle("Graphes de la fonction sin")
legend("sin (6 points discrétisation)","sin (21 points discrétisation)")

