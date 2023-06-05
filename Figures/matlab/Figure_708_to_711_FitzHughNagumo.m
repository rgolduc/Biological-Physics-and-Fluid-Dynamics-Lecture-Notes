% Figure_707_to_710_FitzHughNagumo.m 
% script to plot time series and phase space trajectories for FHN equations

clear all;
close all;

tmax=50;

global a b c z

a=0.7;
b=0.8;
c=3;
Vzero=0.3; % 0.2 (no spike) 0.3 (single spike) 0.4 (spike train)
z=-Vzero;
ustart=1.3;
vstart=-0.5;

U=-2.5:0.01:2.5;
V=U.^3/3-U;
V1=(a-U)/b;
V1a=(a-U)/1.6;
V2=U.^3/3-U-z;

potential=-0.5*U.^2+(1/12)*U.^4;
potential1=-0.5*U.^2+(1/12)*U.^4-U;

%%%%%%%%%%%%%%%%%%%%%%% first plot of basic nullcline structure

t0=figure('Position',[50 80 500 400]);

hold on;
box on;

options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
[~,Y] = ode45(@fhneoms,[0 tmax],[ustart,vstart],options);
plot(U,V,'-k','LineWidth',1.5); 
plot(U,V1,'color',[0.1328    0.5430    0.1328],'LineWidth',1.5); 
% plot(U,V1a,'--','color',[0.1328    0.5430    0.1328],'LineWidth',1.5); 

% find fixed point with z=0

myfun=@(x,Zz) (1/3)*x^3-Zz-x-(a-x)/b;
fun = @(x) myfun(x,0);
FPu=fzero(fun,1.2);
FPv=(a-FPu)/b;

% find fixed point with z as set above

funz = @(x) myfun(x,z);
FPuz=fzero(funz,1.2);
FPvz=(a-FPuz)/b;

