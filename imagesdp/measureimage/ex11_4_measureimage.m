close all;
clear all;
x = sdpvar(2,1);
y = sdpvar(2,1);
f1 = -x(1); 
f2 = x(1) + x(2)^2;
g1 = - x(1)^2 + x(2);
g2 = - x(1) - 2 * x(2) + 3;
g = [g1, g2, 2 - x(1)^2 - x(2)^2];
lo = [-1; -1]; up = [1; 2];
[y1, y2, wk2]= measureimage(x, y, [f1; f2], 2, g, lo, up, 0);
[y1, y2, wk3]= measureimage(x, y, [f1; f2], 3, g, lo, up, 0);
[y1, y2, wk4]= measureimage(x, y, [f1; f2], 4, g, lo, up, 0);
m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end

[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);

y1p = -1:0.01:1/2*2^(1/3);

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk2 - 1,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(y1p,-y1p+y1p.^4,'k');
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/ex11_4/ex11_4_measureimage2.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk3 - 1,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(y1p,-y1p+y1p.^4,'k');
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/ex11_4/ex11_4_measureimage3.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2,wk4 - 1,[0 0],'y'); hold on; plot(X,Y,'.k'); plot(y1p,-y1p+y1p.^4,'k');
axis([lo(1) up(1) lo(2) up(2)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/ex11_4/ex11_4_measureimage4.eps';
