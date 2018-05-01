//Début Q9
clear
stacksize('max')
T= 60
h = 1/1000
n = 21
N = T/h

m = 1

//X0
M = eye(n,n)

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

function[X_kp1] = eulerimp(M, h)

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

X= eulerimp(M,h)

function[V]= vitesse(index)
    for k = 1 : N
       if k == 1 
            V(1,k) = (1/h)*(X(index,k) - X_m1(index,1))
        else
            V(1,k) = (1/h)*(X(index,k) - X(index,k-1))
        end
    end
endfunction

function[FC]= force_contact()
    for i = 1:n-1
        FC(i,1) = max(X(i,1) - X_m1(i,1), 0)**(1.5)
        for k = 2 : N
            FC(i,k) = max(X(i,k) - X(i+1,k), 0)**(1.5)
        end
    end
endfunction

//v1 = vitesse(1)
//v7 = vitesse(7)
//v11= vitesse(11)
//v15= vitesse(15)
//v19= vitesse(19)
//v20= vitesse(20)
//v21= vitesse(21)

//Début force de contact

contc = force_contact()
t = [0:h:(N-1)*h]'
u = 0:1:n-2
Sgrayplot(u,t,contc)
//Fin force de contact


////Début tracé des vitesses des 7 billes
//plot2d(t, v1, 60)
//plot2d(t, v7, 30)
//plot2d(t, v11, 35)
//plot2d(t, v15, 25)
//plot2d(t, v19, 20)
//plot2d(t, v20, 15)
//plot2d(t, v21, 10)
//legend(["Bille 1"; "Bille 7";"Bille 11"; "Bille 15"; "Bille 19"; "Bille 20"; "Bille 21"])
////Fin tracé des vitesses des 7 billes



clear


