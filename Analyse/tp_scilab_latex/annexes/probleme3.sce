// exo 7

function disques(A)
    diag_A = diag(A)
    len_diag_A = size(diag_A)
    len_diag_A = len_diag_A(1,1)
    color = 1
    t=0:0.001:(2*%pi)
    for k=1:len_diag_A
        r=0
        for j=1:len_diag_A
            if j <> k then
                r = r + abs(A(k,j))
            end
        end
        plot2d(cos(t)*r, sin(t)*r, style=color)
        color = color + 1
    end
    xtitle("Représentation graphique des disques de Gerschgörin")
    xlabel("Re"); ylabel("Im")
    vals = spec(A)
    len_vals = size(vals)
    len_vals = len_vals(1,1)
    for k=1:len_vals
        x=real(vals(1,k))-0.5:0.001:real(vals(1,k))+0.5
        plot2d(x, imag(vals(1,k)), style=5)
    end
endfunction

A=[1+%i,%i,2;3,2+%i,1;1,%i,6]
disques(A)
