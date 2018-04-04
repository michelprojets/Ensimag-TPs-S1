// I) question 2

Y=
function F=rhs(Y)
    F1=numderivative(Y(1,1),t)
    F2=numderivative(Y(2,1),t)
    F3=numderivative(Y(3,1),t)
    F4=numderivative(Y(4,1),t)
    F=(F1,F2,F3,F4)
    return F
endfunction
