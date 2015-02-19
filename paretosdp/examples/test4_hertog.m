clear all; 
saveb = 1;
N = 100;
s = 1; d = 1; n = 2;
mpol('xlarge', n);
mpol('x', n);
mpol('xfree',n);
mpol u;
xlarge(1) = x(1) * 5; xlarge(2) = x(2) * 3; 
f1 = (xlarge(1)+xlarge(2)-7.5)^2 + (-xlarge(1)+xlarge(2)+3)^2/4;
f2 = (xlarge(1)-1)^2/4 + (xlarge(2)-4)^2/4;
f1free = (5*xfree(1)+3*xfree(2)-7.5)^2 + (-5*xfree(1)+3*xfree(2)+3)^2/4;
f2free = (5*xfree(1)-1)^2/4 + (3*xfree(2)-4)^2/4;

g1 = (xlarge(1)-2)^3/2 + xlarge(2) - 2.5 <=0;
g2 = xlarge(1) + xlarge(2) - 8 * (-xlarge(1)+xlarge(2)+0.65)^2 - 3.85 <=0;
b1 = x(1) >= 0; b2 = 1 >= x(1); 
b3 = x(2) >= 0; b4 = 1 >= x(2); 
Khat = [g1, g2, b1, b2, b3, b4]; 
[lo, xm1] = minglopt (x, n, f1, Khat, f1, 2); [up, xm2] = minglopt (x, n, f2, Khat, f1, 2);

%[lo1, up1] = minmax (x, n, f1, Khat, 2); [lo2, up2] = minmax (x, n, f2, Khat, 2);
%lo1 = 8; up1 = 8.1;
%lo = 1.2; up = 2.2;
Khatu = [Khat, u >= 0, 1 >= u];
lo = 7.5;
if saveb == 0
  [objhertog, f1opthertog, f2opthertog, goodlambda_hertog, badlam, udiscret] = pareto_sos_hertog_test (x, xfree, 2, N, n, f1, f2, f1free, f2free, Khat, lo, up);
  [pout_discret2] = pareto_sos_hertog (x, xfree, u, 2, 2, N, n, f1, f2, Khatu, lo, up);
  [pout_discret3] = pareto_sos_hertog (x, xfree, u, 3, 3, N, n, f1, f2, Khatu, lo, up);
  [pout_discret4] = pareto_sos_hertog (x, xfree, u, 4, 4, N, n, f1, f2, Khatu, lo, up);
  save('../figs/test4_hertog/save', 'objhertog', 'f1opthertog', 'f2opthertog', 'goodlambda_hertog', 'badlam', 'pout_discret2','pout_discret3', 'pout_discret4');
end
if saveb == 1
  objsave = load('../figs/test4_hertog/save.mat'); pout_discret2 = objsave.pout_discret2; pout_discret3 = objsave.pout_discret3; pout_discret4 = objsave.pout_discret4; 
  f1opthertog = objsave.f1opthertog; f2opthertog = objsave.f2opthertog; goodlambda_hertog =  objsave.goodlambda_hertog; badlam = objsave.badlam; objhertog = objsave.objhertog;
end

ustep = zeros(N+1, 1);

for step = 1:(N + 1)
  ustep(step) = lo + (step - 1)/ N * (up - lo);
end

%objsave = load('../figs/test4/save.mat'); %lamcheb = load('../figs/test4/savelamcheb.mat'); 
%f1optcheb = objsave.f1optcheb; f2optcheb = objsave.f2optcheb; 
%goodlambda_cheb = lamcheb.goodlambda_cheb;
eps2 = 0.03;
marksize = 10; markLine = 7; axesfont = 35; textfont=35; 
interp = 'Latex'; hpareto=figure('visible','off');set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(ustep, pout_discret2, 'linewidth', markLine); hold on;plot( f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog) + eps2, 'o', f1opthertog(badlam), f2opthertog(badlam), 'o', 'markersize', marksize, 'color',[0 0.5 0]); leg_pareto = legend('$q_4$', '$f_2^*$'); xlabel('$\lambda$', 'Interpreter',interp);  
%{xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);%}
set(leg_pareto,'Interpreter',interp); axis([5 20 0 2.5]); set(leg_pareto,'FontSize',textfont);  print -depsc '../figs/test4_hertog/test4_hertog2.eps'; hold off;

interp = 'Latex';  hpareto=figure('visible','off');set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot( ustep, pout_discret3, 'linewidth', markLine); hold on;plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog) + eps2, 'o', f1opthertog(badlam), f2opthertog(badlam), 'o', 'markersize', marksize, 'color',[0 0.5 0]);leg_pareto = legend('$q_6$', '$f_2^*$'); xlabel('$\lambda$', 'Interpreter',interp);  
%{xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);%} 
set(leg_pareto,'Interpreter',interp); axis([5 20 0 2.5]); set(leg_pareto,'FontSize',textfont); print -depsc '../figs/test4_hertog/test4_hertog3.eps'; hold off;

interp = 'Latex'; hpareto=figure('visible','off');set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); hold on; plot( ustep, pout_discret4, 'linewidth', markLine); plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog) + eps2, 'o', f1opthertog(badlam), f2opthertog(badlam), 'o', 'markersize', marksize, 'color',[0 0.5 0]);leg_pareto = legend('$q_8$', '$f_2^*$'); xlabel('$\lambda$', 'Interpreter',interp);  
%{xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);%}
set(leg_pareto,'Interpreter',interp); axis([5 20 0 2.5]); set(leg_pareto,'FontSize',textfont);  print -depsc '../figs/test4_hertog/test4_hertog4.eps'; hold off;

%plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', udiscret(badlam), objhertog(badlam), 'o','markersize', marksize); leg_pareto = legend('$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); axis([lo1 up1 1.2 2.2]); print -depsc '../figs/test4/test4_pareto_hertoglequ.eps';
%plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', f1opthertog(badlam), f2opthertog(badlam), 'o','markersize', marksize); leg_pareto = legend('$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); axis([lo1 up1 1.2 2.2]); print -depsc '../figs/test4/test4_pareto_hertogleqf1.eps';

%plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', objhertog(badlam), udiscret(badlam), 'o','markersize', marksize); leg_pareto = legend('$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); print -depsc '../figs/test4/test4_pareto_hertoglequ2.eps';
%plot(f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog), 'o', f1opthertog(badlam), f2opthertog(badlam), 'o','markersize', marksize); leg_pareto = legend('$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); print -depsc '../figs/test4/test4_pareto_hertogleqf2.eps';

%plot(ustep, pout_discret2, ustep, pout_discret3, ustep,  pout_discret4,  ustep,  pout_discret5, f1optcheb(goodlambda_cheb), f2optcheb(goodlambda_cheb), 'o','markersize', marksize); leg_pareto = legend('$q_{2, 2}$', '$q_{3, 2}$',  '$q_{4, 2}$', '$q_{5, 2}$', '$(f_1^*, f_2^*)$'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); print -depsc '../figs/test4/test4_pareto_hertog.eps';
