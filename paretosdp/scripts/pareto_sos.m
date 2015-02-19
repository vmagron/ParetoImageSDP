% Gloptipoly script to compute approximation of Pareto curves
% 2 * s is the number of moment constraints used to compute approximation of the generalized moments int_0^1 f_j^*(lambda) lambda^k dmu (lambda) k = 1, ..., 2 s
% d is the relaxation order (maximal half degree of the combinations of sos polynomials and gj when solving the dual SOS relaxation)
% n is the number of variables
% gj are the polynomials used to define the support constraints of the measure
function [pout_discret, p1lam, p2lam, f1val, f2val, pxlam, mx] = pareto_sos (x, xfree, lambda, d, s, N, n, f1, f2, f1free, f2free, Khat, lam_begin, lam_end, lo1, up1, lo2, up2, inverse_method)
%pars.eps = 1e-6; mset(pars);
mu = meas(x, lambda);
mufree = meas(xfree);
d1 = deg(f1); d2 = deg(f2); kmax = s - ceil (max(d1, d2) / 2); degree = 2 * kmax;
flambda = lambda * f1 + (1 - lambda) * f2; %the criterion to be minimized
mmom_cstr (degree, 1) = momcon(); %k_dimensional vector to encode the moments equality constraints
mmom_cstr(1) = mass (mu) - 1 == 0;
for k = 1 : degree
  mmom_cstr (k + 1) = mom (lambda^k) - 1 / (1 + k)==0;
end
[P, M] = msdp(min(flambda), Khat, x'*x + lambda^2 <= n + 1, mmom_cstr', d);
[A,b,c,K] = msedumi(P);
[xout,yout,info] = sedumi(A,b,c,K);
[obj, info] = msol(P);
% xout is the (2s + 1) vector so that pout = sum_{i=0}^{2 s} xout_i lambda^i underestimates f(lambda)^*
%xout0 = -c'*xout + c(1:(2 * s))' * xout(1:(2 * s));
for step = 1:(N + 1)
  lam = (step - 1)/ N;
  pout = 0;
  for i = 0 : (2 * s)
    pout = pout + xout(i+1) * lam^i;
  end
  pout_discret (step) = pout;
end
%mvec(mu)
%dmvec = double(mvec(mu))
%dmvec(18)
%dmvec(33)
%dmvec(54)
%dmvec(82)


zero = 1e-3; 
d1 = deg(f1); mons1 = mmon(x, d1);  zerovec = zero * mons1; f1_zero = f1 + sum(zerovec); c1 = coef(f1_zero); c1 = c1 - zero;
d2 = deg(f2); mons2 = mmon(x, d2);  zerovec = zero * mons2; f2_zero = f2 + sum(zerovec); c2 = coef(f2_zero); c2 = c2 - zero;

%degree = 1;
m1 = zeros(degree + 1, 1); m2 = zeros(degree + 1, 1);

for k = 0 : degree
  for i = 1:length(mons1)
    mon = mons1 (i);
    m1(k+1) = m1(k+1) + c1(i) * double(mom(mon * lambda^k));
  end
  for i = 1:length(mons2)
    mon = mons2 (i);
    m2(k+1) = m2(k+1) + c2(i) * double(mom(mon * lambda^k));
  end
end
mx = zeros(degree + 1, n);

for k = 0 : degree
  for i = 1 : n
    mx(k+1, i) = double(mom(x(i) * lambda^k));
  end
end
H = hankel(degree); 

p1 = zeros (inverse_method, degree + 2 * inverse_method + 1);
p2 = zeros (inverse_method, degree + 2 * inverse_method + 1);

for order_L2 = 1:inverse_method
  inverse_degree = 2 * order_L2;
  porder = degree + inverse_degree;
  p1(order_L2, 1:(porder + 1)) = double(inverse_L2(H, m1, inverse_degree, lo1, up1, porder));
  p2(order_L2, 1:(porder + 1)) = double(inverse_L2(H, m2, inverse_degree, lo2, up2, porder));
end
H\m1 
p1
H\m2
p2
%p1 = inverse_L2 (H, m1, 0);  p2 = inverse_L2(H, m2,0); 
px = inverse_L2(H, mx, -1);

p1lam = zeros(N + 1, inverse_method); p2lam = zeros(N + 1, inverse_method);
pxlam = zeros(N + 1, n);
for step = 1:(N + 1)
  lam = lam_begin + (step - 1)/ N * (lam_end - lam_begin);
  for order_L2 = 1:inverse_method
    inverse_degree = 2 * order_L2;
    porder = degree + inverse_degree;
    for i = 0 : porder
      p1lam(step, order_L2) = p1lam(step, order_L2) + p1 (order_L2, i + 1) * lam^i;
      p2lam(step, order_L2) = p2lam(step, order_L2) + p2 (order_L2, i + 1) * lam^i;
    end
  end
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

%Comparison with a discretization N-steps scheme
%obj_test = pareto_sos_test (d, N);
%obj_sos
%obj_test

%{
zero = 1e-3; 
d1 = deg(f1); mons1 = mmon(x, d1);  zerovec = zero * mons1; f1_zero = f1 + sum(zerovec); c1 = coef(f1_zero); c1 = c1 - zero;
d2 = deg(f2); mons2 = mmon(x, d2);  zerovec = zero * mons2; f2_zero = f2 + sum(zerovec); c2 = coef(f2_zero); c2 = c2 - zero;

kmax = d - ceil (max(d1, d2) / 2);
degree = 2 * kmax;
%degree = 1;
m1 = zeros(degree + 1, 1); m2 = zeros(degree + 1, 1);

for k = 0 : degree
  for i = 1:length(mons1)
    mon = mons1 (i);
    m1(k+1) = m1(k+1) + c1(i) * double(mom(mon * lambda^k));
  end
  for i = 1:length(mons2)
    mon = mons2 (i);
    m2(k+1) = m2(k+1) + c2(i) * double(mom(mon * lambda^k));
  end
end
mx = zeros(degree + 1, n);

for k = 0 : degree
  for i = 1 : n
    mx(k+1, i) = double(mom(x(i) * lambda^k));
  end
end
H = hankel (degree);
p1 = H \ m1; p2 = H \ m2; px = H \ mx;
%p1
%p2
%px1
%px2
p1lam = zeros(N + 1, 1); p2lam = zeros(N + 1, 1);
pxlam = zeros(N + 1, n);
for step = 1:(N + 1)
  lam = lam_begin + (step - 1)/ N * (lam_end - lam_begin);
  p1lam(step) = 0;
  p2lam(step) = 0;
  for i = 0 : degree
    p1lam(step) = p1lam(step) + p1 (i + 1) * lam^i;
    p2lam(step) = p2lam(step) + p2 (i + 1) * lam^i;
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
%Comparison with a discretization N-steps scheme
%obj_test = pareto_sos_test (d, N);
%obj_sos
%obj_test
%}
