clear all; 
N = 100;
n = 2;
mpol('x', n);
mpol lambda;
mu = meas(x, lambda);
f1 = x(1)^5 +  x(2); f2 = x(1)^5 + 1 - x(2);
g1 = x(1) >= 0; g2 = 1 >= x(1); g3 = x(2) >= 0; g4 = 1 >= x(2);
g5 = x(1)^2 + x(2)^2 <= 2;
Khat = [g1, g2, g3, g4, g5]; 
Khatlambda = [Khat, lambda >= 0, 1 >= lambda, x'*x + lambda^2 <= n + 1];
[pout_discret3, p1_d3, p2_d3] = pareto_sos (x, lambda, 4, 4, N, n, f1, f2, Khatlambda, 0.2, 0.8);
[m1, M1] = minmax (x, n, f1, Khat, 3); [m2, M2] = minmax (x, n, f2, Khat, 3);
[pout_cheb2, p1_d2_cheb, p2_d2_cheb] = pareto_sos_cheb (x, lambda, 3, 3, N, n, f1, f2, Khatlambda, 0, 1, m1, M1, m2, M2);

%[pout_discret4, p1_d4, p2_d4] = pareto_sos (x, lambda, 4, 4, N, n, f1, f2, Khatlambda, 0, 1);
%[pout_discret5, p1_d5, p2_d5] = pareto_sos (x, lambda, 5, 5, N, n, f1, f2, Khatlambda, 0, 1);
%[pout_discret6, p1_d6, p2_d6] = pareto_sos (x, lambda, 6, 6, N, n, f1, f2, Khatlambda, 0, 1);
[obj, f1opt, f2opt] = pareto_sos_test (x, 3, N, f1, f2, Khat);
for i = 1:(N + 1)
  xstep (i) = (i - 1) / N;
end
%figure;
%plot(xstep, pout_discret4, xstep, pout_discret5);
%figure; plot(p1_d4, p2_d4)
figure; plot(p1_d3, p2_d3, p1_d2_cheb, p2_d2_cheb, f1opt, f2opt);
%figure; plot(p1_d6, p2_d6) 
