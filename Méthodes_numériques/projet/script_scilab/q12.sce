//Début Q9
clear

T= 60
h = 1/100
n = 21
N = T/h

m = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]

X_0 = zeros(n,1)

X_m1 = zeros(n, 1)
X_m1(1,1) = -h

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
    for k = 1:n
        if modulo(k, 2) == 0 
            SM(k,:) = m_act
        else SM(k,:) = 1
        end
    end
    M = diag(SM)
    
    X_k = X_0
    X_km1 = X_m1
    X_kp1(:, 1) = X_k
    
    for k = 2 : N            
        X_k1 = fsolve(X_k, feulerimp)
        X_kp1(:, k) = X_k1
        X_km1 = X_k
        X_k = X_k1
        
    end
endfunction



function[V]= vitesse_eject()
    for e = 1: 10
        m_act = m(e)
        X= eulerimp()
        V(1,e) = (1/h)*(X(n,N) - X(n,N-1))
    end
endfunction

vit_eject = vitesse_eject()

plot2d(m,vit_eject,20)
xtitle("Tracée de la vitesse d ecjection en fonction de la masse")
clear


