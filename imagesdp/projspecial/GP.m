close all;
clear all;
x = sdpvar(7,1);

% Consider four balls with centers
% A=(xa,ya,za) 
% B=(1,0,0)
% C=(0,1,0)
% D=(0,0,1)

% Require that the distance AC is sqrt{2} and that AB and AD are at least sqrt{2}
xa = sqrt(2) * x(1); ya = sqrt(2) * x(2) + 1; za = sqrt(2) * x(3);
EqA = xa^2+(ya-1)^2+za^2-2; %  = 0
IneqB = (xa-1)^2+ya^2+za^2-2; % >= 0
IneqD = xa^2+ya^2+(za - 1)^2-2; % >= 0

u0 = x(4); u1 = x(5); v0 = x(6); v1 = x(7);
% Require that the line through the points U (u0,v0,0) and V (u1,v1,1) stabs the balls with centers A,B,C,D and radii sqrt{2}}

% Vectorial product between vect(AU) and vect(UV) to compute the distance between A and (UV)

uvsquare = (u1 - u0)^2 + (v1 - v0)^2 + 1;
IneqSA = - ((v0 - ya + za * (v1 - v0))^2 + (-za * (u1 - u0) - (u0 - xa))^2 + ((u0 - xa) * (v1 - v0) - (v0 - ya)* (u1 - u0))^2) + 2 * uvsquare;
% For point B: replace xa by 1, ya by 0, za by 0
IneqSB = - ((v0)^2 + (- (u0 - 1))^2 + ((u0 - 1) * (v1 - v0) - (v0)* (u1 - u0))^2) + 2 * uvsquare;
% For point C: replace xa by 0, ya by 1, za by 0
IneqSC = - ((v0 - 1)^2 + ( - (u0))^2 + ((u0 ) * (v1 - v0) - (v0 - 1)* (u1 - u0))^2) + 2 * uvsquare;
% For point D: replace xa by 0, ya by 0, za by 1
IneqSD = - ((v0 + (v1 - v0))^2 + (-(u1 - u0) - (u0))^2 + ((u0) * (v1 - v0) - (v0)* (u1 - u0))^2) + 2 * uvsquare;

% Ordering condition

IneqAB = (u1-u0)*(1-xa) - (v1-v0)*ya -za;
IneqBC = -(u1-u0) + (v1-v0);
IneqCD = -(v1-v0) + 1;
IneqAC = -(u1-u0)*xa + (v1-v0)*(1-ya)-za;
IneqDB = (u1-u0) - za;

% The sets 
eps = 1e-6;
X = [EqA + eps, -EqA, IneqB, IneqD, IneqSA, IneqSB, IneqSC, IneqSD];
Yp = [IneqAB, IneqBC, IneqCD];
Ym = [-IneqAB, -IneqBC, -IneqCD];
Zp = [IneqAC, IneqCD, IneqDB];
Zm = [-IneqAC, -IneqCD, -IneqDB];

% The projections

% S1 = projection of X \cap Yp on {xa,ya,za}
% S2 = projection of X \cap Ym on {xa,ya,za}
% T1 = projection of X \cap Zp on {xa,ya,za}
% T2 = projection of X \cap Zm on {xa,ya,za}

XYp = [EqA + eps, -EqA, IneqB, IneqD, IneqSA, IneqSB, IneqSC, IneqSD, IneqAB, IneqBC, IneqCD];
XYm = [EqA + eps, -EqA, IneqB, IneqD, IneqSA, IneqSB, IneqSC, IneqSD, -IneqAB, -IneqBC, -IneqCD];
XZp = [EqA + eps, -EqA, IneqB, IneqD, IneqSA, IneqSB, IneqSC, IneqSD, IneqAC, IneqCD, IneqDB];
XZm = [EqA + eps, -EqA, IneqB, IneqD, IneqSA, IneqSB, IneqSC, IneqSD, -IneqAC, -IneqCD, -IneqDB];

lo = [-1; -1; -1]; up = [1; 1; 1];
f = [xa; ya; za];
r = 2;
[y1, y2, s12, S12]= proj_special3d(x, f, r, r, XYp, lo, up);
[y1, y2, s22, S22]= proj_special3d(x, f, r, r, XYm, lo, up);
[y1, y2, t12, T12]= proj_special3d(x, f, r, r, XZp, lo, up);
[y1, y2, t22, T22]= proj_special3d(x, f, r, r, XZm, lo, up);

%r = 3;
%[y1, y2, s13, S13]= proj_special3d(x, f, r, r, XYp, lo, up);
%[y1, y2, s23, S23]= proj_special3d(x, f, r, r, XYm, lo, up);
%[y1, y2, t13, T13]= proj_special3d(x, f, r, r, XZp, lo, up);
%[y1, y2, t23, T23]= proj_special3d(x, f, r, r, XZm, lo, up);


%save('../figs/GP/saveproj','S1','S2','T1','T2');


% The questions

% Is (S1 \cup S2) disjoint from (T1 \cap T2) ?
% Extract sublevel sets with S1 = {y : s1(y) \geq 0} over T1 \cap T2
% upper bounds of max s1(y) s.t. y \in T1 \cap T2 : 
% if upper bound < 0 then max < 0, thus s(x) < 0 and S1 \cap (T1 \cap T2) = emptyset, then one does the same study for s2
% if upperbound >= 0 and max = upperbound (SDP relaxation order is high enough) then \cap is not emptyset

objs12 = maxsos (x(1:3), s12 - 1, [1 - x(1)^2 - x(2)^2 - x(3)^2, t12 - 1, t22 - 1], r);
objs22 = maxsos (x(1:3), s22 - 1, [1 - x(1)^2 - x(2)^2 - x(3)^2, t12 - 1, t22 - 1], r);
%objs13 = maxsos (x(1:3), s13 - 1, [1 - x(1)^2 - x(2)^2 - x(3)^2, t13 - 1, t23 - 1], r);
%objs23 = maxsos (x(1:3), s23 - 1, [1 - x(1)^2 - x(2)^2 - x(3)^2, t13 - 1, t23 - 1], r);
%objs123 = maxminsos (x(1:3), [s12 - 1; s13 - 1], [1 - x(1)^2 - x(2)^2 - x(3)^2, t12 - 1, t22 - 1], r);

%save('../figs/GP/saveobj','objs1','objs2');

% proj = load('../figs/GP/saveproj4.mat'); S1 = proj.S1; S2 = proj.S2; T1 = proj.T1; T2 = proj.T2;
% s1 = vect2pol (x, f, r, S1); s2 = vect2pol (x, f, r, S2); t1 = vect2pol (x, f, r, T1); t2 = vect2pol (x, f, r, T2);
% obj = load('../figs/GP/saveobj4.mat'); objs1 = obj.objs1; objs2 = obj.objs2; 
