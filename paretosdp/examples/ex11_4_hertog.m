clear all; 
N = 100;
s = 3; d = 3; n = 2;
mpol('x', n);
mpol('xfree',n);
mpol u;
mu = meas(x, u);
f1 = -x(1); f2 = x(1) + x(2)^2;
f1free = -xfree(1); f2free = xfree(1) + xfree(2)^2;
g1 = - x(1)^2 + x(2) >= 0;
g2 = - x(1) - 2 * x(2) + 3 >= 0;
g3 = 2 >= x(1)^2 + x(2)^2;
Khat = [g1, g2, g3];
cd ../aux;
[lo1, up1] = minmax (x, n, f1, Khat, 1); [lo2, up2] = minmax (x, n, f2, Khat, 1);
Khatu = [Khat, u >= 0, 1 >= u];

[pout_discret2] = pareto_sos_hertog (x, xfree, u, 2, 2, N, n, f1, f2, Khatu, lo1, up1);
[pout_discret3] = pareto_sos_hertog (x, xfree, u, 3, 3, N, n, f1, f2, Khatu, lo1, up1);

ustep = zeros(N+1, 1);

for step = 1:(N + 1)
  ustep(step) = lo1 + (step - 1)/ N * (up1 - lo1);
end

objsave = load('../figs/ex11_4/save_all.mat'); f1opt = objsave.f1opt; f2opt = objsave.f2opt;
interp = 'Latex'; axesfont = 25; marksize = 5;
hpareto=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot(ustep, pout_discret2, ustep, pout_discret3, f1opt, f2opt, 'o','markersize', marksize); leg_pareto = legend('$q_{2, 2}$', '$q_{3, 2}$', '$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); print -depsc '../figs/ex11_4/ex11_4_pareto_hertog.eps';

