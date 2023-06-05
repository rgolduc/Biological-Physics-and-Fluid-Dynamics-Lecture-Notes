 % Figure_701_and_703_Michaelismenten.m
 % script to plot Michaelis-Menten dynamics

clear all
close all

global kappa lambda epsilon

kappa=0.5;
lambda=1.0;
epsilon=0.1;

tau_max=3;
u=linspace(0.001,1,1000); 
tau=(1-u-kappa*log(u))/lambda;
tau_grid=linspace(0,tau_max,200);

options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
[T,Y] = ode45(@mmeoms,[0 tau_max],[1.0 0.0],options);
u_num=Y(:,1);
v_num=Y(:,2);

u_inner=1+0*tau_grid;
v_inner=(1-exp(-(1+kappa)*tau_grid/epsilon))/(1+kappa);

v_uniform=u./(u+kappa)-exp(-(1+kappa)*tau/epsilon)/(1+kappa);

t= figure;

nexttile;

hold on
box on;

xlim([0 tau_max]);
ylim([0 1.05]);

plot(T,u_num,'-k',T,v_num,'-b','LineWidth',3);
plot(T,u_num./(kappa+u_num),'--b','LineWidth',2);
plot(tau,u,'--k','LineWidth',2);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 1 2 3]);
xticklabels({'0','1','2','3'});
yticks([0 0.25 0.5 0.75 1]);
yticklabels({'0','','0.5','','1'});
xlabel('$\tau$','interpreter','latex','FontSize',17);
ylabel('$u,v$','interpreter','latex','FontSize',17);

text(0.286,0.884,'$u(\tau) (-)$','FontSize',17,'Interpreter','latex','Color',[0 0 0]);
text(0.4,0.8,'$u_0(\tau) (--)$','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

text(1.348,0.44,'$v(\tau) (-)$','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
text(1.628,0.353,'$v_0(\tau) (--)$','FontSize',17,'Interpreter','latex','Color',[0 0 1]);

text(0.9,0.95,'numerical solution','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

% text(0.91,0.94,'(a)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

pause;
exportgraphics(t,'Figure_MichaelisMenten1.pdf','BackgroundColor','none');
exportgraphics(t,'Figure_MichaelisMenten1.png','BackgroundColor','none');
hold off
close;

t1= figure;

hold on
box on;

xlim([0 tau_max]);
ylim([0 1.05]);

plot(T,u_num,'-k',T,v_num,'-b','LineWidth',3);
plot(tau_grid,u_inner,'--k',tau_grid,v_inner,'--b','LineWidth',2);
plot(tau,v_uniform,'-r','LineWidth',2);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 1 2 3]);
xticklabels({'0','1','2','3'});
yticks([0 0.25 0.5 0.75 1]);
yticklabels({'0','','0.5','','1'});
xlabel('$\tau$','interpreter','latex','FontSize',17);
ylabel('$u,v$','interpreter','latex','FontSize',17);

text(0.27,0.92,'$U_0(\tau) (--)$','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

text(1.54,0.58,'$V_0(\tau) (--)$','FontSize',17,'Interpreter','latex','Color',[0 0 1]);

text(0.13,0.32,'$v_{uniform} (\tau)$','FontSize',17,'Interpreter','latex','Color',[1 0 0]);

text(1.12,0.84,'matched asymptotics','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

% text(0.91,0.89,'(b)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);


pause;
exportgraphics(t1,'Figure_MichaelisMenten2.pdf','BackgroundColor','none');
exportgraphics(t1,'Figure_MichaelisMenten2.png','BackgroundColor','none');
hold off
close;

function dy=mmeoms(t,y)
global kappa lambda epsilon
    dy=zeros(2,1);
    dy(1)=-y(1)+(y(1)+kappa-lambda)*y(2);
    dy(2)=(y(1)-(y(1)+kappa)*y(2))/epsilon;
end


