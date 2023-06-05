% Figure_631_and_632_Jefferyorbits.m
% script to plot orientation angle and trajectories in Jeffery orbits

clear all;
close all;

tmax=2;
N=200;

time=linspace(0,tmax,2*N+1);

global r;

r=1;

for j=1:2*N+1
    if (j<=N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r);
    elseif (j>N/4+1) && (j<=3*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-pi;
    elseif(j>3*N/4+1) && (j<=5*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-2*pi;
    elseif (j>5*N/4+1) && (j<=7*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-3*pi;
    elseif(j>7*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-4*pi;
    end
end

phi1=phi;
cosphi1=cos(phi1);

r=2;

for j=1:2*N+1
    if (j<=N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r);
    elseif (j>N/4+1) && (j<=3*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-pi;
    elseif(j>3*N/4+1) && (j<=5*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-2*pi;
    elseif (j>5*N/4+1) && (j<=7*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-3*pi;
    elseif(j>7*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-4*pi;
    end
end

phi2=phi;
cosphi2=cos(phi2);

r=10;

for j=1:2*N+1
    if (j<=N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r);
    elseif (j>N/4+1) && (j<=3*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-pi;
    elseif(j>3*N/4+1) && (j<=5*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-2*pi;
    elseif (j>5*N/4+1) && (j<=7*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-3*pi;
    elseif(j>7*N/4+1)
        phi(j)=atan(-tan(2*pi*time(j))/r)-4*pi;
    end
end

phi3=phi;
cosphi3=cos(phi3);

%%%%%%%%%%%%%%%%%%%%%%%  Figure 6.31   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure('Position',[50 80 1000 400]); % laptop
figure('Position',[800 600 1200 500]); % office PC
t = tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact');

nexttile;

hold on;
box on;

axis([0 tmax -4*pi 0]);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
xticks([0 1 2]);
xticklabels({'0','1','2'});
yticks([-4*pi -2*pi 0]);
yticklabels({'-$4\pi$','-$2\pi$','0'});
xlabel('$t/T_{\rm orbit}$','interpreter','latex','FontSize',21);
ylabel('$\phi$','interpreter','latex','FontSize',21);

plot(time,phi1,'-k','LineWidth',3);
plot(time,phi2,'-b','LineWidth',3);
plot(time,phi3,'-r','LineWidth',3);

text(0.015,0.06,'(a)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);

hold off;

nexttile;

hold on;
box on;

axis([0 tmax -1 1]);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 1 2]);
xticklabels({'0','1','2'});
yticks([-1 0 1]);
yticklabels({'-1','0','1'});
xlabel('$t/T_{\rm orbit}$','interpreter','latex','FontSize',21);
ylabel('$\cos\phi$','interpreter','latex','FontSize',21);

% plot(time,cosphi1,'-k','LineWidth',3);
% plot(time,cosphi2,'-b','LineWidth',3);
% plot(time,cosphi3,'-r','LineWidth',3);
% 
% text(0.92,0.06,'(b)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);
% 
% pause;
% exportgraphics(t,'Figure_6.31_Jefferyorbits.pdf','BackgroundColor','white');
hold off
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%  Figure 6.32  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% t1=figure('Position',[50 80 800 360]); % laptop
t1=figure('Position',[800 600 1200 500]); % office PC

hold on;
box on;

r=5;

xstart=0.0;
ystart=0.0;
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
sol = ode45(@jefferyeoms,[0 tmax],[xstart,ystart],options);
Y=deval(sol,time);

xstart=0.0;
ystart=0.15;
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
sol = ode45(@jefferyeoms,[0 tmax],[xstart,ystart],options);
Y1=deval(sol,time);

xstart=0.0;
ystart=0.3;
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
sol = ode45(@jefferyeoms,[0 tmax],[xstart,ystart],options);
Y2=deval(sol,time);

axis([-6 16 -0.3 0.4]);
% axis equal;
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([-5 0 5 10 15]);
xticklabels({'-5','0','5','10','15'});
yticks([-0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4]);
yticklabels({'','-0.2','','0','','0.2','','0.4'});
xlabel('$X$','interpreter','latex','FontSize',21);
ylabel('$Y$','interpreter','latex','FontSize',21);

plot(Y(1,:),Y(2,:),'-r','LineWidth',3);
plot(Y(1,1),Y(2,1),'-o','MarkerEdgeColor','k','MarkerFaceColor','r','Markersize',12,'LineWidth',2);
plot(Y1(1,:),Y1(2,:),'-m','LineWidth',3);
plot(Y1(1,1),Y1(2,1),'-o','MarkerEdgeColor','k','MarkerFaceColor','m','Markersize',12,'LineWidth',2);
plot(Y2(1,:),Y2(2,:),'-b','LineWidth',3);
plot(Y2(1,1),Y2(2,1),'-o','MarkerEdgeColor','k','MarkerFaceColor','b','Markersize',12,'LineWidth',2);
plot([-6 16],[0 0],'--k','LineWidth',1);

pause;
exportgraphics(t1,'Figure_6.32_Jefferyorbits2.pdf','BackgroundColor','white');
hold off
close;


%%%%%%%%%%%%%%%

function dy=jefferyeoms(t,y)
%  returns the coupled odes
global r
    dy=zeros(2,1);
    if (t>=0) && (t<0.25)
        phi=atan(-tan(2*pi*t)/r);
    elseif (t>=0.25) && (t<0.75)
        phi=atan(-tan(2*pi*t)/r)-pi;
    elseif (t>=0.75) && (t<1.25)
        phi=atan(-tan(2*pi*t)/r)-2*pi;
    elseif (t>=1.25) && (t<1.75)
        phi=atan(-tan(2*pi*t)/r)-3*pi;
    elseif (t>=1.75) 
        phi=atan(-tan(2*pi*t)/r)-2*pi;
    end
    % phi=-2*pi*t;
    dy(1)=2*pi*(r+1/r)*y(2)+cos(phi);
    dy(2)=sin(phi);
end







 