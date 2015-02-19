close all;
clear all;
x = sdpvar(2,1);
y = sdpvar(2,1);
N = 1e4;
q = x(1)^4 + x(2)^4 + 2 * x(1)^2 * x(2)^2 + 7/2 * (x(1)^2 + x(2)^2) - (x(1)*x(2) + x(1) + x(2));
f1 = 1/20 * (4 * x(1)^3 + 4 * x(1) * x(2)^2 + 7 * x(1) - (x(2) + 1));
f2 = 1/20 * (4 * x(2)^3 + 4 * x(2) * x(1)^2 + 7 * x(2) - (x(1) + 1));

lo = [-1; -1]; up = [1; 1];
m1 = -1; M1 = 1; m2 = -1; M2 = 1;
g = [1 - x(1)^2 - x(2)^2];
f = [f1; f2];
%[y1, y2, Jk1]= exists(x, y, f1, f2, 1, 1, g, m1, M1, m2, M2, eps);
[y1, y2, Jk2]= exists(x, y, f, 2, 2, g, lo, up, eps);
[y1, y2, Jk3]= exists(x, y, f, 3, 3, g, lo, up, eps);
[y1, y2, Jk4]= exists(x, y, f, 4, 4, g, lo, up, eps);



m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end

[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);

F1 = []; F2 = []; dF1 = []; dF2 = [];
colormap(gray); for k = 1:N
 xp1 = rand; xp2 = rand;
 xp = [xp1; xp2];
 xp = -1 + 2 * xp;
 f1p = 1/20 * (4 * xp(1)^3 + 4 * xp(1) * xp(2)^2 + 7 * xp(1) - (xp(2) + 1));
 f2p = 1/20 * (4 * xp(2)^3 + 4 * xp(2) * xp(1)^2 + 7 * xp(2) - (xp(1) + 1));
 if 1 - xp(1)^2 - xp(2)^2 >= 0
   F1 = [F1 f1p]; F2 = [F2 f2p];
 end
end
%{
colormap(gray); for k = 1:N
 xp = randn(2,1);
 xp = xp/norm(xp);
 f1p = 1/20 * (4 * xp(1)^3 + 4 * xp(1) * xp(2)^2 + 7 * xp(1) - (xp(2) + 1));
 f2p = 1/20 * (4 * xp(2)^3 + 4 * xp(2) * xp(1)^2 + 7 * xp(2) - (xp(1) + 1));
 if 1 - xp(1)^2 - xp(2)^2 >= 0
   dF1 = [dF1 f1p]; dF2 = [dF2 f2p];
 end
end
%}

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
axis equal;
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/support/support_exists4.eps';

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
axis equal;
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/support/support_exists6.eps';


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
axis equal;
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/support/support_exists8.eps';

cd measureimage;
%[y1, y2, wk2]= measureimage(x, y, [f1; f2], 2, g, lo, up, 0);
[y1, y2, wk4]= measureimage(x, y, [f1; f2], 4, g, lo, up, 0);
[y1, y2, wk6]= measureimage(x, y, [f1; f2], 6, g, lo, up, 0);
[y1, y2, wk8]= measureimage(x, y, [f1; f2], 8, g, lo, up, 0);

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
axis equal;
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/support/support_measureimage4.eps';

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
axis equal;
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/support/support_measureimage6.eps';


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
axis equal;
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/support/support_measureimage8.eps';


cd ..;
