% Figure_512_2dvesicles.m 
% script to solve for 2d vesicle shapes (simplified)

close all;
clear all;

N=500;
s=linspace(0,2*pi,N);
ds=s(2)-s(1);

theta=zeros(1,N);
costheta=zeros(1,N);
sintheta=zeros(1,N);
kappa=zeros(1,N);
X=zeros(1,N);
Y=zeros(1,N);

epsilon=0.0;

theta1=s+epsilon*sin(2*s)+((epsilon^2)/16)*sin(4*s);
kappa1=gradient(theta1,ds);

costheta=cos(theta1);
sintheta=sin(theta1);

X(1)=0;
for m=2:N
    X(m)=trapz(s(1:m),costheta(1:m));
end

Y(1)=0;
for n=2:N
    Y(n)=trapz(s(1:n),sintheta(1:n));
end

Xcom=sum(X)/N;
Ycom=sum(Y)/N;

Xshift1=X-Xcom;
Yshift1=Y-Ycom;

% calculate total arclength to check conservation

length=0;
for p=2:N
    dX=Xshift1(p)-Xshift1(p-1);
    dY=Yshift1(p)-Yshift1(p-1);
    length=length+sqrt(dX^2+dY^2);
end
length/(2*pi)

% calculate enclosed area

area=0;
for p=2:N
    dX=Xshift1(p)-Xshift1(p-1);
    dY=Yshift1(p)-Yshift1(p-1);
    area=area+0.5*(Xshift1(p)*dY-Yshift1(p)*dX);
end
area/pi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epsilon=0.5;

theta2=s+epsilon*sin(2*s)+((epsilon^2)/16)*sin(4*s);
kappa2=gradient(theta2,ds);

costheta=cos(theta2);
sintheta=sin(theta2);

X(1)=0;
for m=2:N
    X(m)=trapz(s(1:m),costheta(1:m));
end

Y(1)=0;
for n=2:N
    Y(n)=trapz(s(1:n),sintheta(1:n));
end

Xcom=sum(X)/N;
Ycom=sum(Y)/N;

Xshift2=X-Xcom;
Yshift2=Y-Ycom;

% calculate total arclength to check conservation

length=0;
for p=2:N
    dX=Xshift2(p)-Xshift2(p-1);
    dY=Yshift2(p)-Yshift2(p-1);
    length=length+sqrt(dX^2+dY^2);
end
length/(2*pi)

% calculate enclosed area

area=0;
for p=2:N
    dX=Xshift2(p)-Xshift2(p-1);
    dY=Yshift2(p)-Yshift2(p-1);
    area=area+0.5*(Xshift2(p)*dY-Yshift2(p)*dX);
end
area/pi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epsilon=1.0;

theta3=s+epsilon*sin(2*s)+((epsilon^2)/16)*sin(4*s);
kappa3=gradient(theta3,ds);

costheta=cos(theta3);
sintheta=sin(theta3);

X(1)=0;
for m=2:N
    X(m)=trapz(s(1:m),costheta(1:m));
end

Y(1)=0;
for n=2:N
    Y(n)=trapz(s(1:n),sintheta(1:n));
end

Xcom=sum(X)/N;
Ycom=sum(Y)/N;

Xshift3=X-Xcom;
Yshift3=Y-Ycom;

% calculate total arclength to check conservation

length=0;
for p=2:N
    dX=Xshift3(p)-Xshift3(p-1);
    dY=Yshift3(p)-Yshift3(p-1);
    length=length+sqrt(dX^2+dY^2);
end
length/(2*pi)

% calculate enclosed area

area=0;
for p=2:N
    dX=Xshift3(p)-Xshift3(p-1);
    dY=Yshift3(p)-Yshift3(p-1);
    area=area+0.5*(Xshift3(p)*dY-Yshift3(p)*dX);
end
area/pi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('position',[100 100 1500 500]);
t = tiledlayout(1,3,'TileSpacing','Compact','Padding','Compact');

nexttile;
% plot of kappa(s)

xlim([0 2*pi]);
ylim([-1.1 3.1]);

hold on;
box on;

plot([0 2*pi],[0 0],'--k','LineWidth',1.5);

plot(s,kappa1,'-k','LineWidth',2);
plot(s,kappa2,'-b','LineWidth',2);
plot(s,kappa3,'-r','LineWidth',2);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 pi/2 pi 3*pi/2 2*pi]);
xticklabels({'0','','$\pi$','','$2\pi$'});
yticks([-1 -0.5 0 0.5 1 1.5 2 2.5 3]);
yticklabels({'-1','','0','','1','','2','','3'});
xlabel('$\eta$','interpreter','latex','FontSize',17);
ylabel('$K(\eta)$','interpreter','latex','FontSize',17);

hold off;

nexttile;
% plot of theta(s)

xlim([0 2*pi]);
ylim([0 2*pi]); 

hold on;
box on;

plot([0 2*pi],[0 2*pi],'--k','LineWidth',1.5);

plot(s,theta1,'-k','LineWidth',2);
plot(s,theta2,'-b','LineWidth',2);
plot(s,theta3,'-r','LineWidth',2);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 pi/2 pi 3*pi/2 2*pi]);
xticklabels({'0','','$\pi$','','$2\pi$'});
yticks([0 pi/2 pi 3*pi/2 2*pi]);
yticklabels({'0','','$\pi$','','$2\pi$'});
xlabel('$\eta$','interpreter','latex','FontSize',17);
ylabel('$\theta(\eta)$','interpreter','latex','FontSize',17);

hold off;

nexttile;
% plot of shape (X(alpha),Y(alpha))

xlim([-1.5 1.5]);
ylim([-1.1 1.1]);

hold on;
box on;

axis equal;

plot([-1.5 1.5],[0 0],'--k','LineWidth',1.5);
plot([0 0],[-1.5 1.5],'--k','LineWidth',1.5);

plot(Xshift1,Yshift1,'-k','LineWidth',2);
fill(Xshift1,Yshift1,[0 0 0],'FaceAlpha',0.3);

plot(Xshift2,Yshift2,'-b','LineWidth',2);
fill(Xshift2,Yshift2,[0 0 1],'FaceAlpha',0.3);

plot(Xshift3,Yshift3,'-r','LineWidth',2);
fill(Xshift3,Yshift3,[1 0 0],'FaceAlpha',0.3);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([-1.5 -1 -0.5 0 0.5 1 1.5]);
xticklabels({'','-1','','0','','1',''});
yticks([-1 -0.5 0 0.5 1]);
yticklabels({'-1','','0','','1'});
xlabel('$X$','interpreter','latex','FontSize',17);
ylabel('$Y$','interpreter','latex','FontSize',17);

pause;
% exportgraphics(t,'Figure_vesicle.png','BackgroundColor','white');
exportgraphics(t,'Figure_512_2dvesicle.pdf','BackgroundColor','white');
hold off
close;


