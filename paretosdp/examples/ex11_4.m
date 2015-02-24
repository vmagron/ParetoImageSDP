%%%%% Gloptipoly/Yalmip implementation example using 
%%%%% the three methods in the paper : 
%%%%% Approximating Pareto curves using semidefinite relaxations

clear all; 
%% Number of discretization points (used for comparison)
N = 10;
%% Number of variables
n = 2; 

%% Problem formulation
mpol('x', n);
mpol('xfree',n);
mpol lambda;
mu = meas(x, lambda);
f1 = -x(1); f2 = x(1) + x(2)^2;
f1free = -xfree(1); f2free = xfree(1) + xfree(2)^2;
g1 = - x(1)^2 + x(2) >= 0;
g2 = - x(1) - 2 * x(2) + 3 >= 0;
g3 = 2 >= x(1)^2 + x(2)^2;
Khat = [g1, g2, g3];
%% Compute lower/upper bounds of f1 and f2 over Khat
cd ../scripts;
[m1, M1] = minmax (x, n, f1, Khat, 1); [m2, M2] = minmax (x, n, f2, Khat, 1);


%% Choose the minimal/maximal degree of sum-of-squares allowing to approximate the Pareto curve
dmin = 4; dmax = 4; 

%% For each degree between dmin and dmax, the script generates a figure (within the directory figs/exname/) displaying Pareto curve approximations
exname = 'ex11_4';


methoda (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2);
%methodb (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2);
%methodc (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2);
