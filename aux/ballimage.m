
close all
clear all;
hold on
for k = 1:1e3
 x = randn(2,1);
 x = rand*x/norm(x);
% f1 = (x(1)+x(1)*x(2))/2;
% f2 = (x(2)-x(1)^3)/2;
 f1 = -x(1); f2 = x(1)+x(2)^2;
% plot(f1,f2,'.b','markersize',5);
end
for k = 1:1e3
 x = randn(2,1);
 x = x/norm(x);
% f1 = (x(1)+x(1)*x(2))/2;
% f2 = (x(2)-x(1)^3)/2;
 f1 = -x(1); f2 = x(1)+x(2)^2;
% plot(f1,f2,'.r','markersize',5);
end
th=linspace(0,2*pi,1e3);
plot(cos(th),sin(th),'k','linewidth',3);

d=6;
x=sdpvar(2,1);
y=sdpvar(2,1);

%f=[x(1)+x(1)*x(2); x(2)-x(1)^3]/2;
f = [-x(1);x(1)+x(2)^2];
h=(f(1)-y(1))^2+(f(2)-y(2))^2;
g1 = - x(1)^2 + x(2);
g2 = - x(1) - 2 * x(2) + 3;
[g,gc]=polynomial(y,d);
[qx,qxc]=polynomial([x;y],d-2);
[qy,qyc]=polynomial([x;y],d-2);
[q1,q1c]=polynomial([x;y],d-2);
[q2,q2c]=polynomial([x;y],d-2);
pow=genpow(3,d);pow=pow(:,2:end);
z=momball(pow);
solvesos([sos(h-g-qx*(1-x(1)^2-x(2)^2)-qy*(1-y(1)^2-y(2)^2) - q1*g1 - q2 * g2);sos(qx);sos(qy); sos(q1); sos(q2)],...
  -gc'*z, sdpsettings('solver','sedumi'), [gc;qxc;qyc;q1c;q2c]);

mpol x1 x2;
G=vectorize(double(gc)'*mmon([x1 x2],d));
[x,y]=meshgrid(linspace(-1,1,1e2));
G=eval(G);
contourf(x,y,-G,[0 0],'y');
y1p = -1:0.01:1/2*2^(1/3);
plot(y1p,-y1p+y1p.^4,'k');

axis equal


