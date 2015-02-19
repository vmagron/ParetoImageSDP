clear all; 
N = 100;
n = 1;
mpol('x', n);
mpol lambda;
mu = meas(x, lambda);
f1 = x(1); f2 = 1 - x(1);
g1 = x(1) >= 0; g2 = 1 >= x(1);
Khat = [g1, g2]; 
Khatlambda = [Khat, lambda >= 0, 1 >= lambda, sum(x^2) + lambda^2 <= n + 1];
[pout_discret3, p1_d3, p2_d3] = pareto_sos (x, lambda, 2, 2, N, n, f1, f2, Khatlambda, 0, 1);
%[pout_discret4, p1_d4, p2_d4] = pareto_sos (x, lambda, 4, 4, N, n, f1, f2, Khatlambda,0, 1);
%[pout_discret5, p1_d5, p2_d5] = pareto_sos (x, lambda, 5, 5, N, n, f1, f2, Khatlambda,0,1);
%[pout_discret6, p1_d6, p2_d6] = pareto_sos (x, lambda, 6, 6, N, n, f1, f2, Khatlambda,0,1);
%[obj, f1opt, f2opt] = pareto_sos_test (x, 3, N, f1, f2, Khat);
for i = 1:(N + 1)
  xstep (i) = (i - 1) / N;
end
%figure;
%plot(xstep, pout_discret4, xstep, pout_discret5);
%figure; plot(p1_d4, p2_d4)
figure; plot(p1_d3, p2_d3) 
%figure; plot(p1_d6, p2_d6) 
