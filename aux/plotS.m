kmax = 1e4; axesfont = 25; marksize = 10;
[f1plot, f2plot, x1plot, x2plot] = ex11_4_plot(10 * kmax);
interp = 'Latex';
hunder=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot(x1plot, x2plot, '.r','markersize',marksize); xlabel('$x_1$', 'Interpreter',interp); ylabel('$x_2$', 'Interpreter',interp); print -depsc '../figs/ex11_4/ex11_4_plotS.eps';
plot(f1plot, f2plot, '.r','markersize',marksize); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);  print -depsc '../figs/ex11_4/ex11_4_plotfS.eps';

[f1plot, f2plot, x1plot, x2plot] = test4_plot(kmax, 0);
hunder=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
 plot(x1plot, x2plot, '.r','markersize',marksize); xlabel('$x_1$', 'Interpreter',interp);set(gca,'XTick',(0:1.3:3.9)); set(gca,'YTick',(0:1:3)); ylabel('$x_2$', 'Interpreter',interp);  print -depsc '../figs/test4/test4_plotS.eps';
plot(f1plot, f2plot, '.r','markersize',marksize); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp); set(gca,'YTick',(0:2:6)); print -depsc '../figs/test4/test4_plotfS.eps';

%{
s = 'drawing zoom for test4';
s

[f1plot, f2plot, x1plot, x2plot] = test4_plot(1000 * kmax, 1);
hunder=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
 plot(x1plot, x2plot, '.r','markersize',marksize); xlabel('$x_1$', 'Interpreter',interp); ylabel('$x_2$', 'Interpreter',interp);  print -depsc '../figs/test4/test4_plotS.eps';
plot(f1plot, f2plot, '.r','markersize',marksize); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp); print -depsc '../figs/test4/test4_plotfSzoom.eps';
%}
