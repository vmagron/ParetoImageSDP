%%%%% Matlab/Yalmip implementation example using 
%%%%% the two first methods in the paper : 
%%%%% Approximating Pareto curves using semidefinite relaxations

clear all; 
N = 10;
s = 1; d = 1; n = 2;
mpol('x', n);
mpol('xfree',n);
mpol lambda;
mu = meas(x, lambda);
f1 = -x(1); f2 = x(1) + x(2)^2;
f1free = -xfree(1); f2free = xfree(1) + xfree(2)^2;
g1 = - x(1)^2 + x(2) >= 0;
g2 = - x(1) - 2 * x(2) + 3 >= 0;
g3 = 2 >= x(1)^2 + x(2)^2;
Khat = [g1, g2, g3];
cd ../scripts;

[m1, M1] = minmax (x, n, f1, Khat, 1); [m2, M2] = minmax (x, n, f2, Khat, 1);
im = 3;
Khatlambda = [Khat, lambda >= 0, 1 >= lambda];


%%%%% Allows to save data 
%save('../figs/ex11_4/save_all','obj','f1opt', 'f2opt', 'pout_discret2', 'p1_d2', 'p2_d2', 'pout_discret4', 'p1_d4', 'p2_d4', 'pout_discret6', 'p1_d6', 'p2_d6', 'pout_discret8', 'p1_d8', 'p2_d8'); 

%objsave = load('../figs/ex11_4/save_all.mat'); obj = objsave.obj; f1opt = objsave.f1opt; f2opt = objsave.f2opt; pout_discret2 = objsave.pout_discret2; p1_d2 =  objsave.p1_d2; p2_d2 = objsave.p2_d2;
%pout_discret4 = objsave.pout_discret4; p1_d4 =  objsave.p1_d4; p2_d4 = objsave.p2_d4;
%pout_discret6 = objsave.pout_discret6; p1_d6 =  objsave.p1_d6; p2_d6 = objsave.p2_d6;
%pout_discret8 = objsave.pout_discret8; p1_d8 =  objsave.p1_d8; p2_d8 = objsave.p2_d8;

%%%%% When no saving was done
%% First method
[pout_discret2, p1_d2, p2_d2, f1_d2, f2_d2, px2, mx2] = pareto_sos (x, xfree, lambda, 2, 2, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
[pout_discret4, p1_d4, p2_d4, f1_d4, f2_d4, px4, mx4] = pareto_sos (x, xfree, lambda, 2, 3, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
[pout_discret6, p1_d6, p2_d6, f1_d6, f2_d6, px6, mx6] = pareto_sos (x, xfree, lambda, 3, 4, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
%[pout_discret8, p1_d8, p2_d8, f1_d8, f2_d8, px8, mx8] = pareto_sos (x, xfree, lambda, 4, 5, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
%tic; [obj, x1, x2, f1opt, f2opt] = pareto_sos_test (x, 2, N, f1, f2, Khat); toc;

%% Second method 
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb2, f2cheb2] = pareto_sos_cheb (x, xfree, lambda, 2, 2, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2, inverse_method);
[out3, p1_d3_cheb, p2_d3_cheb, f1cheb3, f2cheb3] = pareto_sos_cheb (x, xfree, lambda, 3, 3, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2, inverse_method);
%[obj, x1, x2, f1opt, f2opt] = pareto_sos_cheb_test (x, xfree, 2, N, n, f1, f2, f1free, f2free, Khat, m1, M1, m2, M2);
for i = 1:(N + 1)
  xstep (i) = (i - 1) / N;
end

%%%% Plots 
%%%% WARNING!! Bugs occur with last versions of Matlab

interp = 'Latex'; axesfont = 35; textfont=35; marksize = 10; markLine = 7; 
hunder=figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);plot(xstep, pout_discret2, 'linewidth', markLine); hold on; plot(xstep, obj, 'o','markersize', marksize,  'color',[0 0.5 0]); leg_under = legend('$q_4$', '$f^1$',  'Location', 'NorthEast'); xlabel('$\lambda$', 'Interpreter',interp); set(leg_under,'Interpreter',interp); set(leg_under,'FontSize',textfont);  print -depsc '../figs/ex11_4/ex11_4_under2.eps'; hold off;
hunder=figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);plot(xstep, pout_discret4, 'linewidth', markLine); hold on; plot(xstep, obj, 'o','markersize', marksize, 'color',[0 0.5 0]); leg_under = legend('$q_6$', '$f^1$',  'Location', 'NorthEast'); xlabel('$\lambda$', 'Interpreter',interp); set(leg_under,'Interpreter',interp); set(leg_under,'FontSize',textfont); print -depsc '../figs/ex11_4/ex11_4_under4.eps'; hold off;


hpareto=figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont); set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(p1_d4(:, im), p2_d4(:, im), 'linewidth', markLine); hold on; plot(f1opt, f2opt, 'o','markersize', marksize,  'color',[0 0.5 0]); leg_pareto = legend('$(h_{4 1}, h_{4 2})$', '$(f_1^*, f_2^*)$'); 
%xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);
set(leg_pareto,'Interpreter',interp); set(gca,'XTick',(-1:0.4:1)); set(gca,'YTick',(-1:1:3));  set(leg_pareto,'FontSize',textfont); axis([-1 1 -1 3]); print -depsc '../figs/ex11_4/ex11_4_pareto4.eps'; hold off;

hpareto=figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont); set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(p1_d6(:, im), p2_d6(:, im), 'linewidth', markLine); hold on; plot(f1opt, f2opt, 'o','markersize', marksize,  'color',[0 0.5 0]); leg_pareto = legend('$(h_{6 1}, h_{6 2})$', '$(f_1^*, f_2^*)$'); 
%xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);
set(leg_pareto,'Interpreter',interp); set(gca,'XTick',(-1:0.4:1)); set(gca,'YTick',(-1:1:3)); set(leg_pareto,'FontSize',textfont); axis([-1 1 -1 3]);  print -depsc '../figs/ex11_4/ex11_4_pareto6.eps'; hold off;

hpareto=figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont); set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(p1_d8(:, im), p2_d8(:, im), 'linewidth', markLine); hold on; plot(f1opt, f2opt, 'o','markersize', marksize,  'color',[0 0.5 0]); leg_pareto = legend('$(h_{8 1}, h_{8 2})$', '$(f_1^*, f_2^*)$'); 
%xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);
set(leg_pareto,'Interpreter',interp); set(gca,'XTick',(-1:0.4:1)); set(gca,'YTick',(-1:1:3));  axis([-1 1 -1 3]); set(leg_pareto,'FontSize',textfont); print -depsc '../figs/ex11_4/ex11_4_pareto8.eps'; hold off;

%{
hpareto=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot(p1_d4(:, im), p2_d4(:, im), p1_d6(:, im), p2_d6(:, im), p1_d8(:,im),  p2_d8(:, im), f1opt, f2opt, 'o','markersize', marksize); leg_pareto = legend('$(h_{4, 1}, h_{4, 2})$', '$(h_{6, 1}, h_{6, 2})$', '$(h_{8, 1}, h_{8, 2})$', '$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); print -depsc '../figs/ex11_4/ex11_4_pareto.eps';
%}

hparetocheb = figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot(f1opt, f2opt, 'o','markersize', marksize); xlabel('y_1', 'Interpreter',interp); ylabel('y_2', 'Interpreter',interp); %axis([6 19 0 2.5]);
print -depsc '../figs/ex11_4/ex11_4_approx.eps';

%figure; plot(f1cheb2, f2cheb2, f1cheb3, f2cheb3, f1opt, f2opt);
cd ../examples;
