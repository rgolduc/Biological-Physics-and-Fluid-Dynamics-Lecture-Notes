% Figure_630_gyrotaxis.m
% script to plot trajectories from gyrotaxis equations

clear all;
close all;

tmax=15;
N=200;

time=linspace(0,tmax,2*N+1);

global beta beta_zero

beta=2.5;
beta_zero=-3;

figure('Position',[50 80 900 600]); % laptop
% figure('Position',[800 600 1200 800]); % office PC
t = tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact');

nexttile;

hold on;
box on;

xstart1=0.7;
zstart1=0.0;
phistart1=pi/4;
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-4]);
sol1 = ode45(@gyroeoms,[0 tmax],[xstart1,zstart1,phistart1],options);
Y1=deval(sol1,time);

xstart2=-0.5;
zstart2=0.0;
phistart2=5*pi/8;
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-4]);
sol2 = ode45(@gyroeoms,[0 tmax],[xstart2,zstart2,phistart2],options);
Y2=deval(sol2,time);

axis([-1 1 -3 3]);
axis equal;
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([-1 0 1]);
xticklabels({'-1','0','-1'});
yticks([-2 -0 2]);
yticklabels({'-2','0','2'});
xlabel('$X$','interpreter','latex','FontSize',21);
ylabel('$Z$','interpreter','latex','FontSize',21);

plot(Y1(1,:),Y1(2,:),'-r','LineWidth',3);
plot(Y1(1,1),Y1(2,1),'-o','MarkerEdgeColor','k','MarkerFaceColor','r','Markersize',12,'LineWidth',2);
plot(Y2(1,:),Y2(2,:),'-b','LineWidth',3);
plot(Y2(1,1),Y2(2,1),'-o','MarkerEdgeColor','k','MarkerFaceColor','b','Markersize',12,'LineWidth',2);

plot([-1 -1],[-3 3],'-k','LineWidth',1);
plot([1 1],[-3 3],'-k','LineWidth',1);
plot([0 0],[-3 3],'--k','LineWidth',1);

% annotation('arrow',[0.19 0.19 ],[0.362 0.462],'color','red','Linewidth',2);
arrow([0 3],[0 1]);
arrow([0.2 3],[0.2 1+0.08]);
arrow([0.4 3],[0.4 1+0.32]);
arrow([0.6 3],[0.6 1+0.72]);
arrow([0.8 3],[0.8 1+1.28]);
arrow([-0.2 3],[-0.2 1+0.08]);
arrow([-0.4 3],[-0.4 1+0.32]);
arrow([-0.6 3],[-0.6 1+0.72]);
arrow([-0.8 3],[-0.8 1+1.28]);
ex=linspace(-1,1,100);
wy=1+2*ex.^2;
plot(ex,wy,'-k','LineWidth',2);

text(0.015,0.96,'(a)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);

hold off;

nexttile;

hold on;
box on;

axis([0 tmax 0 pi]);
% axis equal;
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 tmax/3 2*tmax/3 tmax]);
xticklabels({'0','5','10','15'});
yticks([0 pi/2 pi]);
yticklabels({'0','$\pi/2$','$\pi$'});
xlabel('$T$','interpreter','latex','FontSize',21);
ylabel('$\phi$','interpreter','latex','FontSize',21);

plot(time,Y1(3,:),'-r','LineWidth',3);
plot(time,Y2(3,:),'-b','LineWidth',3);
text(0.015,0.96,'(b)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);


pause;
exportgraphics(t,'Figure_6.30_gyrotaxis.pdf','BackgroundColor','white');
hold off
close;


%%%%%%%%%%%%%%%

function dy=gyroeoms(t,y)
%  returns the coupled odes
global beta beta_zero
    dy=zeros(3,1);
    dy(1)=beta*cos(y(3));
    dy(2)=beta*sin(y(3))+beta_zero*(1-y(1)^2);
    dy(3)=-beta_zero*y(1)+cos(y(3));
end







 