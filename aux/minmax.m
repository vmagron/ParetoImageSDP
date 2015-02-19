function [m, M] = minmax (x, n, f, K, k0)
mu = meas(x);
max_order = 2;
relax_order = k0;
status = 0;
while (status < 1 && relax_order <= max_order)
  P = msdp(min(f), K, mass(mu)==1, relax_order);
  [status, m] = msol(P);
  m
  relax_order = relax_order + 1;
end
m = double(mom(f));
relax_order = k0;
status = 0;
while (status < 1 && relax_order <= max_order)
  P = msdp(max(f), K, mass(mu)==1, relax_order);
  [status, M] = msol(P);
  M
  relax_order = relax_order + 1;
end
M = double(mom(f));
