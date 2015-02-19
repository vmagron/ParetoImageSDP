% Gloptipoly script to compute approximation of Pareto curves
function [obj, x1, x2, f1opt, f2opt, good_lambda] = pareto_sos_test (x, d, N, f1, f2, Khat)
mu = meas(x);
status = zeros(N+1,1);
good_lambda = [];
for i = 1:(N+1)
  lambda = (i - 1) / N;
  flambda = lambda * f1 + (1 - lambda) * f2; %the criterion to be minimized
  relax_order = d;
  while (status (i) < 1 && relax_order <= 6)
    P = msdp(min(flambda), Khat, mass(mu)==1, relax_order);
    [status(i), obj(i)] = msol(P);
    relax_order = relax_order + 1;
  end
  i
  dmvec = double(mvec(mu));
  x1(i) = dmvec(2); x2(i) = dmvec(3);
  if (status(i) >= 1) 
    f1opt(i) = double(f1); f2opt(i) = double(f2);
    good_lambda = [good_lambda, i];
  else 
    f1opt(i) = double(mom(f1)); f2opt(i) = double(mom(f2));  
  end
end
%obj
%1/N * sum (obj)
%x1
%x2
%plot(x1,x2)
