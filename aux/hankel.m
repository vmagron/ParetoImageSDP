function H = hankel (degree)
H = zeros(degree + 1, degree + 1);
for i = 0 : degree
  for j = 0 : degree
    H(i + 1, j + 1) = 1 / (i + j + 1);
  end
end