plot(FPu,FPv,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',8);


axis([-2.5 2.5 -1.5 2.0]);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([-2 -1 0 1 2]);
xticklabels({'-2','-1','0','1','2'});
yticks([-1 0 1 2]);
yticklabels({'-1','0','1','2'});
xlabel('$u$','interpreter','latex','FontSize',17);
ylabel('$v$','interpreter','latex','FontSize',17);

plot([-2.5 2.5],[0 0],'-k',[0 0],[-1.5 2.0],'-k','LineWidth',0.5);
 
pause;
exportgraphics(t0,'Figure_FHNnullclines.png','BackgroundColor','white');
exportgraphics(t0,'Figure_FHNnullclines.pdf','BackgroundColor','white');
hold off

close;

%%%%%%%%%%%%%%%%%%%%%%%

figure('Position',[50 80 1000 400]);
t = tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact');

nexttile;

hold on;
box on;

options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
[~,Y] = ode45(@fhneoms,[0 tmax],[ustart,vstart],options);
plot(U,V,'-k',U,V1,'-k','LineWidth',1.5); 
plot(U,V2,'color',[0.1328    0.5430    0.1328],'LineWidth',1.5); 

% find fixed point with z=0

myfun=@(x,Zz) (1/3)*x^3-Zz-x-(a-x)/b;
fun = @(x) myfun(x,0);
FPu=fzero(fun,1.2);
FPv=(a-FPu)/b;

% find fixed point with z as set above

funz = @(x) myfun(x,z);
FPuz=fzero(funz,1.2);
FPvz=(a-FPuz)/b;

J11=c*(1-FPuz^2);
J12=c;
J21=-1/c;
J22=-b/c;
trace=J11+J22;
det=J11*J22-J12*J21;
trace^2-4*det

plot(FPu,FPv,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',8);
plot(FPuz,FPvz,'o','MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'MarkerSize',8);


axis([-2.5 2.5 -1.5 2.0]);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([-2 -1 0 1 2]);
xticklabels({'-2','-1','0','1','2'});
yticks([-1 0 1 2]);
yticklabels({'-1','0','1','2'});
xlabel('$u$','interpreter','latex','FontSize',17);
ylabel('$v$','interpreter','latex','FontSize',17);

% plot([-2.5 2.5],[0 0],'--k',[0 0],[-1.5 2.0],'--k',[FPuz FPuz],[-1.5 2.0],'--k','LineWidth',1);
plot([-2.5 2.5],[0 0],'--k',[0 0],[-1.5 2.0],'--k','LineWidth',1);
% pause;
plot(Y(:,1),Y(:,2),'-b','LineWidth',3);

text(0.02,0.92,'(a)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

% pause;
% 
% % plot phase space trajectories for various initial conditions in the spike
% % train regime
% 
% if (Vzero==0.4)
%     [T,Y] = ode45(@fhneoms,[0 tmax],[1 1],options);
%     plot(Y(1,1),Y(1,2),'o','MarkerEdgeColor','m','MarkerFaceColor',[1 0 1],'MarkerSize',8);
%     plot(Y(:,1),Y(:,2),'-m','LineWidth',1);
%     [T,Y] = ode45(@fhneoms,[0 tmax],[0.5 1.8],options);
%     plot(Y(1,1),Y(1,2),'o','MarkerEdgeColor','m','MarkerFaceColor',[1 0 1],'MarkerSize',8);
%     plot(Y(:,1),Y(:,2),'-m','LineWidth',1);
%     [T,Y] = ode45(@fhneoms,[0 tmax],[-1 0.4],options);
%     plot(Y(1,1),Y(1,2),'o','MarkerEdgeColor','m','MarkerFaceColor',[1 0 1],'MarkerSize',8);
%     plot(Y(:,1),Y(:,2),'-m','LineWidth',1);
%     [T,Y] = ode45(@fhneoms,[0 tmax],[-1 -0.5],options);
%     plot(Y(1,1),Y(1,2),'o','MarkerEdgeColor','m','MarkerFaceColor',[1 0 1],'MarkerSize',8);
%     plot(Y(:,1),Y(:,2),'-m','LineWidth',1);
%     [T,Y] = ode45(@fhneoms,[0 tmax],[-1.5 1.5],options);
%     plot(Y(1,1),Y(1,2),'o','MarkerEdgeColor','m','MarkerFaceColor',[1 0 1],'MarkerSize',8);
%     plot(Y(:,1),Y(:,2),'-m','LineWidth',1);
% end
% 
% pause;
% exportgraphics(t1,'Figure_FHN_phaseplane.png','BackgroundColor','white');
hold off

nexttile;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% t=figure;

hold on;
box on;

[T,Y] = ode45(@fhneoms,[0 tmax],[ustart,vstart],options);

plot(T,Y(:,1),'-b',T,Y(:,2),'-r','LineWidth',3);
hold on;

axis([0 tmax -2.5 2.5]);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 10 20 30 40 50]);
xticklabels({'0','10','20','30','40','50'});
yticks([-2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5]);
yticklabels({'','-2','','-1','','0','','1','','2',''});
xlabel('$t$','interpreter','latex','FontSize',17);
ylabel('$u,v$','interpreter','latex','FontSize',17);
text(10,2,'$u$','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
text(10,-0.75,'$v$','FontSize',17,'Interpreter','latex','Color',[1 0 0]);

text(0.02,0.92,'(b)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

pause;
exportgraphics(t,'Figure_FHN_firing.pdf','BackgroundColor','white');
exportgraphics(t,'Figure_FHN_firing.png','BackgroundColor','white');
hold off
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if (Vzero==0.4)
%     
%     t2=figure;
% 
%     box on;
% 
%     hold on;
% 
%     axis([-2.5 2.5 -3 3.0]);
%     ax=gca;
%     set(gca, 'FontName', 'Times New Roman');
%     ax.LineWidth=1.1;
%     ax.XAxis.FontSize = 15;
%     ax.YAxis.FontSize = 15;
%     ax.TickLabelInterpreter = 'latex';
%     ax.LabelFontSizeMultiplier = 1.15;
%     xticks([-2 -1 0 1 2]);
%     xticklabels({'-2','-1','0','1','2'});
%     yticks([-3 -2 -1 0 1 2 3]);
%     yticklabels({'-3','-2','-1','0','1','2','3'});
%     xlabel('$u$','interpreter','latex','FontSize',17);
%     ylabel('$V(u)$','interpreter','latex','FontSize',17);
% 
%     plot([-2.5 2.5],[0 0],'--k',[0 0],[-3 3],'--k','LineWidth',1);
%     plot(U,potential,'-b','LineWidth',3);
%     plot(U,potential1,'--b','LineWidth',3);
% 
%     pause;
% 
%     exportgraphics(t2,'Figure_FHN_potential.png','BackgroundColor','white');
%     hold off
%     close;
% end

%%%%%%%%%%%%%%%

function dy=fhneoms(t,y)
%  returns the coupled odes
global a b c z
    dy=zeros(2,1);
    dy(1)=c*(y(2)+y(1)-y(1)^3/3+z);
    dy(2)=-(y(1)-a+b*y(2))/c;
end







 