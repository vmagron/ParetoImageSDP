close all;
clear all;

x = sdpvar(3, 1);
%x = sdpvar(2, 1);

y = sdpvar(3,1);
N = 1e3;
f1 = x(1); f2 = x(2); f3 = x(3);
lo = [-1; -1; -1]; up = [1; 1; 1];
m1 = -1; M1 = 1; m2 = -1; M2 = 1;
g1 = (x(1) + 1)^2 + x(2)^2 + x(3)^2 - 1/4; g2 = (x(1) - 1)^2 + x(2)^2 + x(3)^2 - 1/4;
g3 = (x(2) + 1)^2 + x(1)^2 + x(3)^2 - 1/4; g4 = (x(2) - 1)^2 + x(1)^2 + x(3)^2 - 1/4;

g = [1 - x(1)^2 - x(2)^2 - x(3)^2, g1, g2];
%g = [1 - x(1)^2 - x(2)^2, (x(1) + 1)^2 + x(2)^2 - 1/4, (x(1) - 1)^2 + x(2)^2 - 1/4];
f = [f1; f2; f3];

[y1, y2, y3, Jk1]= exists(x, y, f, 1, 1, g, lo, up, eps);
[y1, y2, y3, Jk2]= exists(x, y, f, 2, 2, g, lo, up, eps);
[y1, y2, y3, Jk3]= exists(x, y, f, 3, 3, g, lo, up, eps);
%[y1, y2, y3, Jk4]= exists(x, y, f, 4, 4, g, lo, up, eps);

m = length(f);
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end

[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);

F1 = []; F2 = []; dF1 = []; dF2 = [];
for k = 1:N
 xp1 = rand; xp2 = rand; xp3 = rand;
 xp = [xp1; xp2; xp3];
 xp = -1 + 2 * xp;
 if ((1 - xp(1)^2 - xp(2)^2 - xp(3)^2 >= 0) &&  ((xp(1) + 1)^2 + xp(2)^2 + xp(3)^2 - 1/4 >= 0) && ((xp(1) - 1)^2 + xp(2)^2 + xp(3)^2 - 1/4) >= 0)
% if ((1 - xp(1)^2 - xp(2)^2 >= 0) &&  ((xp(1) + 1)^2 + xp(2)^2 - 1/4 >= 0) && ((xp(1) - 1)^2 + xp(2)^2 - 1/4) >= 0)
   F1 = [F1 xp(1)]; F2 = [F2 xp(2)];
 end
end
%{
for k = 1:N
 xp = randn(3,1);
 xp = xp/norm(xp);
 if 1 - xp(1)^2 - xp(2)^2 - xp(3)^2 >= 0 &&  (xp(1) + 1)^2 + xp(2)^2 + xp(3)^2 - 1/4 >= 0 && (xp(1) - 1)^2 + xp(2)^2 + xp(3)^2 - 1/4 >= 0
% if ((1 - xp(1)^2 - xp(2)^2 >= 0) &&  ((xp(1) + 1)^2 + xp(2)^2 - 1/4 >= 0) && ((xp(1) - 1)^2 + xp(2)^2 - 1/4) >= 0)
   dF1 = [dF1 xp(1)]; dF2 = [dF2 xp(2)];
 end
end
%}

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = Jk1;
varJ = max(max(max(J)))-min(min(min(J)));
%varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contour3(y1,y2, y3, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contour3(y1,y2, y3, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.b','markersize',5); plot(dF1,dF2,'.r','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../figs/proj/proj_exists2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = Jk2;
varJ = max(max(max(J)))-min(min(min(J)));
if varJ > 1e-6
  contour3(y1,y2, y3, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contour3(y1,y2, y3, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
%plot(X,Y,'.k'); plot(F1,F2,'.b','markersize',5); plot(dF1,dF2,'.r','markersize',5);
axis equal; %axis([lo(1) up(1) lo(2) up(2)]); 
%xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); 
print -depsc '../figs/proj/proj_exists4.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = Jk3;
varJ = max(max(max(J)))-min(min(min(J)));
%varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2,y3, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.b','markersize',5); plot(dF1,dF2,'.r','markersize',5);
axis equal; %axis([lo(1) up(1) lo(2) up(2)]); 
%xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); 
print -depsc '../figs/proj/proj_exists6.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = Jk4;
varJ = max(max(max(J)))-min(min(min(J)));
if varJ > 1e-6
  contourf(y1,y2,y3, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, y3, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.b','markersize',5); plot(dF1,dF2,'.r','markersize',5);
axis equal; %axis([lo(1) up(1) lo(2) up(2)]); 
%xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); 
print -depsc '../figs/proj/proj_exists8.eps';

cd measureimage;

%z = sdpvar(2, 1); g = [g, z(1) - f1, f1 - z(1), z(2) - f2, f2 - z(2)]; x = [x; z];
z1 = f1; z2 = f2;
[y1, y2, wk2]= measureimage(x, y, [z1; z2], 2, g, lo, up, 0);
[y1, y2, wk4]= measureimage(x, y, [z1; z2], 4, g, lo, up, 0);
[y1, y2, wk6]= measureimage(x, y, [z1; z2], 6, g, lo, up, 0);
[y1, y2, wk8]= measureimage(x, y, [z1; z2], 8, g, lo, up, 0);

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = 1 - wk2;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.b','markersize',5); plot(dF1,dF2,'.r','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/proj/proj_measureimage2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = 1 - wk4;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.b','markersize',5); plot(dF1,dF2,'.r','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/proj/proj_measureimage4.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = 1 - wk6;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.b','markersize',5); plot(dF1,dF2,'.r','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/proj/proj_measureimage6.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = 1 - wk8;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
plot(X,Y,'.k'); plot(F1,F2,'.b','markersize',5); plot(dF1,dF2,'.r','markersize',5);
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/proj/proj_measureimage8.eps';

cd ..;
