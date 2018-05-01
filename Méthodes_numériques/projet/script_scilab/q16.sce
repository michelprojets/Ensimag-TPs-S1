clear

n=4


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

yy= descente(L_inf, L_diag, b)
disp(yy)



clear
