function In=suite(n)
    if n==0 then
        In=exp(1)-1
    else
        In=exp(1)-(n*suite(n-1))
    end
endfunction

res=suite(20)
disp(res)

function In=serie_exp(N,n)
    In=0
    for k=0:N
        In=In+(1/(factorial(k)*(k+n+1)))
    end
endfunction

res2=serie_exp(10000,20)
disp(res2)
