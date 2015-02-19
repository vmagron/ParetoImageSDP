% Gloptipoly script to compute approximation of Pareto curves
% 2 * s is the number of moment constraints used to compute approximation of the generalized moments int_0^1 f_j^*(lambda) lambda^k dmu (lambda) k = 1, ..., 2 s
% d is the relaxation order (maximal half degree of the combinations of sos polynomials and gj when solving the dual SOS relaxation)
% n is the number of variables
% gj are the polynomials used to define the support constraints of the measure
function [pout_discret] = pareto_sos (x, xfree, u, s, d, N, n, f1, f2, Khat, lo1, up1)
C1 = up1 - lo1;
mu = meas(x, u);
mufree = meas(xfree);
fu = f2; %the criterion to be minimized
mmom_cstr (2 * s, 1) = momcon(); %k_dimensional vector to encode the moments equality constraints
mmom_cstr(1) = mass (mu) - 1 == 0;
for k = 1 : (2*s)
  mmom_cstr (k + 1) = mom (u^k) - 1 / (1 + k)==0;
end
Khat = [Khat, f1 / C1 - lo1 / C1 <= u,    x'*x + u^2 <= n + 1];
[P, M] = msdp(min(fu), Khat, mmom_cstr', d);
[A,b,c,K] = msedumi(P);
[xout,yout,info] = sedumi(A,b,c,K);
%[obj, info] = msol(P);
% xout is the (2s + 1) vector so that pout = sum_{i=0}^{2 s} xout_i lambda^i underestimates f(lambda)^*
%xout0 = -c'*xout + c(1:(2 * s))' * xout(1:(2 * s));
for step = 1:(N + 1)
  lam = (step - 1)/ N;
  pout = 0;
  for i = 0 : (2 * s)
    pout = pout + xout(i+1) * lam^i;
  end
  pout_discret (step) = pout;
end
