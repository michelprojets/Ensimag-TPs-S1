function I=rectangle(n)
    I=0
    for k=0:n
       I=I+(((1/n)*((k/n)^(20)))*exp(k/n)) 
    end
endfunction

res3=rectangle(100000)
disp(res3)
