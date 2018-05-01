//Début Q9


T = 60
h1 = 1/10
h2 = 1/100
h3 = 1/1000
n = 21
m1 = 1
m2 = 0.5


X_0 = zeros(n,1)


function[S_M] = secondmembre(Y)

    S_M = zeros(n,1)
    S_M(1) = -max(Y(1) - Y(2), 0)**(1.5)
    for i= 2 : (n-1)
         S_M(i) = max(Y(i-1) - Y(i),0)**(1.5) - max(Y(i) - Y(i+1),0)**(1.5)
    end
    S_M(n) = max(Y(n-1) - Y(n), 0)**(1.5)
       
endfunction

function[F_y] = feulerimp(Y)

    F_y = M*(Y - 2*X_k + X_km1) - (h**2)*secondmembre(Y)
    
endfunction

function[X_kp1] = eulerimp()

    X_k = X_0
    X_km1 = X_m1

    X_kp1(:, 1) = X_k
    
    for k = 2 : N
        X_kp1(:, k) = fsolve(X_k, feulerimp)
        X_km1 = X_k
        X_k = X_kp1(:, k)
        
    end
endfunction

function[V]= vitesse()
    for k = 1 : N
        if k == 1
            V(:,k) = (1/h)*(X(:,k) - X_m1)
        else
            V(:,k) = (1/h)*(X(:,k) - X(:,k-1))
        end
    end
endfunction

function[N_calc]= calcul_N(T, h)
    N_calc = T/h
endfunction

function[H] = enrg_meca(mm,h, N) 
    
    for k = 1:n
        if modulo(k, 2) == 0 
            MA(k,:) = mm
        else MA(k,:) = 1
        end
    end
    M = diag(MA)
    

    X_m1 = zeros(n, 1)
    X_m1(1,1) = -h
    
    X = eulerimp()
    v = vitesse()
    H = zeros(1,N)
    for k = 1 : N
        for i = 1 : n
            H(1,k) = H(1,k)+(1/2)*M(i,i)*(v(i,k))**2
        end
        
        for j = 1 : (n-1)
            H(1,k) = H(1,k)+(2/5)*(max(X(j,k)-X((j+1),k),0))**(5/2)
        end
    end
    
endfunction



//N1 = calcul_N(T, h1)
//E11 = enrg_meca(m1,h1, N1)
//E21 = enrg_meca(m2,h1, N1)

//N2 = calcul_N(T, h2)
//E12 = enrg_meca(m1,h2, N2)
//E22 = enrg_meca(m2,h2, N2)
//
N3 = calcul_N(T, h3)
//E13 = enrg_meca(m1,h3, N3)
E23 = enrg_meca(m2,h3, N3)

//t1 = 0:h1:(N1-1)*h1
//t2 = 0:h2:(N2-1)*h2
t3 = 0:h3:(N3-1)*h3


//scf(1) //fenetre 1
//plot2d(t1, E11, 60)
//xtitle("Energie mécanique dans le temps pour m = 1 et h = 1/10")


//scf(2) //fenetre 2
//plot2d(t2, E12, 60)
//xtitle("Energie mécanique dans le temps pour m = 1 et h = 1/100")
//
//
//scf(3) //fenetre 3
//plot2d(t3, E13, 60)
//xtitle("Energie mécanique dans le temps pour m = 1 et h = 1/1000")
//

//scf(4) //fenetre 4
//plot2d(t1, E21, 20)
//xtitle("Energie mécanique dans le temps pour m = 0.5 et h = 1/10")

//
//scf(5) //fenetre 5
//plot2d(t2, E22, 20)
//xtitle("Energie mécanique dans le temps pour m = 0.5 et h = 1/100")
//
//
scf(6) //fenetre 6
plot2d(t3, E23, 20)
xtitle("Energie mécanique dans le temps pour m = 0.5 et h = 1/1000")


