//Début Q8
clear
h = 0.1
T = 60
N= T/h
n = 21
m = 1

X_0 = zeros(n,1)

X_m1 = zeros(n, 1)
X_m1(1,1) = -h

for k = 1:n
    if modulo(k, 2) == 0 
        SM(k,:) = m
    else SM(k,:) = 1
    end
end

M0 = diag(SM)



function[S_M] = secondmembre(Y)
    S_M = zeros(n,1)
    S_M(1) = -max(Y(1) - Y(2), 0)**(1.5)
    for i= 2 : (n-1)
         S_M(i) = max(Y(i-1) - Y(i),0)**(1.5) - max(Y(i) - Y(i+1),0)**(1.5)
    end
    S_M(n) = max(Y(n-1) - Y(n), 0)**(1.5)
endfunction

function[F_y] = feulerimp(Y)

    F_y = M*(Y - 2*X_k + X_km1) - (h*h)*secondmembre(Y)
endfunction

function[X_kp1] = eulerimp(M,h)
    X_k = X_0
    X_km1 = X_m1
    X_kp1(:, 1) = X_k

    for k = 2 : N
         X_kp1(:, k) =fsolve(X_k, feulerimp)
         X_km1 = X_k
         X_k = X_kp1(:, k)
    end
endfunction
X = eulerimp(M0,h) 
disp(X)

