function [evals] = eval_pol(pol, N)

evals = zeros(N + 1, 1);
degree = length(pol) - 1;
for step = 1:(N + 1)
  lam = (step - 1)/ N;
  for i = 0 : degree
    evals(step) = evals(step) + pol (i + 1) * lam^i;
  end
end
