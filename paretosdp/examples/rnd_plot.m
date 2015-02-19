function [f1plot, f2plot] = rnd_plot(kmax, Q1, Q2, q1, q2, n)
%a1 = (M1 - m1)/2; b1 = (M1 + m1)/2;
%a2 = (M2 - m2)/2; b2 = (M2 + m2)/2;
f1plot = []; f2plot = [];
for k = 1:kmax
 x = -1 + 2 .* rand(n,1); 
 f1 = x' * Q1 * x / n^2  - q1' * x  / n; f2 = x' * Q2' * x / n^2  - q2' * x  / n;
 f1plot = [f1plot, f1]; f2plot = [f2plot, f2];
end
