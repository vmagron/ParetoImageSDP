clear all; close all;

m1 = -1; M1 = 1; m2 = -1; M2 = 1; 
lo = [m1; m2]; up = [M1; M2];
x = sdpvar(2,1); y = sdpvar(4,1); z = sdpvar(2,1);
g1 = -1 - y(2) + x(2)^2 - y(1)*y(2) - y(3)*y(4);
g2 = - x(1)*x(2) + x(1)*y(1) - x(1)*y(4) + x(2)*y(2) + x(2)*y(4) + y(2)*y(4);
g3 = 1 - (y(1)^2 + y(2)^2 + y(3)^2 + y(4)^2);
g4 = 2 * x(2)^2 - 2 * x(2)*y(1) + 2 * x(2)*y(4);
g5 = x(1) - y(2) - y(4);
g = [g1, g2, g3, g4, g5];

xall = [x; y]; z = sdpvar(2,1);
f1 = y(1); f2 = y(2);

[y1, y2, Jk2]= exists(xall, z, f1, f2, 2, 2, g, m1, M1, m2, M2, eps);
[y1, y2, Jk3]= exists(xall, z, f1, f2, 3, 3, g, m1, M1, m2, M2, eps);

m = 2;
a = zeros(m, 1); p = zeros(m, 1);
for i = 1:m
  a (i) = 2  / (up(i) - lo(i)); p(i) = - (up(i) + lo(i))/(up(i) - lo(i));
end
[X,Y] = ellipse(1/a(1),1/a(2), [-p(1)/a(1); -p(2)/a(2)], 50);

N = 1e2;
for i = 1:N
  r1 = rand * rand()
end
      x0 = X0(i,j); y0 = Y0(i,j);
      xit = [x0 y0]; xit = r0 * rand * xit/norm(xit); xit = xit + [x01 x02];
      xit = [x01 + x0*r0 x02 + y0*r0];
        Xit(i*(N-1)+j,it) = xit(1); Yit(i*(N-1)+j,it) = xit(2);
        if  1 - xit(1)^2 - xit(2)^2 > 0
          xit = mapTelse(xit(1),xit(2));
        else
          xit = mapTif(xit(1),xit(2));
        end
    end
  end


hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2, -Jk2,[0 0],'y');  hold on; plot(X,Y,'.k'); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../figs/jirstrand/jirstrand_exists2.eps';


hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,y2, -Jk3,[0 0],'y');  hold on; plot(X,Y,'.k'); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../figs/jirstrand/jirstrand_exists3.eps';

