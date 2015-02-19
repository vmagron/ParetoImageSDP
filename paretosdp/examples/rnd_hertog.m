clear all; 
N = 100;
s = 1; d = 1; n = 5;
mpol('x', n);
mpol('xfree',n);
mpol u;
saveb = 1;
savernd = 1;
if savernd == 0
  A = randn(n,n,1); b = A * ones(n,1); S = b - A * x;
  Qn1 = randn(n,n,1); Qn2 = randn(n,n,1); q1 = randn(n, 1); q2 = randn(n, 1);
  Q1 = (triu(Qn1)+ triu(Qn1,1)')/2; Q2 = (triu(Qn2)+ triu(Qn2,1)')/2;
end
if savernd == 1 
  objsave = load('../figs/rnd/save.mat'); A =  objsave.A; b =  objsave.b; Q1 =  objsave.Q1; Q2 =  objsave.Q2; q1 =  objsave.q1; q2 =  objsave.q2;
end

if saveb == 1
  objsave = load('../figs/rnd/save.mat'); f1opthertog = objsave.f1opthertog; f2opthertog = objsave.f2opthertog; goodlambda_hertog =  objsave.goodlambda_hertog; badlam = objsave.badlam; objhertog = objsave.objhertog;
end
f1 = x' * Q1 * x / n^2 - q1' * x/n; f2 = x' * Q2' * x/n^2 - q2' * x/n;
f1free = xfree' * Q1 * xfree  / n^2  - q1' * xfree  / n; f2free = xfree' * Q2' * xfree  / n^2 - q2' * xfree  / n ;

Khat = [];
for i = 1:n
  Khat = [Khat, 1 - x(i)^2 >= 0];
%  Khat = [Khat, S(i)>=0];
end
%[lo1, up1] = minmax (x, n, f1, [Khat, x'*x <= n], 1);
% One compute lo1 = min_{x in Khat} f1; xm2 = min_{x in Khat} f2; up1 = f1 (xm2):
if saveb == 0 
  [lo1, xm1] = minglopt (x, n, f1, Khat, f1, 1); [up1, xm2] = minglopt (x, n, f2, Khat, f1, 1);
  save('../figs/rnd/savebnd','lo1','up1');
end

Khatu = [Khat, u >= 0, 1 - u >= 0];

ustep = zeros(N+1, 1);
if saveb == 0
  [objhertog, f1opthertog, f2opthertog, goodlambda_hertog, badlam, udiscret] = pareto_sos_hertog_test (x, xfree, 1, N, n, f1, f2, f1free, f2free, Khat, lo1, up1);
  save('../figs/rnd/save', 'A', 'b', 'Q1', 'Q2', 'q1', 'q2', 'objhertog', 'f1opthertog', 'f2opthertog', 'goodlambda_hertog', 'badlam');
  [pout_discret1] = pareto_sos_hertog (x, xfree, u, 1, 1, N, n, f1, f2, Khatu, lo1, up1);
  [pout_discret2] = pareto_sos_hertog (x, xfree, u, 2, 2, N, n, f1, f2, Khatu, lo1, up1);
  save('../figs/rnd/saveparam','pout_discret1','pout_discret2');
end

if saveb == 1
  bndsave = load('../figs/rnd/savebnd.mat'); lo1 = bndsave.lo1; up1 = bndsave.up1;
  paramsave = load('../figs/rnd/saveparam.mat'); pout_discret1 = paramsave.pout_discret1; pout_discret2 = paramsave.pout_discret2;
end

for step = 1:(N + 1)
  ustep(step) = lo1 + (step - 1)/ N * (up1 - lo1);
end

kmax = 1e5; axesfont = 35; textfont=35;  marksize = 10; markLine = 5;

%[f1plot, f2plot] = rnd_plot(kmax, Q1, Q2, q1, q2, n);
interp = 'Latex';
hunder=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot( ustep, pout_discret1, ustep, pout_discret2, f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), '--r', f1opthertog(badlam), f2opthertog(badlam), '--r', 'markersize',marksize);leg_pareto = legend('$q_2$', '$q_4$', '$f_2^*$'); xlabel('$\lambda$', 'Interpreter',interp); set(leg_pareto,'Interpreter',interp); print -depsc '../figs/rnd/rnd_hertog.eps';


interp = 'Latex'; hpareto=figure('visible','off');set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot( ustep, pout_discret1, 'linewidth', markLine); hold on;plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', f1opthertog(badlam), f2opthertog(badlam), 'o', 'markersize', marksize, 'color',[0 0.5 0]);leg_pareto = legend('$q_2$', '$f_2^*$'); xlabel('$\lambda$', 'Interpreter',interp);  
%{xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);%} 
set(leg_pareto,'Interpreter',interp); axis([-1.5 1 -1.5 0.5]); set(leg_pareto,'FontSize',textfont); print -depsc '../figs/rnd/rnd_hertog2.eps'; hold off;

interp = 'Latex'; hpareto=figure('visible','off');set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot( ustep, pout_discret2, 'linewidth', markLine); hold on; plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', f1opthertog(badlam), f2opthertog(badlam), 'o', 'markersize', marksize, 'color',[0 0.5 0]);leg_pareto = legend('$q_4$', '$f_2^*$'); xlabel('$\lambda$', 'Interpreter',interp);  
%{xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);%}
set(leg_pareto,'Interpreter',interp); axis([-1.5 1 -1.5 0.5]); set(leg_pareto,'FontSize',textfont); print -depsc '../figs/rnd/rnd_hertog4.eps'; hold off;



%[pout_discret3] = pareto_sos_hertog (x, xfree, u, 3, 3, N, n, f1, f2, Khatu, lo1, up1);
%[pout_discret4] = pareto_sos_hertog (x, xfree, u, 4, 4, N, n, f1, f2, Khatu, lo1, up1);
%[pout_discret5] = pareto_sos_hertog (x, xfree, u, 5, 5, N, n, f1, f2, Khatu, lo1, up1);

%objsave = load('../figs/test4/save.mat'); %lamcheb = load('../figs/test4/savelamcheb.mat'); 
%f1optcheb = objsave.f1optcheb; f2optcheb = objsave.f2optcheb; 
%goodlambda_cheb = lamcheb.goodlambda_cheb;

%{
interp = 'Latex'; axesfont = 25; marksize = 5;
hpareto=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
%plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', udiscret(badlam), objhertog(badlam), 'o','markersize', marksize); leg_pareto = legend('$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); axis([lo1 up1 1.2 2.2]); print -depsc '../figs/test4/test4_pareto_hertoglequ.eps';
%plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', f1opthertog(badlam), f2opthertog(badlam), 'o','markersize', marksize); leg_pareto = legend('$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); axis([lo1 up1 1.2 2.2]); print -depsc '../figs/test4/test4_pareto_hertogleqf1.eps';

plot(ustep, pout_discret1, ustep, pout_discret2, f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', f1opthertog(badlam), f2opthertog(badlam), 'o','markersize', marksize); leg_pareto = legend('$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); print -depsc '../figs/rnd/rnd_pareto_hertog.eps';

%plot(ustep, pout_discret2, ustep, pout_discret3, ustep,  pout_discret4,  ustep,  pout_discret5, f1optcheb(goodlambda_cheb), f2optcheb(goodlambda_cheb), 'o','markersize', marksize); leg_pareto = legend('$q_{2, 2}$', '$q_{3, 2}$',  '$q_{4, 2}$', '$q_{5, 2}$', '$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); print -depsc '../figs/rnd/rnd_pareto_hertog.eps';
%}
