clear all;
zoom = 1;
%m1 = 7.251; m2 = 0.25; M1 = 8.2; M2 = 5.836; % left
%m1 = 7.251; m2 = -0.5; M1 = 8.5; M2 = 4.5;    % leftscale

%m1 = 7.251; m2 = 0.25; M1 = 19; M2 = 5.836;  % all
%m1 = 6.5; m2 = -1; M1 = 20; M2 = 4;          % allscale
%m1 = 10; m2 = 1; M1 = 12; M2 = 2;
%m1 = 14; m2 = 1; M1 = 15.5; M2 = 2.3;

if zoom == 0
 m1 = 6.5; m2 = -1; M1 = 20; M2 = 4;
else
 m1 = 12; m2 = 1.3; M1 = 15.5; M2 = 2.3;
end
lo = [m1; m2]; up = [M1; M2];
N = 1e4;
n = 2;
mpol('xlarge', n);
mpol('x', n);
mpol('xfree',n);
mpol lambda;
xlarge(1) = x(1) * 5; xlarge(2) = x(2) * 3; 
f1 = (xlarge(1)+xlarge(2)-7.5)^2 + (-xlarge(1)+xlarge(2)+3)^2/4
f2 = (xlarge(1)-1)^2/4 + (xlarge(2)-4)^2/4 
f1free = (5*xfree(1)+3*xfree(2)-7.5)^2 + (-5*xfree(1)+3*xfree(2)+3)^2/4
f2free = (5*xfree(1)-1)^2/4 + (3*xfree(2)-4)^2/4 

g1 = (xlarge(1)-2)^3/2 + xlarge(2) - 2.5 <=0;
g2 = xlarge(1) + xlarge(2) - 8 * (-xlarge(1)+xlarge(2)+0.65)^2 - 3.85 <=0;
mu = meas(x, lambda);
b1 = x(1) >= 0; b2 = 1 >= x(1); 
b3 = x(2) >= 0; b4 = 1 >= x(2); 
Khat = [g1, g2, b1, b2, b3, b4]; 

%[obj, x1, x2, f1optcheb, f2optcheb, f1fake, f2fake, badlambda_cheb, mxcheb] = pareto_sos_cheb_test (x, xfree, 2, N, n, f1, f2, f1free, f2free, Khat, m1, M1, m2, M2);
eps = 1e-2;
x = sdpvar(2,1);
y = sdpvar(2,1);
%f1 = (5*x(1)+3*x(2)-7.5)^2 + (-5*x(1)+3*x(2)+3)^2/4;
%f2 = (5*x(1)-1)^2/4 + (3*x(2)-4)^2/4;
%g1 = - ( (5*x(1)-2)^3/2 + 3 * x(2) - 2.5);
%g2 = - (5 * x(1) + 3 * x(2) - 8 * (-5 * x(1)+ 3 * x(2)+0.65)^2 - 3.85);
%g = [g1, g2, x(1)*(1 - x(1)), x(2)*(1 - x(2))];

f1 = (2.5*(x(1)+1)+1.5*(x(2)+1)-7.5)^2 + (-2.5*(x(1)+1)+1.5*(x(2)+1)+3)^2/4;
f2 = (2.5*(x(1)+1)-1)^2/4 + (1.5*(x(2)+1)-4)^2/4;
g1 = - ( (2.5*(x(1)+1)-2)^3/2 + 1.5 * (x(2)+1) - 2.5);
g2 = - (2.5 * (x(1)+1) + 1.5 * (x(2)+1) - 8 * (-2.5 * (x(1)+1)+ 1.5 * (x(2)+1)+0.65)^2 - 3.85);
g = [g1, g2, 2 - x(1)^2 - x(2)^2];
f = [f1; f2];

if zoom == 0
  [y1, y2, Jk1]= exists(x, y, f, 1, 1, g, lo, up, eps);
  [y1, y2, Jk2]= exists(x, y, f, 2, 2, g, lo, up, eps);
  [y1, y2, Jk3]= exists(x, y, f, 3, 3, g, lo, up, eps);
else
  [y1, y2, Jk5]= exists(x, y, f, 5, 5, g, lo, up, eps);
end
[y1, y2, Jk4]= exists(x, y, f, 4, 4, g, lo, up, eps);

