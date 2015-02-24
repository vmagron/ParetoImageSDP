%%%%% First method using parametric polynomial optimization 
%%%%% based on ``convex weighted sum'' reformulation for multiobjective optimization

function [output] = methoda (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2)

output = 0;

%%%% im stands for inverse method.
%%%% Using this method allows to reconstructs the coordinates of the Pareto curve from the moments of the solution x obtained with SDP
im = 6;
Khatlambda = [Khat, lambda >= 0, 1 >= lambda];


%%%% Discretization for comparison 
[obj, x1, x2, f1opt, f2opt, goodlambda] = pareto_sos_test (x, 2, N, f1, f2, Khat);


for deg = dmin:dmax
  [pout_discret4, p1_d4, p2_d4, f1_d4, f2_d4, px4, mx4] = pareto_sos (x, xfree, lambda, deg, deg, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1,  m1, M1, m2, M2, im);
  %%%% Plots WARNING!! Bugs occur with last versions of Matlab
  interp = 'Latex'; axesfont = 35; textfont=35; marksize = 10; markLine = 7; 
  [status,message,messageid] = mkdir('../figs', exname);
  namevar = strcat('../figs/', exname, '/methoda_degree', num2str(deg), '.eps');


  hpareto=figure('visible','off'); 
  set(0,'DefaultAxesFontName', 'Palatino'); set(0,'DefaultAxesFontSize', axesfont); 
  set(0,'DefaultTextFontname', 'Palatino'); set(0,'DefaultTextFontSize', axesfont);
  cmap = colormap(gray);
%  plot(p1_d4(:, im), p2_d4(:, im), 'linewidth', markLine); hold on; plot(f1opt(goodlambda), f2opt(goodlambda), 'o','markersize', marksize,  'color',[0 0.5 0]); 
  plot(p1_d4(:, im), p2_d4(:, im), 'linewidth', markLine); hold on; 
  plot(f1opt(goodlambda), f2opt(goodlambda), 'o','markersize', marksize); 

  leg_pareto = legend('$(h_{1}, h_{2})$', '$(f_1^*, f_2^*)$'); 
  set(leg_pareto,'Interpreter',interp); 
  set(gca,'XTick',(-1:0.4:1)); set(gca,'YTick',(-1:1:3));  
  set(leg_pareto,'FontSize',textfont); 
  axis([m1 M1 m2 M2]); 
  print('-dpsc', namevar); hold off;
  %print -depsc '../figs/ex11_4/ex11_4_pareto4.eps'; hold off;
end

cd ../examples;
