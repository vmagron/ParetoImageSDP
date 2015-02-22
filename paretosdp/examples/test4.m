%%%%% Gloptipoly/Yalmip implementation example using 
%%%%% the three methods in the paper : 
%%%%% Approximating Pareto curves using semidefinite relaxations

clear all; 
%% Number of discretization points (used for comparison)
N = 10;
%% Number of variables
n = 2; 

%% Problem formulation
mpol('xlarge', n);
mpol('x', n);
mpol('xfree',n);
mpol lambda;

% xlarge is used for scaling purpose
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

%% Compute lower/upper bounds of f1 and f2 over Khat
[m1, M1] = minmax (x, n, f1, Khat, 2); [m2, M2] = minmax (x, n, f2, Khat, 2);

%% Choose the minimal/maximal degree of sum-of-squares allowing to approximate the Pareto curve
dmin = 4; dmax = 4; 

%% For each method (a, b or c), and for each degree between dmin and dmax, the script generates a figure (within the directory figs/exname/) displaying the corresponding Pareto curve approximations
exname = 'test4';
cd ../scripts;

methoda (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2);
methodb (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2);
methodc (x, xfree, lambda, f1, f2, f1free, f2free, n, N, Khat, dmin, dmax, exname, m1, M1, m2, M2);
