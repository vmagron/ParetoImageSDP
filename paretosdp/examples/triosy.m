clear all; 
N = 100;
n = 2;
mpol('xlarge', n);
mpol('x', n);
mpol('xfree',n);
mpol('ylarge', n);
mpol('y', n);
mpol('yfree',n);
mpol('zlarge', n);
mpol('z', n);
mpol('zfree',n);
mpol lambdax lambday lambdaz;
xlarge(1) = x(1) * 10; xlarge(2) = x(2) * 10; zlarge(2) = z(2) * 10;
ylarge(1) = y(1) * 4 + 1;  zlarge(1) = z(1) * 4 + 1; ylarge(2) = y(2)* 6;
fx1 = -(25*(xlarge(1) - 2)^2 + (xlarge(2) - 2)^2);
fy1 = - (ylarge(1) - 1)^2  - (ylarge(2) - 4)^2;
fz1 = - (zlarge(1) - 1)^2;
fx2 = xlarge(1)^2 + xlarge(2)^2;
fy2 = ylarge(1)^2 + ylarge(2)^2;
fz2 = zlarge(1)^2 + zlarge(2)^2;

f1xfree = -(25*((10 * xfree(1)) - 2)^2 + ((10 * xfree(2)) - 2)^2);
f1yfree = - ((4 * yfree(1)+1) - 1)^2  - ((6 * yfree(2)) - 4)^2;
f1zfree = - ((4 * zfree(1)+1) - 1)^2;
f2xfree = (10 * xfree(1))^2 + (10 * xfree(2))^2;
f2yfree = (4 * yfree(1)+1)^2 + (6 * yfree(2))^2;
f2zfree = (4 * zfree(1)+1)^2 + (10 * zfree(2))^2;

g1 = xlarge(1) + xlarge(2) - 2 >= 0;
g2 = 6 -  xlarge(1) -  xlarge(2) >= 0;
g3 = 2 - xlarge(2) + xlarge(1) >= 0;
g4 = 2 - xlarge(1) + 3 * xlarge(2) >= 0;

g5 = 4 - (ylarge(1) - 3)^2 - ylarge(2) >= 0;

g6 = (zlarge(1) - 3)^2 + zlarge(2) - 4 >= 0;

b1 = x(1) >= 0; b2 = 1 >= x(1); 
b3 = x(2) >= 0; b4 = 1 >= x(2); 
b5 = y(1) >= 0; b6 = 1 >= y(1); 
b7 = y(2) >= 0; b8 = 1 >= y(2); 
b9 = z(1) >= 0; b10= 1 >= z(1); 
b11= z(2) >= 0; b12= 1 >= z(2); 
Khatx = [g1, g2, g3, g4, b1, b2, b3, b4]; 
Khaty = [g5, b5, b6, b7, b8]; 
Khatz = [g6, b9, b10, b11, b12]; 

Khatlambdax = [Khatx, lambdax >= 0, 1 >= lambdax];
Khatlambday = [Khaty, lambday >= 0, 1 >= lambday];
Khatlambdaz = [Khatz, lambdaz >= 0, 1 >= lambdaz];

[pout_discretx, p1x_d2, p2x_d2, fx1_d2, fx2_d2, pxlam] = pareto_sos (x, xfree, lambdax, 2, 2, N, n, fx1, fx2, f1xfree, f2xfree, Khatlambdax, 0, 1);
[pout_discrety, p1y_d2, p2y_d2, fy1_d2, fy2_d2, pylam] = pareto_sos (y, yfree, lambday, 2, 2, N, n, fy1, fy2, f1yfree, f2yfree, Khatlambday, 0, 1);
[pout_discretz, p1z_d2, p2z_d2, fz1_d2, fz2_d2, pzlam] = pareto_sos (z, zfree, lambdaz, 2, 2, N, n, fz1, fz2, f1zfree, f2zfree, Khatlambdaz, 0, 1);

%[pout_discret3, p1_d3, p2_d3, f1_d3, f2_d3] = pareto_sos (x, xfree, lambda, 3, 3, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1);
%[objx, x1, x2, fx1opt, fx2opt] = pareto_sos_test (x, 2, N, fx1, fx2, Khatx);
%[objy, y1, y2, fy1opt, fy2opt] = pareto_sos_test (y, 2, N, fy1, fy2, Khaty);
%[objz, z1, z2, fz1opt, fz2opt] = pareto_sos_test (z, 2, N, fz1, fz2, Khatz);

