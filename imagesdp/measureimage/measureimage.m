function [y1, y2, G] = measureimage (x, yscale, f, degv, gx, lo, up, eps, scale)
%b1 = y(1); b2 = 1 - y(1); b3 = y(2); b4 = 1 - y(2);
%g = [g, b1, b2, b3, b4];
%g = [g, 1 - y(1), y(1)+1, 1 - y(2), y(2) + 1];
ysum = 0;
G = 0;
y1 = []; y2 = [];
gy = [];
n = length(x);
m = length (f);
for i = 1:length(yscale)
  ysum = ysum + yscale(i)^2;
%  gy = [gy, 1 - yscale(i)^2];
end
gy = [gy, 1 - ysum];

%g = [g, 2 - x(1)^2 - x(2)^2];
mx = length(gx); my = length(gy); degvf = degree(f) * degv;
kx = ceil(degvf/2); ky = ceil(degv/2);
[w, wk] = polynomial(yscale, degv);
[v, vk] = polynomial(yscale, degv);
vf = 0;
mons = monpowers(m, degv);
gammak = zeros(length(mons),1);

a = zeros(m, 1); p = zeros(m, 1); 
%{
for i = 1:m
  a(i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
  a(i)
  p(i)
  fscale(i) =  a(i)*f(i) + p(i);
  fscale(i)
end
%}
for alpha = 1:length(mons)
  beta = mons(alpha,:); b1 = beta(1); b2 = beta(2);
  gammak(alpha) = momball(beta);
  %gammak(alpha) = (1 - (-1)^(b1+1)) / (1 + b1) *  (1 - (-1)^(b2+1)) / (1 + b2);
  product = vk(alpha);
  for i = 1:length(beta)
    a(i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
    if scale == 0 
     product = product * ((a(i)*f(i) + p(i)))^beta(i);
    else
      product = product * ((a(i)*f(i) + p(i))/sqrt(2))^beta(i);
    end
  end
  vf = vf + product;
end
sdisplay(v)
sdisplay(vf)
sdisplay(w)
obj = wk' * gammak;
cstrx = []; cstrv = []; cstrw = [];
coeffsosx = []; coeffsosv = []; coeffsosw = []; 
qx = 0; qv = 0; qw = 0;

for j = 1:mx
  gj = gx(j); dj = 2 * ceil(degree(gj)/2);
  [s,c] = polynomial([x], 2 * kx - dj); 
  coeffsosx = [coeffsosx; c];
  cstrx = [cstrx sos(s)];
  qx = qx + s * gj;
end
sdisplay(qx)

for j = 1:my
  gj = gy(j); dj = 2 * ceil(degree(gj)/2);
  [sv,cv] = polynomial([yscale], 2 * kx - dj);
  coeffsosv = [coeffsosv; cv];
  cstrv = [cstrv sos(sv)];
  qv = qv + sv * gj;
end
sdisplay(qv)

for j = 1:my
  gj = gy(j); dj = 2 * ceil(degree(gj)/2);
  [sw,cw] = polynomial([yscale], 2 * kx - dj);
  coeffsosw = [coeffsosw; cw];
  cstrw = [cstrw sos(sw)];
  qw = qw + sw * gj;
end
sdisplay(qw)

F = [sos(vf - qx - eps), sos(w - 1 - v - qv - eps), sos(w - qw - eps), cstrx, cstrv, cstrw];
%solvesos(F, obj, sdpsettings('solver','sedumi', 'verbose','2'), [coeffsosx; coeffsosv; coeffsosw;  wk; vk]);
%solvesos(F, obj, sdpsettings('solver','dsdp', 'sos.scale', '1', 'verbose','2'), [coeffsosx; coeffsosv; coeffsosw;  wk; vk]);
solvesos(F, obj, sdpsettings('solver','mosek', 'verbose','2'), [coeffsosx; coeffsosv; coeffsosw;  wk; vk]);
%[y1,y2] = meshgrid(6:0.1:19, 0:0.1:2.5);
%[y1,y2] = meshgrid(-10:0.1:10);
wk = double(wk);
wk
vk = double(vk);
vk
[yscale1,yscale2]=meshgrid(linspace(-1,1,1e2));

if scale == 0 
 y1 = (yscale1 - p(1))/a(1); y2 = (yscale2 - p(2))/a(2);
else
  y1 = (sqrt(2)*yscale1 - p(1))/a(1); y2 = (sqrt(2)*yscale2 - p(2))/a(2);
end

for alpha = 1:length(mons)
  beta = mons(alpha,:);
  b1 = beta(1); b2 = beta(2);
  G = G + wk(alpha).* yscale1.^beta(1) .* yscale2.^beta(2);
  %G = G + Jk(alpha).* (y1).^beta(1) .* (y2).^beta(2);
end
for i = 1:1e2
  for j = 1:1e2
%    if 1 <= yscale1(i, j)^2 + yscale2(i, j)^2
     if 1 <= (y1(i, j) + p(1)/a(1))^2*a(1)^2 + (y2(i, j) + p(2)/a(2))^2*a(2)^2
      G(i, j) = -1;
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
