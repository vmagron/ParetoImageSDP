function [J] = vect2pol (x, f, k, Jk)
J=0;
mons = monpowers(length(f),2 * k);
for alpha = 1:length(mons)
  beta = mons(alpha,:);
  b1 = beta(1); b2 = beta(2); b3 = beta(3);
  J = J + Jk(alpha).* x(1).^beta(1) .* x(2).^beta(2) .* x(3).^beta(3);
end
