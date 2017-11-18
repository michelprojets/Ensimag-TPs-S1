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
        re_center = real(diag_A(k))
        im_center = imag(diag_A(k))
        plot2d(cos(t)*r + re_center, sin(t)*r + im_center, style=color)
        color = color + 1
    end
    xtitle("Représentation graphique des disques de Gerschgörin")
    xlabel("Re"); ylabel("Im")
endfunction

A=[1+%i,%i,2;3,2+%i,1;1,%i,6]
disques(A)
