// exp 6

function f = fourier(x,n)
    f=0
    for i=0:(n+1)
        f=f+((sin(2*(2*n+1)*%pi*x))/(2*n+1))
    end
    f=f*(4/%pi)
endfunction

n = input('Entrer le nombre de termes : ')
x=(-1/2):0.01:(1/2)
plot2d(x, fourier(x,n), style=5)
xtitle("Graphe série de Fourier avec n=" + string(n))
xlabel("x"); ylabel("f(x)")
