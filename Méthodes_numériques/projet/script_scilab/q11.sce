//Début Q9*

clear

stacksize('max')

T= 60
h = 1/1000
n = 21
N = T/h

m = 0.5

for k = 1:n
    if modulo(k, 2) == 0 
        SM(k,:) = m
    else SM(k,:) = 1
    end
end

M = diag(SM)

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

function[FC]= force_contact()
    for i = 1:n-1
        FC(i,1) = max(X(i,1) - X_m1(i,1), 0)**(1.5)
        for k = 2 : N
            FC(i,k) = max(X(i,k) - X(i+1,k), 0)**(1.5)
        end
    end
endfunction


contc = force_contact()
t = [0:h:(N-1)*h]'
u = 0:1:n-2
Sgrayplot(u,t,contc)






clear


