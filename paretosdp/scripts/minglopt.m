function [m, xm] = minglopt (x, n, f, K, feval, k0)
mu = meas(x);
max_order = 6;
relax_order = k0;
status = 0;
while (status < 1 && relax_order <= max_order)
  P = msdp(min(f), K, mass(mu)==1, relax_order);
  [status, m] = msol(P);
  relax_order = relax_order + 1;
end
dmvec = double(mvec(mu));
xm = dmvec(1:n);
m = double(feval);
