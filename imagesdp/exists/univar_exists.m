x = sdpvar(1,1);
f = -1/2 + x(1)^2;
g1 = x(1)+1; g2 = 1 - x(1);
g = [g1, g2];
y = sdpvar(1,1);
%b1 = y(1); b2 = 1 - y(1); b3 = y(2); b4 = 1 - y(2);
%g = [g, b1, b2, b3, b4];
k = 4; order = k;
g = [g, 1 - y(1), y(1)+1];
m = length(g);
mons = monpowers(1,k);
gammak = zeros(length(mons),1);
[J, ck] = polynomial(y, k);
for alpha = 1:length(mons)
  beta = mons(alpha,:);
  gammak(alpha) = 1 / (1 + beta(1));
end
obj = ck' * gammak;
cstr = [];
coeffsos = [];
qk = 0;
for j = 1:m
  gj = g(j); dj = degree(gj);
  if mod(dj, 2) == 1
    dj = dj - 1;
  end
  [s,c] = polynomial([x; y], 2 * order - dj); 
  coeffsos = [coeffsos; c];
  cstr = [cstr, sos(s)];
  qk = qk + s * gj;
end
fy = y(1)^3 - y(1)^2 + 2 * y(1);
%fy = -y;
F = [sos(f + fy  - J - qk), cstr];
solvesos(F, -obj, [], [coeffsos;ck]);
%[y1,y2] = meshgrid(6:0.1:19, 0:0.1:2.5);
%[y1,y2] = meshgrid(-10:0.1:10);
Jk = double(ck);
jcontour = 0;
y = -1:0.1:1;
fyplot = -1/2 + y.^3 - y.^2 + 2 * y;
%fyplot = -y;
for alpha = 1:length(mons)
  beta = mons(alpha,:);
  jcontour = jcontour + Jk(alpha)* (y).^beta(1);
end
figure;plot(y,jcontour,y, fyplot)
xlabel('y');
ylabel('J');
