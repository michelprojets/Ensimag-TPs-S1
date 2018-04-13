teta <- 1000
n0   <- 50
m    <- 80


# Deuxième stratégie

#Question 1

ech <- rgeom(m, n0/teta) + 1
"R simule l'échantillon suivant:"
ech
"Sa moyenne et sa variance sont:"
mean(ech)
var(ech)

#Question 2

"Ici, on a:"
n <- sum(ech)
n

#Question 3

est <- n0*mean(ech)
est

#Question 4
I_m <- function(t)
{
  m/(t^2 - t * n0)
}

I_m(teta)

#Question 5
seuils <- c(0.01, 0.05, 0.1, 0.2)

IC <- function(seuils)
{
  for (alpha in seuils) {
    d <- qnorm(1 - alpha/2)/sqrt(I_m(t = est))
    ic <- c(est - d, est + d)
    print(alpha)
    print(ic)
  }
}

IC(seuils)
