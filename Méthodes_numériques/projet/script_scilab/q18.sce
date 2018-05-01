
clear
n=63
T=135
h = 1/10
N =T/h
p = 2


U_m1 = zeros(n,1)
U_0 = zeros(n,1)
v_0 = zeros(n,1)


m=1


for i = 1:n
    if modulo(i, 2) == 0 
        M(i,:) = m
    else M(i,:) = 1
    end
end

M = diag(M)
//Mise au point des valeurs de A
A = zeros(n,n)
A(1,1) = M(i)+1
for k=2:n
    A(k,k) = M(i)+2*h**2
    if k<n
        A(k+1,k) = -1
        A(k,k+1) = -1 
    end
end

//Diagonale de A
A_D = M + (h**2)*2
A_D(1,1) = A_D(1,1) - h**2

//Sous_diagonale de A
A_SD = (-1)*ones(n-1,1)

function[Linf,Ldiag]= factorise()
    Ldiag(1,1) = sqrt(A_D(1))
    for i = 2:n
        Linf(i-1,1) = A_SD(i-1,1)/Ldiag(i-1,1)
        Ldiag(i,1) = sqrt(A_D(i,1)-Linf(i-1,1)**2) 
    end
endfunction
[L_inf,L_diag]=factorise()


function[Y]=descente(Minf, Mdiag, B)
    Y(1, 1) = B(1,1)/Mdiag(1,1)
    for i=2:n
        Y(i,1) = (B(i,1)-Minf(i-1,1)*Y(i-1,1))/Mdiag(i,1)
    end
endfunction


function[U]=remonte(Minf, Mdiag, Y)
    U = zeros(n,1)
    U(n,1)= Y(n,1)/Mdiag(n,1)
    for i = 1:n-1
        U(n-i,1) = (Y(n-i,1)-(Minf(n-i,1)*U(n-i+1,1)))/Mdiag(n-i,1)
    end
endfunction


//force exterieur
function[F_ex]=f1(t1)
    if  t1>=0 & t1<=1/2
        F_ex = t1
    elseif t1>=1/2 & t1<=1
         F_ex = 1-t1
    else F_ex = 0
    end
endfunction

function[B]=calcul_b(U_k, U_km1)
    B = M*(2*U_k - U_km1)
    B(1,1) = B(1,1) + h*h*f1(k*h)

endfunction

function[U_C]=eulerimp(A)
    U_kkm1 = U_m1
    U_kk = U_0
    U_C(:,1) = U_0 
    for k = 2:N
        b = calcul_b(U_kk, U_kkm1)
        Y = descente(L_inf, L_diag, b)
        U_C(:,k) = remonte(L_inf, L_diag, Y)
        U_kkm1 = U_kk
        U_kk = U_C(:,k) 
    end
endfunction

U_euler = eulerimp(A)

function[V]= vitesse(index)
    for k = 1 : N
       if k == 1 
            V(1,k) = (1/h)*(U_euler(index,k) - U_euler(index,1))
        else
            V(1,k) = (1/h)*(U_euler(index,k) - U_euler(index,k-1))
        end
    end
endfunction

v1 = vitesse(1)
//v8 = vitesse(8)
//v32= vitesse(32)
//v48= vitesse(48)
//v63= vitesse(63)

t = [0:h:(N-1)*h]'

////Début tracé des vitesses des 5 billes
plot2d(t, v1, 10)
//plot2d(t, v8, 30)
//plot2d(t, v32, 35)
//plot2d(t, v48, 25)
//plot2d(t, v63, 20)

