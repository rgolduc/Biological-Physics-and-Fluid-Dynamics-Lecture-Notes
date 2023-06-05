% Figure_411_and_412_Eulerbuckle.m
% script to plot aspects of Euler buckling solution

clear;
close;

global epsilon


N=101;
M=201;
P=7;
s=linspace(0,1,N); 
s_int=linspace(0,1,M);
ds=1/(M-1);

figure('position',[900 250 1200 500]);
t = tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact');

nexttile;

epslist=[0.001,0.01,0.05,0.1,0.2,0.3,0.7];
eps=0:0.001:1;

hold on
box on;

c=colororder;

xlim([0 1]);
ylim([-2 2]);

plot([0 1],[0 0],'--k','LineWidth',1);

for j=1:P
    epsilon=epslist(j);
    solinit=bvpinit(s,@guess_theta);
    sol = bvp4c(@bvpfcn,@bcfcn,solinit);    
    sol_int=deval(sol,s_int);
    theta=sol_int(1,:);
    plot(s_int,theta,'-b','Linewidth',2,'Color',[c(j,1) c(j,2) c(j,3)]);
end

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([-2 -1.5 -1 -0.5 0 0.5 1 1.5 2]);
yticklabels({'-2',' ','-1',' ','0',' ','1','','2'});
xlabel('$s/L$','interpreter','latex','FontSize',17);
ylabel('$\theta(s)$','interpreter','latex','FontSize',17);
text(0.02,0.92,'(a)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nexttile;

hold on
box on;

c=colororder;

xlim([0 1]);
ylim([0 0.5]);
 
plot([0 1],[0 0],'--k','LineWidth',1);

for j=1:P
    epsilon=epslist(j);
    solinit=bvpinit(s,@guess_theta);
    sol = bvp4c(@bvpfcn,@bcfcn,solinit);    
    sol_int=deval(sol,s_int);
    theta=sol_int(1,:);
    ex(1)=0;
    wy(1)=0;
    for k=2:M
     ex(k)=ex(k-1)+ds*cos(theta(k));
     wy(k)=wy(k-1)+ds*sin(theta(k));
    end
    hmax(j)=wy((M-1)/2+1);
    thetamax(j)=max(theta);
    plot(ex,wy,'-b','Linewidth',2,'Color',[c(j,1) c(j,2) c(j,3)]);
end

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15; 
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([0 0.1 0.2 0.3 0.4 0.5]);
yticklabels({'0','','','','','0.5'});
xlabel('$x/L$','interpreter','latex','FontSize',17);
ylabel('$y/L$','interpreter','latex','FontSize',17);
text(0.02,0.92,'(b)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

hold off;


pause;
exportgraphics(t,'Figure_Eulershapes.png','BackgroundColor','none');
exportgraphics(t,'Figure_Eulershapes.pdf','BackgroundColor','none');
hold off
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1 = figure;

hold on
box on;

c=colororder;

xlim([0 1]);
ylim([0 2.5]);

for j=1:P
    plot(epslist(j),thetamax(j),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',[c(j,1) c(j,2) c(j,3)]);
end

plot(eps,sqrt(8*eps),'--k','LineWidth',1);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([0 0.5 1 1.5 2 2.5]);
yticklabels({'0','','1','','2',''});
xlabel('$\epsilon$','interpreter','latex','FontSize',17);
ylabel('$\theta_{\rm max}$','interpreter','latex','FontSize',17);

pause;
exportgraphics(t1,'Figure_Eulershapes1.png','BackgroundColor','none');
exportgraphics(t1,'Figure_Eulershapes1.pdf','BackgroundColor','none');
hold off
close;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dydx = bvpfcn(x,y) % equation to solve
global epsilon
dydx = zeros(2,1);
dydx = [y(2)
       -4*pi^2*(1+epsilon)*sin(y(1))];
end
%--------------------------------
function res = bcfcn(ya,yb) % boundary conditions
res = [ya(1)
       yb(1)];
end
%--------------------------------
function g = guess_theta(x) % initial guess for y and y'
global epsilon
g = [sqrt(8*epsilon)*sin(2*pi*x)
     2*pi*sqrt(8*epsilon)*cos(2*pi*x)];
end







