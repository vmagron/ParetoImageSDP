clear all;
x = sdpvar(2,1);
y = sdpvar(2,1);
f1 = -1/2 + x(1)^2; 
f2 = -1/2 + x(2)^2;
g1 = 1 - x(1)^2 - x(2)^2;
g = [g1];
m1 = -1; M1 = 1; m2 = -1; M2 = 1;
[y1, y2, jcontour2]= exists(x, y, f1, f2, 2, 2, g, m1, M1, m2, M2, y(1)^4 - y(1)^2 + y(1), y(2)^4 - y(2)^2 + y(2));
[y1, y2, jcontour3]= exists(x, y, f1, f2, 3, 3, g, m1, M1, m2, M2, y(1)^4 - y(1)^2 + y(1), y(2)^4 - y(2)^2 + y(2));
%[y1, y2, jcontour4]= exists(x, y, f1, f2, 4, 4, g, m1, M1, m2, M2, y(1)^4 - y(1)^2 + y(1), y(2)^4 - y(2)^2 + y(2));
fyplot = min(-1/2 + y1.^4 - y1.^2 + y1,-1/2 + y2.^4 - y2.^2 + y2 );
surf(y1,y2,jcontour2, 'FaceColor','blue','EdgeColor','none');hold on
surf(y1,y2,jcontour3, 'FaceColor','green','EdgeColor','none');hold on
%surf(y1,y2,jcontour4, 'FaceColor','red','EdgeColor','none');hold on
surf(y1,y2,fyplot, 'FaceColor','black','EdgeColor','none');hold on
%figure;plot3(y1,y2,jcontour2, 'b', y1,y2,jcontour3, '.g', y1,y2,jcontour4,'.r', y1,y2,fyplot,'.k')
