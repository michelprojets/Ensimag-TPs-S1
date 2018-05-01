//Debut Q3
clear
n = 3/2
function[F_y] = rhs(Y)
    f1 = Y(3,1)
    f2 = Y(4,1)
    f3 = -max(Y(1,1)-Y(2,1),0)**(n)
    f4 = max(Y(1,1)-  Y(2,1), 0)**(n)
    
    F_y = [f1; f2; f3; f4]
    
endfunction

function[sol] = eulerexp(Y0, h, N)
    Y_k = Y0
    sol(:,1) = Y_k
    for k = 2: N+1
        Y_kp1 = Y_k + h*rhs(Y_k)
        Y_k = Y_kp1
        sol(:,k) =Y_kp1
    end
endfunction

Y_0 = [0; 0; 1; 0]
h1 = 1/10
h2 = 1/100
h3 = 1/1000

N1 = 49
N2 = 499
N3 = 4999

Y1 = eulerexp(Y_0, h1, N1)
Y2 = eulerexp(Y_0, h2, N2)
Y3 = eulerexp(Y_0, h3, N3)


t1 = 0:h1:N1*h1
t2 = 0:h2:N2*h2
t3 = 0:h3:N3*h3

//tracée x1 et x2 pour h = 1/10
scf(1) //fenetre 1
plot2d(t1, Y1(1,:), 10)    //x1
plot2d(t1, Y1(2,:), 15)    //x2
legend(["x1"; "x2"])
xtitle("tracée de x1 et x2 pour h = 1/10")

//tracée x1 et x2 pour h = 1/100
scf(2) //fenetre 2
plot2d(t2, Y2(1,:), 10)    //x1
plot2d(t2, Y2(2,:), 15)    //x2
legend(["x1"; "x2"])
xtitle("tracée de x1 et x2 pour h = 1/100")

////tracée x1 et x2 pour h = 1/1000
scf(3) //fenetre 3
plot2d(t3, Y3(1,:), 10)    //x1
plot2d(t3, Y3(2,:), 15)    //x2
legend(["x1"; "x2"])
xtitle("tracée de x1 et x2 pour h = 1/1000")




//tracée v1 et v2 pour h = 1/10
scf(4) //fenetre 4
plot2d(t1, Y1(3,:), 20)    //v1
plot2d(t1, Y1(4,:), 40)    //v2
legend(["v1"; "v2"])
xtitle("tracée de v1 et v2 pour h = 1/10")

//tracée v1 et v2 pour h = 1/100
scf(5) //fenetre 5
plot2d(t2, Y2(3,:), 20)    //v1
plot2d(t2, Y2(4,:), 40)    //v2
legend(["v1"; "v2"])
xtitle("tracée de v1 et v2 pour h = 1/100")

//tracée v1 et v2 pour h = 1/100
scf(6) //fenetre 6
plot2d(t3, Y3(3,:), 20)    //v1
plot2d(t3, Y3(4,:), 40)    //v2
legend(["v1"; "v2"])
xtitle("tracée de v1 et v2 pour h = 1/1000")