[mx1, Mx1] = minmax (x, n, fx1, Khatx, 1); [mx2, Mx2] = minmax (x, n, fx2, Khatx, 1);
[my1, My1] = minmax (y, n, fy1, Khaty, 1); [my2, My2] = minmax (y, n, fy2, Khaty, 1);
[mz1, Mz1] = minmax (z, n, fz1, Khatz, 1); [mz2, Mz2] = minmax (z, n, fz2, Khatz, 1);

[out2, p1_d2_cheb, p2_d2_cheb, f1cheb2x, f2cheb2x] = pareto_sos_cheb (x, xfree, lambdax, 2, 2, N, n, fx1, fx2, f1xfree, f2xfree, Khatlambdax, 0, 1, mx1, Mx1, mx2, Mx2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb2y, f2cheb2y] = pareto_sos_cheb (y, yfree, lambday, 2, 2, N, n, fy1, fy2, f1yfree, f2yfree, Khatlambday, 0, 1, my1, My1, my2, My2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb2z, f2cheb2z] = pareto_sos_cheb (z, zfree, lambdaz, 2, 2, N, n, fz1, fz2, f1zfree, f2zfree, Khatlambdaz, 0, 1, mz1, Mz1, mz2, Mz2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb3x, f2cheb3x] = pareto_sos_cheb (x, xfree, lambdax, 3, 3, N, n, fx1, fx2, f1xfree, f2xfree, Khatlambdax, 0, 1, mx1, Mx1, mx2, Mx2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb3y, f2cheb3y] = pareto_sos_cheb (y, yfree, lambday, 3, 3, N, n, fy1, fy2, f1yfree, f2yfree, Khatlambday, 0, 1, my1, My1, my2, My2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb3z, f2cheb3z] = pareto_sos_cheb (z, zfree, lambdaz, 3, 3, N, n, fz1, fz2, f1zfree, f2zfree, Khatlambdaz, 0, 1, mz1, Mz1, mz2, Mz2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb4x, f2cheb4x] = pareto_sos_cheb (x, xfree, lambdax, 4, 4, N, n, fx1, fx2, f1xfree, f2xfree, Khatlambdax, 0, 1, mx1, Mx1, mx2, Mx2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb4y, f2cheb4y] = pareto_sos_cheb (y, yfree, lambday, 4, 4, N, n, fy1, fy2, f1yfree, f2yfree, Khatlambday, 0, 1, my1, My1, my2, My2);
[out2, p1_d2_cheb, p2_d2_cheb, f1cheb4z, f2cheb4z] = pareto_sos_cheb (z, zfree, lambdaz, 4, 4, N, n, fz1, fz2, f1zfree, f2zfree, Khatlambdaz, 0, 1, mz1, Mz1, mz2, Mz2);

%[out3, p1_d3_cheb, p2_d3_cheb, f1cheb3, f2cheb3] = pareto_sos_cheb (x, xfree, lambda, 3, 3, N, n, f1, f2, f1free, f2free, Khatlambda, 0, 1, m1, M1, m2, M2);
[obj, x1, x2, fx1opt, fx2opt] = pareto_sos_cheb_test (x, 2, N, n, fx1, fx2, Khatx, mx1, Mx1, mx2, Mx2);
[obj, y1, y2, fy1opt, fy2opt] = pareto_sos_cheb_test (y, 2, N, n, fy1, fy2, Khaty, my1, My1, my2, My2);
[obj, z1, z2, fz1opt, fz2opt] = pareto_sos_cheb_test (z, 2, N, n, fz1, fz2, Khatz, mz1, Mz1, mz2, Mz2);

for i = 1:(N + 1)
  xstep (i) = (i - 1) / N;
end
%plot(xstep, pout_discret2, xstep, pout_discret3, xstep, obj);

%figure; plot(fx1_d2+fy1_d2+ fz1_d2, fx2_d2+fy2_d2+ fz2_d2)
%figure; plot(fx1_d2+fy1_d2+ fz1_d2, fx2_d2+fy2_d2+ fz2_d2, fx1opt + fy1opt + fz1opt,fx2opt + fy2opt + fz2opt)

figure; plot(fx1_d2+fy1_d2+ fz1_d2, fx2_d2+fy2_d2+ fz2_d2, f1cheb2x +f1cheb2y + f1cheb2z,f2cheb2x +f2cheb2y + f2cheb2z, f1cheb3x +f1cheb3y + f1cheb3z , f2cheb3x +f2cheb3y + f2cheb3z ,fx1opt + fy1opt + fz1opt,fx2opt + fy2opt + fz2opt );
