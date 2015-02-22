%%%%% Second method using parametric polynomial optimization 
%%%%% based on ``Chebyshev weighted sum'' reformulation for multiobjective optimization

function [output] = methodb (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2)


output = 0;

%%%% im stands for inverse method.
%%%% Using this method allows to reconstructs the coordinates of the Pareto curve from the moments of the solution x obtained with SDP
im = 3;
Khatlambda = [Khat, lambda >= 0, 1 >= lambda];


%%%% Discretization for comparison 
[objcheb, x1, x2, f1optcheb, f2optcheb, f1fake, f2fake, goodlambda_cheb, mxcheb] = pareto_sos_cheb_test (x, xfree, 2, N, n, f1, f2, f1free, f2free, Khat, m1, M1, m2, M2);


for deg = dmin:dmax
  [out3, p1_d3_cheb, p2_d3_cheb, f1cheb3, f2cheb3] = pareto_sos_cheb (x, xfree, lambda, deg, deg, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2, im);
  %%%% Plots WARNING!! Bugs occur with last versions of Matlab
  interp = 'Latex'; axesfont = 35; textfont=35; marksize = 10; markLine = 7; 
  [status,message,messageid] = mkdir('../figs', exname);
  namevar = strcat('../figs/', exname, '/methodb_degree', num2str(deg), '.eps');
  hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', axesfont); set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', axesfont); plot(p1_d3_cheb(:, im), p2_d3_cheb(:, im), 'linewidth', markLine); hold on; plot(f1optcheb(goodlambda_cheb), f2optcheb(goodlambda_cheb), 'o','markersize', marksize, 'color',[0 0.5 0] ); leg_pareto_cheb = legend('$(h_{1}, h_{2})$', '$(f_1^*, f_2^*)$', 'Interpreter',interp); 
  set(leg_pareto_cheb,'Interpreter',interp); set(gca,'XTick',(-1:0.4:1)); set(gca,'YTick',(-1:1:3));  set(leg_pareto_cheb,'FontSize',textfont); axis([m1 M1 m2 M2]); print('-depsc', namevar); hold off;
end
cd ../examples;
