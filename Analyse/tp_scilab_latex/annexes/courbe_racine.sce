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
