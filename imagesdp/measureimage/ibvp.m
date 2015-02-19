clear all; close all;

%m1 = 6.5; m2 = -1; M1 = 20; M2 = 4; strsave = '../../figs/test4/save_allscale.mat';  % allscale
m1 = -1/sqrt(2); M1 = 1/sqrt(2); m2 = -1/sqrt(2); M2 = 1/sqrt(2); 
lambda = sdpvar(2,1); nu = sdpvar(2,1); ksi = sdpvar(2,1);
as = sdpvar(2,1);
g1 = lambda(1)^2 - lambda(2)^2 - nu(1)^2 + nu(2)^2 + ksi(1)^2 - 2 *  ksi(1) *  ksi(2) + ksi(2)^2;
g2 = 2 * lambda(1) * lambda(2) - 2 *  nu(1) *  nu(2);
g3 = - lambda(1) +  nu(1) + ksi(1) * 2 * as(2) - ksi(2) * 2 * as(1);
g4 = - lambda(2) +  nu(2) - ksi(1) * 2 * as(2) + ksi(2) * 2 * as(1);
g5 = lambda(1)^2 + lambda(2)^2 + ksi(1)^2 + ksi(2)^2 + nu(1)^2 + nu(2)^2 -1;
g6 = lambda(1); g7 = -nu(1);

g = [g1, -g1, g2, -g2, g3, -g3, g4, -g4, g5, -g5, g6, g7];

emps = 0.00; epsw = 0.00;
lo = [m1; m2]; up = [M1; M2];
y = as; x = [lambda; nu; ksi; y]; z = sdpvar(2,1);
f1 = as(1); f2 = as(2);
[y1, y2, wk2]= measureimage(x, z, [f1; f2], 2, g, lo, up, eps);
[y1, y2, wk3]= measureimage(x, z, [f1; f2], 3, g, lo, up, eps);
%[y1, y2, wk4]= measureimage(x, z, [f1; f2], 4, g, lo, up, eps);
%[y1, y2, wk5]= measureimage(x, z, [f1; f2], 5, g, lo, up, eps);
%[y1, y2, wk6]= measureimage(x, z, [f1; f2], 6, g, lo, up, eps);
m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end

[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);
hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk2 - 1 - epsw,[0 0],'y'); hold on; plot(X,Y,'.k'); 
%axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/ibvp/ibvp_measureimage2.eps';

