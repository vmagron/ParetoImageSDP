%%%%% Third method using parametric polynomial optimization 
%%%%% based on ``parametric sublevel set approximation'' for multiobjective optimization

function [output] = methodc (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2)

output = 0;

[lo, xm1] = minglopt (x, n, f1, Khat, f1, dmax); [up, xm2] = minglopt (x, n, f2, Khat, f1, dmax);
%%%% im stands for inverse method.
%%%% Using this method allows to reconstructs the coordinates of the Pareto curve from the moments of the solution x obtained with SDP
im = 3;
Khatlambda = [Khat, lambda >= 0, 1 >= lambda];


%%%% Discretization for comparison 
[objhertog, f1opthertog, f2opthertog, goodlambda_hertog, badlam, udiscret] = pareto_sos_hertog_test (x, xfree, dmin, N, n, f1, f2, f1free, f2free, Khat, lo, up);

for deg = dmin:dmax
  [pout_discret2] = pareto_sos_hertog (x, xfree, lambda, deg, deg, N, n, f1, f2, Khatlambda, lo, up);
  %%%% Plots WARNING!! Bugs occur with last versions of Matlab 
  ustep = zeros(N+1, 1);
  for step = 1:(N + 1)
    ustep(step) = lo + (step - 1)/ N * (up - lo);
  end
  eps2 = 1e-8;
  [status,message,messageid] = mkdir('../figs', exname);
  namelegend = strcat('$q_', num2str(deg), '$');
  namevar = strcat('../figs/', exname, '/methodc_degree', num2str(deg), '.eps');
  interp = 'Latex'; axesfont = 35; textfont=35; marksize = 10; markLine = 7; 
  hpareto=figure('visible','off');set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont);set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(ustep, pout_discret2, 'linewidth', markLine); hold on;plot( f1opthertog(goodlambda_hertog), f2opthertog(goodlambda_hertog) + eps2, 'o', f1opthertog(badlam), f2opthertog(badlam), 'o', 'markersize', marksize, 'color',[0 0.5 0]); leg_pareto = legend(namelegend, '$f_2^*$'); xlabel('$\lambda$', 'Interpreter',interp);  
  set(leg_pareto,'Interpreter',interp); axis([m1 M1 m2 M2]); set(leg_pareto,'FontSize',textfont); print('-depsc', namevar); hold off;
end
cd ../examples;
