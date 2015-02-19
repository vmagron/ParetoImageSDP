function [y1, y2, J, Jk] = proj_special (x, f, k, order, g, lo, up)
scale = 0;
m = length(g);
n = length(x);
order = max(k, order);
mons = monpowers(length(f),2 * k);
gammak = zeros(length(mons),1);
[J, ck] = polynomial(x(1:length(f)), 2 * k);
for alpha = 1:length(mons)
  beta = mons(alpha,:); b1 = beta(1); b2 = beta(2); b3 = beta(3);
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
  [s,c] = polynomial([x], 2 * order - dj); 
  coeffsos = [coeffsos; c];
  cstr = [cstr sos(s)];
  qk = qk + s * gj;
end
qk2 = 0;
%gj = 1 - norm(x(n-1:n),2)^2;
gj = 1 - norm(x(1:length(f)),2)^2;
dj = 2 * ceil(degree(gj)/2);
[s,c] = polynomial([x(1:length(f))], 2 * order - dj); 
coeffsos = [coeffsos; c];
cstr = [cstr sos(s)];
qk2 = qk2 + s * gj;

a = zeros(m, 1); p = zeros(m, 1); 
for i = 1:length(f)
  a(i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
  if scale == 0
    fscale(i) = a(i) * f(i) + p(i);
  else
    fscale(i) = (a(i) * f(i) + p(i))/sqrt(2);
  end
end
F = [sos(J - 1 - qk), sos(J - qk2), cstr];
%solvesos(F, -obj, sdpsettings('solver','sedumi','sedumi.eps',1e-7), [coeffsos;ck]);
%solvesos(F, obj, sdpsettings('solver','mosek','sos.scale','1'), [coeffsos;ck]);
%solvesos(F, obj, sdpsettings('solver','sparsepop'), [coeffsos;ck]);
solvesos(F, obj, sdpsettings('solver','sdpa'), [coeffsos;ck]);
%[y1,y2] = meshgrid(6:0.1:19, 0:0.1:2.5);
%[y1,y2] = meshgrid(-10:0.1:10);
Jk = double(ck)
%y = sdpvar(2,1); 
[yscale1,yscale2]=meshgrid(linspace(-1,1,1e2));
if scale == 0
    y1 = (yscale1 - p(1))/a(1); y2 = (yscale2 - p(2))/a(2); %y3 = (yscale3 - p(3))/a(3);
  else
    y1 = (sqrt(2)*yscale1 - p(1))/a(1); y2 = (sqrt(2)*yscale2 - p(2))/a(2); %y3 = (sqrt(2)*yscale3 - p(3))/a(3);
  end
G = 0;
J = 0;
for alpha = 1:length(mons)
  beta = mons(alpha,:);
  b1 = beta(1); b2 = beta(2); b3 = beta(3);
  G = G + Jk(alpha).* yscale1.^beta(1) .* yscale2.^beta(2);% .* yscale3.^beta(3);
  J = J + Jk(alpha).* x(1).^beta(1) .* x(2).^beta(2) .* x(3).^beta(3);
  %G = G + Jk(alpha).* (y1).^beta(1) .* (y2).^beta(2);
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

