function [f1plot, f2plot, x1plot, x2plot] = test4_plot(kmax, zoom)
%a1 = (M1 - m1)/2; b1 = (M1 + m1)/2;
%a2 = (M2 - m2)/2; b2 = (M2 + m2)/2;
f1plot = []; f2plot = [];
x1plot = []; x2plot = [];
M1 = 5; M2 = 3;
lo = 8; up = 8.1;
for k = 1:kmax
 x = rand(2,1); 
 g1 = - ( (M1*x(1)-2)^3/2 + M2 * x(2) - 2.5);
 g2 = - (M1 * x(1) + M2 * x(2) - 8 * (-M1 * x(1)+ M2 * x(2)+0.65)^2 - 3.85);
 if g1 >= 0 & g2 >= 0
   x1plot = [x1plot, 5 * x(1)]; x2plot = [x2plot, 3 * x(2)]; 
   f1 = (M1*x(1)+M2*x(2)-7.5)^2 + (-M1*x(1)+M2*x(2)+3)^2/4;
   f2 = (M1*x(1)-1)^2/4 + (M2*x(2)-4)^2/4;
   if zoom == 0 || (zoom == 1 & f1 >= lo & f1 <= up)
     f1plot = [f1plot, f1]; f2plot = [f2plot, f2];
   end
 end
end
