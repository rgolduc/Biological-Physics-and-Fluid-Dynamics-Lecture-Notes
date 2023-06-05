% Figure_517_tethershapes.m
% script to plot results from membrane tether calculation

clear all;
close all;

global epsilon rzero d 

N=201;
epsilon=0.001;
rzero=0.1;

dlist=[0.1 0.2 0.3 0.4 0.5 0.6 0.7];

t=figure('position',[900 250 800 500]);

hold on
box on;

c=colororder;
for n=1:7
    d=dlist(n);
    z=linspace(0,d,N); 
    z_int=linspace(0,d,2*N);
    solinit=bvpinit(z,@guess);
    sol = bvp4c(@bvpfcn,@bcfcn,solinit);    
    sol_int=deval(sol,z_int);
    r=sol_int(1,:);
    %force(n)=r()
    plot(r,z_int,-r,z_int,'-',[-r(2*N) r(2*N)],[z_int(2*N) z_int(2*N)],'Linewidth',2,'Color',[c(n,1) c(n,2) c(n,3)]);
end
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
set(gca,'Xlim',[-1.05 1.05]);
set(gca,'Ylim',[0 1]);

ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
% axis([-1.05 1.05 0 2]);
axis equal;
xticks([-1 -0.5 0 0.5 1]);
xticklabels({'-1','-0.5','0','0.5','1'});
yticks([0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]);
yticklabels({'0','','','','','0.5','','','','','1'});
xlabel('$r(z)$','interpreter','latex','FontSize',17);
ylabel('$z$','interpreter','latex','FontSize',17);

pause;
% exportgraphics(t,'Figure_tethershapes.png','BackgroundColor','none');
exportgraphics(t,'Figure_517_tethershapes.pdf','BackgroundColor','white');
hold off
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dydx = bvpfcn(x,y) % equation to solve
global epsilon d rzero
dydx = zeros(2,1);
metric=sqrt(1+y(2)^2);
H=(y(3)/metric^3-1/(y(1)*metric))/2;
K=-y(3)/(y(1)*metric^4);
terms=H/epsilon-(2*y(2)*y(4)/(y(1)*metric^5)-10*y(2)*y(3)*y(4)/metric^7 ...
    +y(3)^2*(1-6*y(2)^2)/(y(1)*metric^7)-3*(y(3)^3)*(1+7*y(2)^2)/metric^9 ...
    +y(3)*(1-y(2)^2)/(y(1)^2*metric^5)-(y(2)^2)/((y(1))^3*metric^3))-(2*H^3-2*H*K);
dydx = [y(2)
        y(3)
        y(4)
        2*(metric^5)*terms];
end
%--------------------------------
function res = bcfcn(ya,yb) % boundary conditions
global epsilon d rzero
metric=sqrt(1+ya(2)^2);
H=(ya(3)/metric^3-1/(ya(1)*metric))/2;
res = [ya(1)-1
       H
       yb(1)-sqrt(epsilon/2)
       yb(2)];
end
%--------------------------------
function g = guess(x) % initial guess for y and y'
global epsilon d rzero
g = [sqrt(epsilon/2)+(1-sqrt(epsilon/2))*((d-x)^2)/d^2
     -2*(1-sqrt(epsilon/2))*(d-x)/d^2
     2*(1-sqrt(epsilon/2))/d^2
     0];
end







