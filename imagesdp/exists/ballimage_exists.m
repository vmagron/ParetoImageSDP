close all;
clear all;
x = sdpvar(2,1);
y = sdpvar(2,1);
N = 1e4;
f=[x(1)+x(1)*x(2); x(2)-x(1)^3]/2;
lo = [-1; -1]; up = [1; 1];
f1 = f(1); f2 = f(2);
m1 = -1; M1 = 1; m2 = -1; M2 = 1;
g = [1 - x(1)^2 - x(2)^2];
f = [f1; f2];
[y1, y2, Jk1]= exists(x, y, f, 1, 1, g, lo, up, eps);
[y1, y2, Jk2]= exists(x, y, f, 2, 2, g, lo, up, eps);
[y1, y2, Jk3]= exists(x, y, f, 3, 3, g, lo, up, eps);
[y1, y2, Jk4]= exists(x, y, f, 4, 4, g, lo, up, eps);
m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end

[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = Jk1;
varJ = max(max(J))-min(min(J));
%if varJ > 1e-6
%  contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on;
%else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
%end
%contour(y1,y2, -J, [0 0],'y'); hold on; 
colormap(gray);
hold on;
for k = 1:N
 x = randn(2,1);
 x = rand*x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.k','markersize',5);
end
%{
colormap(gray); for k = 1:N
 x = randn(2,1);
 x = x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.r','markersize',5);
end
%}
plot(X,Y,'.k'); 
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps '../figs/ballimage/ballimage_exists2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = Jk2;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on; 
end
%contour(y1,y2, -J, [0 0],'y'); hold on; 
hold on;
for k = 1:N
 x = randn(2,1);
 x = rand*x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.k','markersize',5);
end
%{
colormap(gray); for k = 1:N
 x = randn(2,1);
 x = x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.r','markersize',5);
end
%}
plot(X,Y,'.k');
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/ballimage/ballimage_exists4.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = Jk3;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on; 
end
%contour(y1,y2, -J, [0 0],'y'); hold on; 
hold on;
for k = 1:N
 x = randn(2,1);
 x = rand*x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.k','markersize',5);
end
%{
colormap(gray); for k = 1:N
 x = randn(2,1);
 x = x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.r','markersize',5);
end
%}
plot(X,Y,'.k');
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/ballimage/ballimage_exists6.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = Jk4;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on; 
end
%contour(y1,y2, -J, [0 0],'y'); hold on; 
hold on;
for k = 1:N
 x = randn(2,1);
 x = rand*x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.k','markersize',5);
end
%{
for k = 1:N
 x = randn(2,1);
 x = x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.r','markersize',5);
end
%}
plot(X,Y,'.k');
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/ballimage/ballimage_exists8.eps';

%{
hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
J = Jk5;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
contourf(y1,y2, 0.2-J, [0.2 0.2],'y'); hold on; 
end
%contour(y1,y2, -J, [0 0],'y'); hold on; 
hold on;
colormap(gray); for k = 1:N
 x = randn(2,1);
 x = rand*x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.b','markersize',5);
end
colormap(gray); for k = 1:N
 x = randn(2,1);
 x = x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.r','markersize',5);
end
plot(X,Y,'.k');
axis equal; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/ballimage/ballimage_exists5.eps';
%}
