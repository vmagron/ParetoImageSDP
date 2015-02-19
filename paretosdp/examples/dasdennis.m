clear all; 
N = 100;
n = 5;
mpol('xlarge', n);
mpol('x', n);
mpol('xfree',n);
mpol lambda;
xlarge(1) = x(1) * 2; xlarge(2) = x(2) * 2;
xlarge(3) = x(3) * 2;  xlarge(5) = x(5) * 2; xlarge(4) = x(4)* 2;
f1 = xlarge(1)^2 + xlarge(2)^2 + xlarge(3)^2 + xlarge(4)^2 + xlarge(5)^2
f2 = 3 * xlarge(1) + 2 * xlarge(2) - 1/3 * xlarge(3) + 0.01 * (xlarge(4) - xlarge(5))^3
f1free = (2 * xfree(1))^2 + (2 * xfree(2))^2 + (2 * xfree(3))^2 + (2 * xfree(4))^2 + (2 * xfree(5))^2
f2free = 3 * (2 * xfree(1)) + 2 * (2 * xfree(2)) - 1/3 * (2 * xfree(3)) + 0.01 * ((2 * xfree(4)) - (2 * xfree(5)))^3

g1 = xlarge(1) + 2 * xlarge(2) - xlarge(3) - 0.5 * xlarge(4) + xlarge(5) == 2;
g2 = 4 * xlarge(1) - 2 * xlarge(2) + 0.8 * xlarge(3) + 0.6 * xlarge(4) + 0.5 * xlarge(5)^2 == 0;
g3 = 10 -  xlarge(1)^2 -  xlarge(2)^2 -  xlarge(3)^2 -  xlarge(4)^2 -  xlarge(5)^2 >= 0;
mu = meas(x, lambda);
%b1 = x(1) >= 0; b2 = 1 >= x(1); 
%b3 = x(2) >= 0; b4 = 1 >= x(2); 
%b5 = x(3) >= 0; b6 = 1 >= x(3); 
%b7 = x(4) >= 0; b8 = 1 >= x(4); 
%b9 = x(5) >= 0; b10= 1 >= x(5); 
Khat = [g1, g2, g3]; 
Khatlambda = [Khat, lambda >= 0, 1 >= lambda];
[pout_discret2, p1_d2, p2_d2, f1_d2, f2_d2] = pareto_sos (x, xfree, lambda, 2, 2, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1);
[pout_discret3, p1_d3, p2_d3, f1_d3, f2_d3] = pareto_sos (x, xfree, lambda, 3, 3, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1);
%[obj, x1, x2, f1opt, f2opt] = pareto_sos_test (x, 2, N, f1, f2, Khat);

[m1, M1] = minmax (x, n, f1, Khat, 2); [m2, M2] = minmax (x, n, f2, Khat, 2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb2, f2cheb2] = pareto_sos_cheb (x, xfree, lambda, 2, 2, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2);
[out3, p1_d3_cheb, p2_d3_cheb, f1cheb3, f2cheb3] = pareto_sos_cheb (x, xfree, lambda, 3, 3, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2);
[obj, x1, x2, f1opt, f2opt] = pareto_sos_cheb_test (x, 2, N, n, f1, f2, Khat, m1, M1, m2, M2);
for i = 1:(N + 1)
  xstep (i) = (i - 1) / N;
end
%plot(xstep, pout_discret2, xstep, pout_discret3, xstep, obj);
figure; plot(f1_d2, f2_d2, f1_d3, f2_d3, f1opt, f2opt)
figure; plot(f1cheb2, f2cheb2, f1cheb3, f2cheb3, f1opt, f2opt);
%plot(p1_d2_cheb, p2_d2_cheb, p1_d3_cheb, p2_d3_cheb, p1_d4_cheb, p2_d4_cheb, f1opt, f2opt);
