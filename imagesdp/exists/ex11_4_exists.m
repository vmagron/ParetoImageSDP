close all;
clear all;
hold on;
x = sdpvar(2,1);
y = sdpvar(2,1);
f1 = -x(1); 
f2 = x(1) + x(2)^2;
g1 = - x(1)^2 + x(2);
g2 = - x(1) - 2 * x(2) + 3;
%g3 = 2 - x(1)^2 - x(2)^2;
g = [g1, g2];
m1 = -1; M1 = 1; m2 = -1; M2 = 1;
[Jk]= exists(x, y, f1, f2, 1, 1, g, m1, M1, m2, M2, -y(1), -y(2), 0);
%[y1, y2, jcontour3]= exists(x, y, f1, f2, 3, 3, g, m1, M1, m2, M2, -y(1), -y(2));
%[y1, y2, jcontour4]= exists(x, y, f1, f2, 4, 4, g, m1, M1, m2, M2, -y(1), -y(2));
%fyplot = max(-1/2 * 2^(1/3) - y1,-1/2 - y2 );
%surf(y1,y2,jcontour2, 'FaceColor','blue','EdgeColor','none');hold on
%surf(y1,y2,jcontour3, 'FaceColor','green','EdgeColor','none');hold on
%surf(y1,y2,jcontour4, 'FaceColor','red','EdgeColor','none');hold on
%surf(y1,y2,fyplot, 'FaceColor','black','EdgeColor','none');hold on
%contour(y1,y2,-jcontour2,[0 0],'b');hold on;
%contour(y1,y2,-jcontour3,[0 0],'g');hold on;
%contour(y1,y2,-jcontour4,[0 0],'r');hold on;
y1p = -1:0.01:1/2*2^(1/3);
plot(y1p,-y1p+y1p.^4,'k');
%contour(y1,y2,-jcontour4,[0 0],'r');hold on;