%save('../figs/test4/save_left','f1optcheb', 'f2optcheb', 'Jk2', 'Jk3', 'Jk4', 'Jk5', 'Jk6');
%save('../figs/test4/save_leftscale','f1optcheb', 'f2optcheb', 'Jk2', 'Jk3', 'Jk4', 'Jk5', 'Jk6');

%save('../figs/test4/save_all','f1optcheb', 'f2optcheb', 'Jk2', 'Jk3', 'Jk4', 'Jk5', 'Jk6');
%save('../figs/test4/save_allscale','f1optcheb', 'f2optcheb', 'Jk2', 'Jk3', 'Jk4', 'Jk5', 'Jk6');

%foptcheb = load('../figs/test4/save_leftscale.mat'); f1optcheb =foptcheb.f1optcheb; f2optcheb=foptcheb.f2optcheb; Jk2 = foptcheb.Jk2; Jk3 = foptcheb.Jk3; Jk4 = foptcheb.Jk4; Jk5 = foptcheb.Jk5; Jk6 = foptcheb.Jk6; 
foptcheb = load('../figs/test4/save_allscale.mat'); f1optcheb =foptcheb.f1optcheb; f2optcheb=foptcheb.f2optcheb;% Jk2 = foptcheb.Jk2; Jk3 = foptcheb.Jk3; Jk4 = foptcheb.Jk4; Jk5 = foptcheb.Jk5; Jk6 = foptcheb.Jk6; 

%foptcheb = load('../figs/test4/save_left.mat'); f1optcheb =foptcheb.f1optcheb; f2optcheb=foptcheb.f2optcheb; %Jk2 = foptcheb.Jk2; Jk3 = foptcheb.Jk3; Jk4 = foptcheb.Jk4; Jk5 = foptcheb.Jk5; Jk6 = foptcheb.Jk6; 
%foptcheb = load('../figs/test4/save_all.mat'); f1optcheb =foptcheb.f1optcheb; f2optcheb=foptcheb.f2optcheb; Jk2 = foptcheb.Jk2; Jk3 = foptcheb.Jk3; Jk4 = foptcheb.Jk4; Jk5 = foptcheb.Jk5; Jk6 = foptcheb.Jk6; 

a1 = 2  / (M1 - m1); p1 = - (M1 + m1)/(M1 - m1);
a2 = 2  / (M2 - m2); p2 = - (M2 + m2)/(M2 - m2);
[X,Y] = ellipse(1/a1,1/a2, [-p1/a1; -p2/a2], 50);
[f1plot, f2plot ] =  test4_plot (3 * 1e5, 0);
f1plotbis = []; f2plotbis = [];
for i = 1:length(f1plot)
  if (f1plot(i) + p1/a1)^2*a1^2 + (f2plot(i) + p2/a2)^2*a2^2 <= 1
    f1plotbis = [f1plot(i) f1plotbis]; f2plotbis = [f2plot(i) f2plotbis]; 
  end
end
f1plot = f1plotbis; f2plot = f2plotbis;

for i = 1:(N + 1)
  xstep (i) = (i - 1) / N;
end

if zoom == 0

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,-Jk1,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,-Jk2,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists4.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,-Jk3,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists6.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,-Jk4,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists8.eps';

else

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,-Jk4,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',10); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4zoom_exists8.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
colormap(gray);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,-Jk5,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',10); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4zoom_exists10.eps';

end
%hparetocheb = figure('visible','off'); contourf(y1,y2,-Jk2,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists2.eps';
%hparetocheb = figure('visible','off'); contourf(y1,y2,-Jk3,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists3.eps';
%hparetocheb = figure('visible','off'); contourf(y1,y2,-Jk4,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists4.eps';
%hparetocheb = figure('visible','off'); contourf(y1,y2,-Jk5,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists5.eps';
%hparetocheb = figure('visible','off'); contourf(y1,y2,-Jk6,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]); xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -deps2 '../figs/test4/test4_exists6.eps';


%figure; contourf(y1,y2,-Jk3,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]);  
%figure; contourf(y1,y2,-Jk4,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]);  
%figure; contourf(y1,y2,-Jk5,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]);  
%figure; contourf(y1,y2,-Jk6,[0 0],'y'); hold on; plot(f1optcheb, f2optcheb, '.b', 'markersize', 5); plot(X,Y,'.k'); plot(f1plot,f2plot,'.k','markersize',5); axis square; axis([m1 M1 m2 M2]);  
