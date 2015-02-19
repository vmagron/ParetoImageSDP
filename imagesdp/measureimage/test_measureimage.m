close all;
clear all;
%hold on;
x = sdpvar(1,1);
y = sdpvar(1,1);
f1 = x(1)^2; 
lo = 0; up = 1;
[y1, y2, wk2]= measureimage(x, y, [f1], 2, [], lo, up);
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
%y1p = -1:0.01:1/2*2^(1/3);
%plot(y1p,-y1p+y1p.^4,'k');
%contour(y1,y2,-jcontour4,[0 0],'r');hold on;

hparetocheb = figure('visible','off'); set(0,'DefaultAxesFontName', 'Palatino');set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontname', 'Palatino');set(0,'DefaultTextFontSize', 20);
contourf(y1,wk2 - 1,[0 0],'y'); hold on; 
%axis([lo(1) up(1) lo(1) up(1)]); 
xlabel('\ity_1', 'Interpreter','tex'); ylabel('\ity_2', 'Interpreter','tex'); print -depsc '../../figs/test/test_measureimage2.eps';
