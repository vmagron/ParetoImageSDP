clear all; 
N = 100;
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
[m1, M1] = minmax (x, n, f1, Khat, 2); [m2, M2] = minmax (x, n, f2, Khat, 2);
im = 4;

Khatlambda = [Khat, lambda >= 0, 1 >= lambda];


%%%%% When no saving was done
%[pout_discret2, p1_d2, p2_d2, f1_d2, f2_d2, px2, mx2] = pareto_sos (x, xfree, lambda, 2, 2, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
%[pout_discret4, p1_d4, p2_d4, f1_d4, f2_d4, px4, mx4] = pareto_sos (x, xfree, lambda, 4, 4, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
%[pout_discret6, p1_d6, p2_d6, f1_d6, f2_d6, px6, mx6] = pareto_sos (x, xfree, lambda, 6, 6, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
%[pout_discret8, p1_d8, p2_d8, f1_d8, f2_d8, px8, mx8] = pareto_sos (x, xfree, lambda, 8, 8, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
%[obj, x1, x2, f1opt, f2opt, goodlambda] = pareto_sos_test (x, 2, N, f1, f2, Khat);
%save('../figs/test4/savelam','goodlambda');

%[out3, p1_d3_chebL, p2_d3_chebL, f1cheb3, f2cheb3] = pareto_sos_cheb (x, xfree, lambda, 3, 3, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2, im);
%[out4, p1_d4_chebL, p2_d4_chebL, f1cheb4, f2cheb4, pxlam4, mx] = pareto_sos_cheb (x, xfree, lambda, 4, 4, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2, im);
%[out5, p1_d5_chebL, p2_d5_chebL, f1cheb5, f2cheb5, pxlam5, mx] = pareto_sos_cheb (x, xfree, lambda, 5, 5, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2, im);
%tic; [objcheb, x1, x2, f1optcheb, f2optcheb, f1fake, f2fake, goodlambda_cheb, mxcheb] = pareto_sos_cheb_test (x, xfree, 2, N, n, f1, f2, f1free, f2free, Khat, m1, M1, m2, M2); toc;
%save('../figs/test4/save','obj','f1opt', 'f2opt', 'pout_discret2', 'p1_d2', 'p2_d2', 'pout_discret4', 'p1_d4', 'p2_d4', 'pout_discret6', 'p1_d6', 'p2_d6', 'pout_discret8', 'p1_d8', 'p2_d8', 'f1optcheb', 'f2optcheb','p1_d3_chebL', 'p2_d3_chebL', 'p1_d4_chebL', 'p2_d4_chebL', 'p1_d5_chebL', 'p2_d5_chebL'); 
%save('../figs/test4/savelamcheb','goodlambda_cheb');

objsave = load('../figs/test4/save.mat');  lam = load('../figs/test4/savelam.mat'); lamcheb = load('../figs/test4/savelamcheb.mat'); obj = objsave.obj; f1opt = objsave.f1opt; f2opt = objsave.f2opt; pout_discret2 = objsave.pout_discret2; p1_d2 =  objsave.p1_d2; p2_d2 = objsave.p2_d2;
pout_discret4 = objsave.pout_discret4; p1_d4 =  objsave.p1_d4; p2_d4 = objsave.p2_d4;
pout_discret6 = objsave.pout_discret6; p1_d6 =  objsave.p1_d6; p2_d6 = objsave.p2_d6;
pout_discret8 = objsave.pout_discret8; p1_d8 =  objsave.p1_d8; p2_d8 = objsave.p2_d8;
f1optcheb = objsave.f1optcheb; f2optcheb = objsave.f2optcheb; goodlambda = lam.goodlambda; goodlambda_cheb = lamcheb.goodlambda_cheb;
p1_d3_chebL = objsave.p1_d3_chebL; p2_d3_chebL = objsave.p2_d3_chebL; 
p1_d4_chebL = objsave.p1_d4_chebL; p2_d4_chebL = objsave.p2_d4_chebL; 
p1_d5_chebL = objsave.p1_d5_chebL; p2_d5_chebL = objsave.p2_d5_chebL;


for i = 1:(N + 1)
  xstep (i) = (i - 1) / N;
end

%figure;plot(xstep, pxlam4(:,1),xstep, x1);
%figure;plot(xstep, pxlam4(:,2),xstep, x2);
%figure;plot(xstep, pxlam5(:,1),xstep, x1);
%figure;plot(xstep, pxlam5(:,2),xstep, x2);
%figure; plot(f1fake, f2fake, f1optcheb, f2optcheb);
%plot(xstep, pout_discret2, xstep, pout_discret3, xstep, obj);
%figure; plot(f1_d2, f2_d2, f1_d3, f2_d3, f1_d4, f2_d4, f1opt, f2opt)
%figure; plot(f1cheb2, f2cheb2, f1cheb3, f2cheb3, f1cheb4, f2cheb4, f1opt, f2opt);
%figure; plot(p1_d3_cheb, p2_d3_cheb, f1cheb3, f2cheb3, f1optcheb, f2optcheb); axis([6 19 0 2.5]);
%figure; plot(p1_d4_cheb, p2_d4_cheb, f1cheb4, f2cheb4,f1optcheb, f2optcheb ); axis([6 19 0 2.5]);
%figure; plot(p1_d5_cheb, p2_d5_cheb, f1cheb5, f2cheb5,f1optcheb, f2optcheb ); axis([6 19 0 2.5]);
%figure; plot(p1_d3_cheb, p2_d3_cheb,p1_d3_chebL0, p2_d3_chebL0, p1_d3_chebL1, p2_d3_chebL1, f1optcheb, f2optcheb); axis([6 19 0 2.5]);
%figure; plot(p1_d4_cheb, p2_d4_cheb,p1_d4_chebL0, p2_d4_chebL0, p1_d4_chebL1, p2_d4_chebL1, f1optcheb, f2optcheb); axis([6 19 0 2.5]);
%figure; plot(p1_d5_cheb, p2_d5_cheb,p1_d5_chebL0, p2_d5_chebL0, p1_d5_chebL1, p2_d5_chebL1, f1optcheb, f2optcheb); axis([6 19 0 2.5]);
interp = 'Latex'; axesfont = 35; textfont=35;  marksize = 10; markLine = 7;
hunder=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot(xstep, pout_discret2, xstep, pout_discret4, xstep, obj, 'o','markersize', 3); leg_under = legend('p_2','p_4', 'f^*', 'Location', 'NorthWest' ); xlabel('\lambda', 'Interpreter',interp); set(leg_under,'Interpreter',interp); print -depsc '../figs/test4/test4_under.eps';

hpareto=figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot(p1_d4(:, im), p2_d4(:, im), p1_d6(:, im), p2_d6(:, im), p1_d8(:,im),  p2_d8(:, im), f1opt(goodlambda), f2opt(goodlambda), 'o','markersize', 3 ); leg_pareto = legend('$(h_{4, 1}, h_{4, 2})$', '$(h_{6, 1}, h_{6, 2})$', '$(h_{8, 1}, h_{8, 2})$', '$(f_1^*, f_2^*)$',  'Location', 'NorthEast'); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto,'Interpreter',interp); axis([6 19 0 2.5]); set(leg_pareto,'FontSize',textfont);
 print -depsc '../figs/test4/test4_pareto.eps';

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont); set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(p1_d3_chebL(:, im), p2_d3_chebL(:, im), 'linewidth', markLine); hold on; plot(f1optcheb(goodlambda_cheb), f2optcheb(goodlambda_cheb), 'o','markersize', marksize, 'color',[0 0.5 0] ); leg_pareto_cheb = legend('$(h_{4 1}, h_{4 2})$', '$(f_1^*, f_2^*)$', 'Interpreter',interp); 
%xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);
set(leg_pareto_cheb,'Interpreter',interp); axis([5 20 0 2.5]); set(leg_pareto,'FontSize',textfont); print -depsc '../figs/test4/test4_paretocheb3.eps'; hold off;

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont); set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(p1_d4_chebL(:, im), p2_d4_chebL(:, im), 'linewidth', markLine); hold on; plot(f1optcheb(goodlambda_cheb), f2optcheb(goodlambda_cheb), 'o','markersize', marksize, 'color',[0 0.5 0] ); leg_pareto_cheb = legend('$(h_{6 1}, h_{6 2})$', '$(f_1^*, f_2^*)$', 'Interpreter',interp); 
%xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);
set(leg_pareto_cheb,'Interpreter',interp); axis([5 20 0 2.5]); set(leg_pareto,'FontSize',textfont); print -depsc '../figs/test4/test4_paretocheb4.eps'; hold off;

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont); set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(p1_d5_chebL(:, im), p2_d5_chebL(:, im), 'linewidth', markLine); hold on; plot(f1optcheb(goodlambda_cheb), f2optcheb(goodlambda_cheb), 'o','markersize', marksize, 'color',[0 0.5 0]); leg_pareto_cheb = legend('$(h_{8 1}, h_{8 2})$', '$(f_1^*, f_2^*)$', 'Interpreter',interp); 
%xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);
set(leg_pareto_cheb,'Interpreter',interp); axis([5 20 0 2.5]); set(leg_pareto,'FontSize',textfont); print -depsc '../figs/test4/test4_paretocheb5.eps'; hold off;

%hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont); set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(p1_d3_chebL(:, im), p2_d3_chebL(:, im), p1_d4_chebL(:, im), p2_d4_chebL(:, im), p1_d5_chebL(:,im),  p2_d5_chebL(:, im), f1optcheb(goodlambda_cheb), f2optcheb(goodlambda_cheb), 'o','markersize', marksize ); leg_pareto_cheb = legend('$(h_{3, 1}, h_{3, 2})$', '$(h_{4, 1}, h_{4, 2})$', '$(h_{5, 1}, h_{5, 2})$', '$(f_1^*, f_2^*)$', 'Interpreter',interp); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp);set(leg_pareto_cheb,'Interpreter',interp); axis([6 19 0 2.5]); print -depsc '../figs/test4/test4_paretocheb.eps';

hparetocheb = figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot(f1opt(goodlambda), f2opt(goodlambda), 'o','markersize', marksize ); xlabel('$y_1$', 'Interpreter',interp); ylabel('$y_2$', 'Interpreter',interp); %axis([6 19 0 2.5]);
print -depsc '../figs/test4/test4_approx.eps';

hparetocheb = figure('visible','off');
set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont);
plot(f1optcheb(goodlambda_cheb), f2optcheb(goodlambda_cheb), 'o','markersize', 3 ); xlabel('y_1', 'Interpreter',interp); ylabel('y_2', 'Interpreter',interp); %axis([6 19 0 2.5]);
print -depsc '../figs/test4/test4_approxcheb.eps';

