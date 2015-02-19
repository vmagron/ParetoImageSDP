function [obj] = maxsos (x, p, g, k)
obj = sdpvar(1,1);
n = length(x); m = length(g);
np = length(p);
cstr = []; coeffsos = [];
for ip = 1:np
  pi = p(ip);
  qk = 0;
  for j = 1:m
    gj = g(j); dj = 2 * ceil(degree(gj)/2);
    [s,c] = polynomial([x], 2 * k - dj); 
    coeffsos = [coeffsos; c];
    cstr = [cstr sos(s)];
    qk = qk + s * gj;
  end
  cstr = [cstr sos(pi - obj - qk)];
end
solvesos(cstr, -obj, sdpsettings('solver','mosek'), [coeffsos; obj]);
obj = double(-obj);
