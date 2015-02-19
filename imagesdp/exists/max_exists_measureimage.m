close all;
clear all;
liftexists = 0;
liftmeasureimage = 1;
x = sdpvar(2,1);
y = sdpvar(2,1);
N = 1e4;
p1 = (x(1)+x(1)*x(2))/3;
p2 = x(1)^2/3;
q1 = (x(2)-x(1)^3)/3;
%q2 = (x(2)^2 - x(1))/3;
p12 = sdpvar(1,1);
%q12 = sdpvar(1,1);

f1 = (p1 + p2 - p12)/2;
%f2 = (q1 + q2 - q12)/2;
f2 = q1;
g1 = p12^2 - (p1 - p2)^2;
%g2 = q12 - (q1 - q2)^2;

lo = [-1; -1]; up = [1; 1];
m1 = -1; M1 = 1; m2 = -1; M2 = 1;

if liftexists == 0
  g = [1 - x(1)^2 - x(2)^2, p12, 2 - x(1)^2 - x(2)^2 - p12^2, g1, -g1];
  xf = [x; p12];
  f = [f1; f2];
else
  z = sdpvar(2, 1);
  g = [1 - x(1)^2 - x(2)^2, p12, 2 - x(1)^2 - x(2)^2 - p12^2, g1, -g1, z(1) - f1, f1 - z(1), z(2) - f2, f2 - z(2)];
  xf = [x; p12; z];
  f = [z(1); z(2)];
end

[y1, y2, Jk1]= exists(xf, y, f, 1, 1, g, lo, up, eps);
[y1, y2, Jk2]= exists(xf, y, f, 2, 2, g, lo, up, eps);
[y1, y2, Jk3]= exists(xf, y, f, 3, 3, g, lo, up, eps);
[y1, y2, Jk4]= exists(xf, y, f, 4, 4, g, lo, up, eps);

m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end

[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);

F1 = []; F2 = []; dF1 = []; dF2 = [];
for k = 1:N
 xp1 = rand; xp2 = rand;
 xp = [xp1; xp2];
 xp = -1 + 2 * xp;
 p1 = (xp(1)+xp(1)*xp(2))/3;
 p2 = xp(1)^2/3;
 q1 = (xp(2)-xp(1)^3)/3;
 if 1 - xp(1)^2 - xp(2)^2 >= 0
   F1 = [F1 min(p1, p2)]; F2 = [F2 q1];
 end
end
%{
for k = 1:N
 xp = randn(2,1);
 xp = xp/norm(xp);
 p1 = (xp(1)+xp(1)*xp(2))/3;
 p2 = xp(1)^2/3;
 q1 = (xp(2)-xp(1)^3)/3;
 if 1 - xp(1)^2 - xp(2)^2 >= 0
   dF1 = [dF1 min(p1, p2)]; dF2 = [dF2 q1];
 end
end
%}

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = Jk1;
varJ = max(max(J))-min(min(J));
%if varJ > 1e-6
%  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
%else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
%end
plot(X,Y,'.k'); plot(F1,F2,'.k','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/max/max_exists2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = Jk2;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.k','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/max/max_exists4.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = Jk3;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.k','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/max/max_exists6.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = Jk4;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.k','markersize',5); 
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/max/max_exists8.eps';

cd measureimage;

if liftmeasureimage == 0
  g = [1 - x(1)^2 - x(2)^2, p12, 2 - x(1)^2 - x(2)^2 - p12^2, g1, -g1];
  xf = [x; p12];
  f = [f1; f2];
else
  z = sdpvar(2, 1);
  g = [1 - x(1)^2 - x(2)^2, p12, 2 - x(1)^2 - x(2)^2 - p12^2, g1, -g1, z(1) - f1, f1 - z(1), z(2) - f2, f2 - z(2)];
  xf = [x; p12; z];
  f = [z(1); z(2)];
end

[y1, y2, wk2]= measureimage(xf, y, f, 2, g, lo, up, 0, 0);
[y1, y2, wk4]= measureimage(xf, y, f, 4, g, lo, up, 0, 0);
[y1, y2, wk6]= measureimage(xf, y, f, 6, g, lo, up, 0, 0);
[y1, y2, wk8]= measureimage(xf, y, f, 8, g, lo, up, 0, 0);

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = 1 - wk2;
varJ = max(max(J))-min(min(J));
%if varJ > 1e-6
%  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
%else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
%end
plot(X,Y,'.k'); plot(F1,F2,'.k','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/max/max_measureimage2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = 1 - wk4;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.k','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/max/max_measureimage4.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = 1 - wk6;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.k','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/max/max_measureimage6.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = 1 - wk8;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.k','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/max/max_measureimage8.eps';

cd ..;
