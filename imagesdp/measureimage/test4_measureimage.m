clear all; close all;
%m1 = 7.251; m2 = 0.25; M1 = 8.2; M2 = 5.836; strsave =  '../../figs/test4/save_left.mat'; % left
%m1 = 7.251; m2 = -0.5; M1 = 8.5; M2 = 4.5; strsave =  '../../figs/test4/save_leftscale.mat';  % leftscale

%m1 = 7.251; m2 = 0.25; M1 = 19; M2 = 5.836; strsave =  '../../figs/test4/save_all.mat'; % all
m1 = 6.5; m2 = -1; M1 = 20; M2 = 4; strsave = '../../figs/test4/save_allscale.mat';  % allscale
%m1 = 10; m2 = 1; M1 = 12; M2 = 2;
n = 2;
%m1 = 7.8; m2 = 0.25; M1 = 8.2; M2 = 5; strsave = '../../figs/test4/save_allscale.mat'; 

%[obj, x1, x2, f1optcheb, f2optcheb, f1fake, f2fake, badlambda_cheb, mxcheb] = pareto_sos_cheb_test (x, xfree, 2, N, n, f1, f2, f1free, f2free, Khat, m1, M1, m2, M2);
x = sdpvar(2,1);
y = sdpvar(2,1);
%f1 = (5*x(1)+3*x(2)-7.5)^2 + (-5*x(1)+3*x(2)+3)^2/4;
%f2 = (5*x(1)-1)^2/4 + (3*x(2)-4)^2/4;
%g1 = - ( (5*x(1)-2)^3/2 + 3 * x(2) - 2.5);
%g2 = - (5 * x(1) + 3 * x(2) - 8 * (-5 * x(1)+ 3 * x(2)+0.65)^2 - 3.85);

f1 = (2.5*(x(1)+1)+1.5*(x(2)+1)-7.5)^2 + (-2.5*(x(1)+1)+1.5*(x(2)+1)+3)^2/4;
f2 = (2.5*(x(1)+1)-1)^2/4 + (1.5*(x(2)+1)-4)^2/4;
g1 = - ( (2.5*(x(1)+1)-2)^3/2 + 1.5 * (x(2)+1) - 2.5);
g2 = - (2.5 * (x(1)+1) + 1.5 * (x(2)+1) - 8 * (-2.5 * (x(1)+1)+ 1.5 * (x(2)+1)+0.65)^2 - 3.85);
g = [g1, g2, 2 - x(1)^2 - x(2)^2];

%g = [g1, g2, x(1)*(1 - x(1)), x(2)*(1 - x(2))];

eps = 0.00; epsw = 0.00;

lo = [m1; m2]; up = [M1; M2];
m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end
%f1 = (a(1)*f1 + p(1)); f2 = (a(2)*f2 + p(2)); lo = [-1; -1]; up = [1; 1]; m1 = -1; M1 = 1; m2 = -1; M2 = 1; g = [g, f1 - m1, M1 - f1, f2 - m2, M2 - f2]
z1 = f1; z2 = f2;

%z = sdpvar(2, 1); x = [x; z]; g = [g, z(1) - f1, f1 - z(1), z(2) - f2, f2 - z(2), z(1) - m1, M1 - z(1), z(2) - m2, M2 - z(2)]; z1 = z(1); z2 = z(2);
g = [g, z1 - m1, M1 - z1, z2 - m2, M2 - z2];
cd ..; [f1plot, f2plot ] =  test4_plot (3*1e5, 0); cd measureimage;

[y1, y2, wk2]= measureimage(x, y, [z1; z2], 2, g, lo, up, eps, 1);
[y1, y2, wk4]= measureimage(x, y, [z1; z2], 4, g, lo, up, eps, 1);
[y1, y2, wk6]= measureimage(x, y, [z1; z2], 6, g, lo, up, eps, 1);
[y1, y2, wk8]= measureimage(x, y, [z1; z2], 8, g, lo, up, eps, 1);


[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);
f1plotbis = []; f2plotbis = [];
for i = 1:length(f1plot)
  if (f1plot(i) + p(1)/a(1))^2*a(1)^2 + (f2plot(i) + p(2)/a(2))^2*a(2)^2 <= 1
    f1plotbis = [f1plot(i) f1plotbis]; f2plotbis = [f2plot(i) f2plotbis]; 
  end
end
f1plot = f1plotbis; f2plot = f2plotbis;

foptcheb = load(strsave); f1optcheb =foptcheb.f1optcheb; f2optcheb=foptcheb.f2optcheb;
%f1optcheb = (a(1)*f1optcheb(1) + p(1)); f2optcheb = (a(2)*f2optcheb(2) + p(2));


hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk2 - 1 - epsw,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5);  
axis square; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/test4/test4_measureimage2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk4 - 1 - epsw,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5);  
axis square; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/test4/test4_measureimage4.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk6 - 1 - epsw,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5);  
axis square; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/test4/test4_measureimage6.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1, y2, wk8 - 1 - epsw,[0 0],'y'); hold on; plot(X,Y,'.k');plot(f1plot,f2plot,'.k','markersize',5);  
axis square; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/test4/test4_measureimage8.eps';

%{
hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1, y2, wk10 - 1 - epsw,[0 0],'y'); hold on; plot(X,Y,'.k');plot(f1plot,f2plot,'.k','markersize',5); 
axis square; axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../../figs/test4/test4_measureimage10.eps';
%}
