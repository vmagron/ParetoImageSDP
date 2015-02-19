function [y1, y2, G] = exists (x, yscale, f, k, order, g, lo, up, eps)
%b1 = y(1); b2 = 1 - y(1); b3 = y(2); b4 = 1 - y(2);
%g = [g, b1, b2, b3, b4];
%g = [g, 1 - y(1), y(1)+1, 1 - y(2), y(2) + 1];
%g = [g, 1 - x(1), x(1), 1 - x(2), x(2)];
scale = 0;
f1 = f(1); f2 = f(2);
g = [g, 1 - yscale(1)^2 - yscale(2)^2];
%g = [g, 2 - x(1)^2 - x(2)^2];
m = length(g);
order = max(k, order);
mons = monpowers(2,2 * k);
gammak = zeros(length(mons),1);
[J, ck] = polynomial(yscale, 2 * k);
for alpha = 1:length(mons)
  beta = mons(alpha,:); b1 = beta(1); b2 = beta(2);
  gammak(alpha) = momball(beta);
  %gammak(alpha) = (1 - (-1)^(b1+1)) / (1 + b1) *  (1 - (-1)^(b2+1)) / (1 + b2);
  %gammak(alpha) = 0;
end
obj = ck' * gammak;
cstr = [];
coeffsos = [];
qk = 0;
for j = 1:m
  gj = g(j); dj = 2 * ceil(degree(gj)/2);
  [s,c] = polynomial([x; yscale], 2 * order - dj); 
  coeffsos = [coeffsos; c];
  cstr = [cstr sos(s)];
  qk = qk + s * gj;
end
a = zeros(m, 1); p = zeros(m, 1); 
for i = 1:length(f)
  a(i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
  if scale == 0
    fscale(i) = a(i) * f(i) + p(i);
  else
    fscale(i) = (a(i) * f(i) + p(i))/sqrt(2);
  end
end
F = [sos((fscale(1) - yscale(1))^2 + (fscale(2) - yscale(2))^2 - eps  - J - qk), cstr];
%solvesos(F, -obj, sdpsettings('solver','sedumi','sedumi.eps',1e-9), [coeffsos;ck]);
solvesos(F, -obj, sdpsettings('solver','mosek','sos.scale','1'), [coeffsos;ck]);
%[y1,y2] = meshgrid(6:0.1:19, 0:0.1:2.5);
%[y1,y2] = meshgrid(-10:0.1:10);
Jk = double(ck)
%y = sdpvar(2,1); 
[yscale1,yscale2]=meshgrid(linspace(-1,1,1e2));
if scale == 0
    y1 = (yscale1 - p(1))/a(1); y2 = (yscale2 - p(2))/a(2);
  else
    y1 = (sqrt(2)*yscale1 - p(1))/a(1); y2 = (sqrt(2)*yscale2 - p(2))/a(2);
  end
G = 0;
for alpha = 1:length(mons)
  beta = mons(alpha,:);
  b1 = beta(1); b2 = beta(2);
  G = G + Jk(alpha).* yscale1.^beta(1) .* yscale2.^beta(2);
  %G = G + Jk(alpha).* (y1).^beta(1) .* (y2).^beta(2);
end
for i = 1:1e2
  for j = 1:1e2
    if 1 <= yscale1(i, j)^2 + yscale2(i, j)^2
      G(i, j) = 2;
    end
  end
end


%{
mpol y1 y2;
G=vectorize(Jk'*mmon([y1 y2],2 * k));
G=eval(G);
%}
%contourf(y1,y2,-G,[0 0],'y');
%th=linspace(0,2*pi,1e3);
%plot(cos(th),sin(th),'k','linewidth',3);
%ind = find (jcontour <= 0 & 1 - y1.^2 - y2.^2 >=0);
%plot(y1(ind),y2(ind),'d')
%xlabel('y1');
%ylabel('y2');
%figure;plot3(y1,y2,jcontour)
