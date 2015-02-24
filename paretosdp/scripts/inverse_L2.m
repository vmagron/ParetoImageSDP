function pcoeff = inverse_L2 (H, m, method, lo, up, order)
d = length(m) - 1; % degree of the L2 polynomial approximation
if method == -1
  pcoeff = H \ m; 
else
  %pcoeff_hankel = H\m; pscale = max(abs(pcoeff_hankel));
  %m = [m; zeros(order - d, 1)]; % Complete last entries of m with zeros. Now, length(m) = order + 1
  %H = [H zeros(d + 1, order - d); zeros(order - d,order + 1)];
  H = hankel(order);
  pcoeff = sdpvar (order + 1,1); lambda = sdpvar (1,1);
  p = 0;
  for i = 0:order
    p = p + pcoeff(i+1) * lambda^i;
  end
  g = [lambda*(1 - lambda)];
  obj = pcoeff'*H*pcoeff;
  %obj = sum(pcoeff);
  [slo, clo] = polynomial(lambda, order - 2);
  %[sup, cup] = polynomial(lambda, order - 2);
  momcstr = [];
  for k = 0:d
    cstr = 0;
    for i = 0:order
      cstr = cstr + pcoeff(i + 1) / (i + k + 1);
    end
    momcstr = [momcstr, cstr == m(k + 1)];
  end
  F = [sos(p - lo - slo * g), sos(slo), momcstr];
  solvesos(F,obj, sdpsettings('solver','sedumi','sedumi.eps',1e-8), [clo;pcoeff]);
end
