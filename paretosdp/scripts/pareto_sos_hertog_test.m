% Gloptipoly script to compute approximation of Pareto curves
function [obj, f1opt, f2opt, good_lambda, badlam, udiscret] = pareto_sos_cheb_test (x, xfree, d, N, n, f1, f2, f1free, f2free, Khat, lo, up)
max_order = 5;
C1 = up - lo;
status = zeros(N+1,1);
mu = meas(x);
good_lambda = []; badlam = []; udiscret = [];
f1opt = []; f2opt = [];
for i = 1:(N+1)
  i
%  u = (up1 - lo1) * (i - 1) / N + lo1;
  u = (up - lo) * (i - 1) / N + lo;
  udiscret = [udiscret, u];
  fu = f2; %the criterion to be minimized
%  Khatu = [Khat, f1 / C1 - lo / C1<= u, x'*x <= n];
  Khatu = [Khat, f1 <= u, x'*x <= n];
  relax_order = d;
  while (status (i) < 1 && relax_order <= max_order)
    P = msdp(min(fu), Khatu, mass(mu)==1, relax_order);
    [status(i), obj(i)] = msol(P);
    relax_order = relax_order + 1;
  end
  dmvec = double(mvec(mu));
% x1(i) = dmvec(1); x2(i) = dmvec(2);
  if (status(i) >= 1) 
    f1opt(i) = double(f1); f2opt(i) = double(f2);
    good_lambda = [good_lambda, i];
  else
    badlam = [badlam, i];
    f1opt(i) = double(mom(f1)); f2opt(i) = double(mom(f2));  
  end
end

