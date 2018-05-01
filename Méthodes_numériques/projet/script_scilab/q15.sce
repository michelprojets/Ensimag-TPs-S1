clear

n=2

A = zeros(n,n)
for k=1:n
    A(k,k) = 2
    A_D(k,1) = 2
    if k<n
        A(k+1,k) = -1
        A_SD(k,1) = -1
        A(k,k+1) = -1 
    end
end



b = zeros(n,1)
for l=1:n
    b(l,1) = l
end

//Debut q15


function[L]= cholesky()
    L(1,1) = sqrt(A_D(1))
    for i = 2:n
        L(i,i-1) = A_SD(i-1,1)/L(i-1,i-1)
        L(i,i) = sqrt(A_D(i,1)-L(i,i-1)**2) 
    end
endfunction


function[Linf,Ldiag]= factorise()
    Ldiag(1,1) = sqrt(A_D(1))
    for i = 2:n
        Linf(i-1,1) = A_SD(i-1,1)/Ldiag(i-1,1)
        Ldiag(i,1) = sqrt(A_D(i,1)-Linf(i-1,1)**2) 
    end
endfunction
//Les 2 vecteurs linf et ldiag
[L_inf,L_diag]=factorise()
disp(L_inf)
disp(L_diag)
//Tests du théorème de cholesky
L=cholesky()
AA = L*(L')
disp(AA)
disp(A)

//disp(L_inf) 
//disp(L_diag) 
clear
