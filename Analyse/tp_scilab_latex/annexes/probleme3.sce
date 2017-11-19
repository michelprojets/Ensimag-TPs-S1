// exo 7

function disques(A)
    diag_A = diag(A)
    len_diag_A = size(diag_A)
    len_diag_A = len_diag_A(1,1)
    colour = 3
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
        plot2d(cos(t)*r + re_center, sin(t)*r + im_center, style=colour)
        colour = colour + 1
    end
    xtitle("Représentation graphique des disques de Gerschgörin et des valeurs propres de la matrice A")
    xlabel("Re"); ylabel("Im")
endfunction

function valeurs_propres(A)
    vals = spec(A)
    len_vals = size(vals)
    len_vals = len_vals(1,1)
    for k=1:len_vals
        re_val = real(vals(k,1))
        im_val = imag(vals(k,1))
        plot2d(re_val, im_val, style=-2)
    end
endfunction

A=[1+%i,%i,2;3,2+%i,1;1,%i,6]
disques(A) // on dessine les cercles
valeurs_propres(A) // on place les valeurs propres
