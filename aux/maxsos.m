function [obj] = maxsos (x, p, g, k)
n = length(x); m = length(g);
%mons = monpowers(2,2 * k);
obj = sdpvar(1,1);
cstr = []; coeffsos = []; qk = 0;
for j = 1:m
  gj = g(j); dj = 2 * ceil(degree(gj)/2);
  [s,c] = polynomial([x], 2 * k - dj); 
  coeffsos = [coeffsos; c];
  cstr = [cstr sos(s)];
  qk = qk + s * gj;
end
K = [sos(obj - p - qk), cstr];
solvesos(K, obj, sdpsettings('solver','mosek'), [coeffsos; obj]);
obj = double(obj);
