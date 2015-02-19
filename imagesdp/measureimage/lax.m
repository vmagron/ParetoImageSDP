clear all; close all;

m1 = -1; M1 = 1; m2 = -1; M2 = 1; 
lo = [m1; m2]; up = [M1; M2];


c = sdpvar(2,1); s = sdpvar(2,1); a = sdpvar(1,1); b = sdpvar(1,1);
g1 = c(1)^2 + s(1)^2 - 1; g2 = c(2)^2 + s(2)^2 - 1; 
g3 = -2 * c(2)*a^2*b^2 - 2 * c(1)*a^2*b^2 + 2 * a * b^3 * s(1)*s(2) + 2 * a^2 * b^2 * c(1)*c(2) + 2 * a^3 * b * s(1)*s(2) + a^2 * b^2 * c(1)^2*c(2)^2 + 3 * a^2*b^2 + 2 * c(1) * a^2 - 2 * c(1) * a^4 + 2 * c(2)*b^2 - 2 * c(2) * b^4 - a^2 - b^2 + b^4 + a^4 - a^2 * b^2 * c(2)^2 - a^2 * b^2 * c(1)^2 - 2 * a * b^3 * s(1) * s(2) * c(2) - 2 * a^3 * b * s(1) * s(2) * c(1) - a^2 * c(1)^2 + a^4 * c(1)^2 - b^2 * c(2)^2 + b^4 * c(2)^2;

g = [-g1 + 1e-1, -g1 - 1e-1, -g2 + 1e-1, -g2 - 1e-1, g3];

mps = 0.00; epsw = 0.00;
y = [a; b]; x = [c; s; y]; z = sdpvar(2,1);
f1 = y(1); f2 = y(2);
[y1, y2, wk2]= measureimage(x, z, [f1; f2], 2, g, lo, up, 0);
[y1, y2, wk3]= measureimage(x, z, [f1; f2], 3, g, lo, up, 0);
[y1, y2, wk4]= measureimage(x, z, [f1; f2], 4, g, lo, up, 0);
[y1, y2, wk5]= measureimage(x, z, [f1; f2], 5, g, lo, up, 0);
[y1, y2, wk6]= measureimage(x, z, [f1; f2], 6, g, lo, up, 0);
m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end
[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);
a = y1; b = y2;
G = a.^6 + 3 .* a.^4 .* b.^2 + 3 .* a.^2 .*b.^4 + b.^6 - 3.*a.^4 + 21.*a.^2.*b.^2 - 3.*b.^4 + 3 .* a.^2 + 3 .* b.^2 - 1;

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2, G ,[0 0],'y'); hold on; plot(X,Y,'.k'); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/lax/lax_test.eps';



hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk2 - 1 - epsw,[0 0],'y'); hold on; plot(X,Y,'.k'); 
%axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/lax/lax_measureimage2.eps';


hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk3 - 1 - epsw,[0 0],'y'); hold on; plot(X,Y,'.k'); 
%axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/lax/lax_measureimage3.eps';

