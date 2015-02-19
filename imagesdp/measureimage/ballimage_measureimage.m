close all;
clear all;
liftmeasureimage = 0;
x = sdpvar(2,1);
y = sdpvar(2,1);
N = 1e4;
f1 = (x(1)+x(1)*x(2))/2; f2 =  (x(2)-x(1)^3)/2;
lo = [-1; -1]; up = [1; 1];

if liftmeasureimage == 0
  g = [1 - x(1)^2 - x(2)^2];
  xf = x;
  f = [f1; f2];
else
  g = [1 - x(1)^2 - x(2)^2, y(1) - f1, f1 - y(1), y(2) - f2, f2 - y(2)];
  xf = [x; y];
  f = [y(1); y(2)];
end

if liftmeasureimage == 0
  [y1, y2, wk2]= measureimage(xf, y, f, 2, g, lo, up, 0, 0);
  [y1, y2, wk4]= measureimage(xf, y, f, 4, g, lo, up, 0, 0);
  [y1, y2, wk6]= measureimage(xf, y, f, 6, g, lo, up, 0, 0);
  [y1, y2, wk8]= measureimage(xf, y, f, 8, g, lo, up, 0, 0);
else
  cd ..;
  [y1, y2, wk2]= proj_special(xf, f, 1, 1, g, lo, up);
  [y1, y2, wk4]= proj_special(xf, f, 2, 2, g, lo, up);
  [y1, y2, wk6]= proj_special(xf, f, 3, 3, g, lo, up);
  [y1, y2, wk8]= proj_special(xf, f, 4, 4, g, lo, up);
  cd measureimage;
end

m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end

[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
colormap(gray);
J = wk2;
varJ = max(max(J))-min(min(J));
if varJ > 1e-6
  contourf(y1,y2, J - 1, [0 0],'y'); hold on;
else
  contourf(y1,y2, 0.2 + (1 - y1.^2 - y2.^2) , [0.2 0.2],'y'); hold on;
end
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
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/ballimage/ballimage_measureimage2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk4 - 1,[0 0],'y'); hold on; 
colormap(gray); for k = 1:N
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
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/ballimage/ballimage_measureimage4.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk6 - 1,[0 0],'y'); hold on; 
colormap(gray); for k = 1:N
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
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/ballimage/ballimage_measureimage6.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk8 - 1,[0 0],'y'); hold on; 
colormap(gray); for k = 1:N
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
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/ballimage/ballimage_measureimage8.eps';

%{
hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk6 - 1,[0 0],'y'); hold on; 
colormap(gray); for k = 1:N
 x = randn(2,1);
 x = rand*x/norm(x);
 f1 = (x(1)+x(1)*x(2))/2;
 f2 = (x(2)-x(1)^3)/2;
 plot(f1,f2,'.k','markersize',5);
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
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/ballimage/ballimage_measureimage6.eps';
%}
