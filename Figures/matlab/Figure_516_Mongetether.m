% Figure_516_Mongetether.m
% script to plot results from tether calculation in Monge representation

clear;
close;

global epsilon rzero d 

N=201;
epsilon=0.005;
rzero=0.1;
d=0.6;

r=linspace(rzero,1,N); 
r_int=linspace(rzero,1,4*N);
r_asym=linspace(0,1,4*N);

param=rzero/sqrt(epsilon);
numerator=param*besselk(1,param)*log(r_int)+besselk(0,r_int/sqrt(epsilon));
denominator=param*besselk(1,param)*log(rzero)+besselk(0,param);
composite=numerator/denominator;
asymptotic=(log(r_asym)+besselk(0,r_asym/sqrt(epsilon)))/(log(2*sqrt(epsilon))-0.5772);

t=figure('position',[900 250 800 500]);

hold on
box on;

solinit=bvpinit(r,@guess);
sol = bvp4c(@bvpfcn,@bcfcn,solinit);    
sol_int=deval(sol,r_int);
zee=sol_int(1,:);
plot(r_int,zee,'-b',-r_int,zee,'-b','Linewidth',3);
plot(r_int,composite,'--r',-r_int,composite,'--r','LineWidth',3);
plot(r_asym,asymptotic,'-k',-r_asym,asymptotic,'-k','LineWidth',2);


ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([-1.05 1.05 0 1.05]);
xticks([-1 -0.5 0 0.5 1]);
xticklabels({'-1','-0.5','0','0.5','1'});
yticks([0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]);
yticklabels({'0','','','','','0.5','','','','','1'});
xlabel('$r$','interpreter','latex','FontSize',17);
ylabel('$z(r)/2d$','interpreter','latex','FontSize',17);

pause;
% exportgraphics(t,'Figure_Mongetether.png','BackgroundColor','none');
exportgraphics(t,'Figure_516_Mongetether.pdf','BackgroundColor','none');
hold off
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dydx = bvpfcn(x,y) % equation to solve
global epsilon d rzero
dydx = zeros(2,1);
dydx = [y(2)
        y(3)
        y(4)
        -2*y(4)/x+y(3)/(x^2)-y(2)/(x^3)+(y(3)+y(2)/x)/epsilon];
end
%--------------------------------
function res = bcfcn(ya,yb) % boundary conditions
global epsilon d rzero
res = [ya(1)-1
       ya(2)
       yb(1)
       yb(2)+yb(3)];
end
%--------------------------------
function g = guess(x) % initial guess for y and y'
global epsilon d rzero
g = [(1-x)/(1-rzero)
     -1/(1-rzero)
     0
     0];
end







