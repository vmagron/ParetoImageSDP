% Gloptipoly script to compute approximation of Pareto curves
function [obj, x1, x2, f1opt, f2opt, f1val, f2val, good_lambda, mx] = pareto_sos_cheb_test (x, xfree, d, N, n, f1, f2, f1free, f2free, Khat, m1, M1, m2, M2)
mpol omega;
max_order = 4
C = max (M1 - m1, M2 - m2);
x = [x; omega];
status = zeros(N+1,1);
mu = meas(x);
mufree = meas(xfree);
good_lambda = [];
for i = 1:(N+1)
  lambda = (i - 1) / N;
  flambda = x(n + 1); %the criterion to be minimized
  cheb_g1 = C * x(n+1) - lambda * (f1 - m1) >= 0; cheb_g2 = C * x(n+1) - (1 - lambda) * (f2 - m2) >= 0;
  cheb_b1 = x(n+1) >= 0; cheb_b2 = 1 - x(n+1) >= 0;
  Khatomega = [Khat, cheb_g1, cheb_g2, cheb_b1, cheb_b2];
  relax_order = d;
  while (status (i) < 1 && relax_order <= max_order)
    P = msdp(min(flambda), Khatomega, mass(mu)==1, relax_order);
    [status(i), obj(i)] = msol(P);
    relax_order = relax_order + 1;
  end
  i
  dmvec = double(mvec(mu));
  x1(i) = dmvec(2); x2(i) = dmvec(3);
  if (status(i) >= 1) 
    f1opt(i) = double(f1); f2opt(i) = double(f2);
    good_lambda = [good_lambda, i];
  else 
    f1opt(i) = double(mom(f1)); f2opt(i) = double(mom(f2));  
  end
end
%obj = C * obj;
% Computation of the L2 approx px of mx with exact mx to compare with the result of px in pareto_sos
kmax = 5 - ceil (max(deg(f1), deg(f2)) / 2);
degree = 2 * kmax;
mx = zeros(degree + 1, n);
%mxglopti = zeros(degree + 1, n);

for i = 1:(N + 1)
  xstep (i) = (i - 1) / N;
end
xdeg = degree; % degree of the interpolation polynomial for x(lambda)
x1fake = polyfit(xstep, x1 ,xdeg);
x2fake = polyfit(xstep, x2 ,xdeg);
x1fake
x2fake
for k = 0 : degree
%  for i = 1 : n
  for step = 0 : xdeg
    mx(k+1, 1) = mx(k+1, 1) + 1/(step+k+1)*x1fake(xdeg +1 - step);
    mx(k+1, 2) = mx(k+1, 2) + 1/(step+k+1)*x2fake(xdeg + 1 - step);
%    mx(k+1, i) = double(mom(x(i) * lambda^k));
  end
%  mxglopti(k+1, 1) = double(mom(x(1) * lambda^k));mxglopti(k+1, 2) = double(mom(x(2) * lambda^k));
end
H = hankel(degree);
px = H \ mx;

pxlam = zeros(N + 1, n);
for step = 1:(N + 1)
  lam = (step - 1)/ N;
  for i = 0 : degree
    for var = 1 : n 
      pxlam(step, var) = pxlam(step, var) + px (i + 1, var) * lam^i;
    end
  end
%  obj_sos (step) = lam * p1lam + (1 - lam) * p2lam; 
end

assign(xfree,pxlam);
f1val = zeros(N + 1, 1); f2val = zeros(N + 1, 1); 
f1vec = double(f1free); f2vec = double(f2free);
for step = 1:(N + 1)
  f1val(step) = f1vec(1,1,step); f2val(step) = f2vec(1,1,step);
end
%mxglopti()
%figure; plot(0:degree, mx(:,1), 0:degree, xstep, mxglopti(:,1));
%figure; plot(0:degree, mx(:,2), 0:degree, xstep, mxglopti(:,2));
