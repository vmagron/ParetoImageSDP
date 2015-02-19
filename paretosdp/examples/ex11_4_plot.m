function [f1plot, f2plot, x1plot, x2plot] = ex11_4_plot(kmax)
f1plot = []; f2plot = [];
x1plot = []; x2plot = [];
for k = 1:kmax
 x = -3 + 6*rand(2,1); 
 g1 = - x(1)^2 + x(2);
 g2 = - x(1) - 2 * x(2) + 3;
 if g1 >= 0 & g2 >= 0
   x1plot = [x1plot, x(1)]; x2plot = [x2plot, x(2)]; 
   f1 = -x(1); f2 = x(1) + x(2)^2;
   f1plot = [f1plot, f1]; f2plot = [f2plot, f2];
 end
end
