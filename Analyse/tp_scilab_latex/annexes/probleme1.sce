// exo 2

function f=racine(x)
    f=x
    for i=1:128
        f=sqrt(f);
    end
    for i=1:128
        f=f.^2;
    end
endfunction

x=0:0.01:4
plot2d(x, racine(x), style=5)
xtitle("Graphe de f sur [0,4] avec un pas de 0.01")
xlabel("x"); ylabel("f(x)");

// exo 3.1

function In=suite(n)
    if n==0 then
        In=exp(1)-1
    else
        In=exp(1)-(n*suite(n-1))
    end
endfunction

res=suite(20)
disp(res)

// exo 3.2

function In=serie_exp(N,n)
    In=0
    for k=0:N
        In=In+(1/(factorial(k)*(k+n+1)))
    end
endfunction

res2=serie_exp(10000,20)
disp(res2)

// exo 4

function I=rectangle(n)
    I=0
    for k=0:n
       I=I+(((1/n)*((k/n)^(20)))*exp(k/n)) 
    end
endfunction

res3=rectangle(100000)
disp(res3)
