% Figure_732_KSgrowth
% script to plot KS growth rate for chemotactic instability

clear all;
close all;


d=0.1;
lambda=1;
gamma=[0.0 0.1 0.2 0.3];

k=linspace(0,2.5,200); 
k2=k.^2;

b1=lambda+(d+1)*k2;
b2=lambda+(d+1)*k2;
b3=lambda+(d+1)*k2;
b4=lambda+(d+1)*k2;

c1=(d*(k2+lambda)-lambda*gamma(1)).*k2;
c2=(d*(k2+lambda)-lambda*gamma(2)).*k2;
c3=(d*(k2+lambda)-lambda*gamma(3)).*k2;
c4=(d*(k2+lambda)-lambda*gamma(4)).*k2;

desc1=b1.^2-4*c1;
desc2=b2.^2-4*c2;
desc3=b3.^2-4*c3;
desc4=b4.^2-4*c4;


sigma1p=(-b1+sqrt(b1.^2-4*c1))/2;
sigma1m=(-b1-sqrt(b1.^2-4*c1))/2;
sigma2p=(-b2+sqrt(b2.^2-4*c2))/2;
sigma2m=(-b2-sqrt(b2.^2-4*c2))/2;
sigma3p=(-b3+sqrt(b3.^2-4*c3))/2;
sigma3m=(-b3-sqrt(b3.^2-4*c3))/2;
sigma4p=(-b4+sqrt(b4.^2-4*c4))/2;
sigma4m=(-b4-sqrt(b4.^2-4*c4))/2;


figure;
t = tiledlayout(1,1,'TileSpacing','Compact','Padding','Compact');

nexttile;

hold on
box on;

xlim([0 2.5]);
ylim([-0.2 0.1]);

plot(k,sigma1p,'-b','LineWidth',3);
plot(k,sigma2p,'-b','LineWidth',3);
plot(k,sigma3p,'-b','LineWidth',3);
plot(k,sigma4p,'-b','LineWidth',3);

plot(k,sigma1m,'-r','LineWidth',3);
plot(k,sigma2m,'-r','LineWidth',3);
plot(k,sigma3m,'-r','LineWidth',3);
plot(k,sigma4m,'-r','LineWidth',3);

plot([0 2.5],[0 0],'--k','LineWidth',1);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
xticks([0 1 2]);
xticklabels({'0','1','2'});
yticks([-0.2 -0.15 -0.1 -0.05 0 0.05 0.1]);
yticklabels({'-0.2','','-0.1','','0','','0.1'});
xlabel('$k$','interpreter','latex','FontSize',21);
ylabel('$\sigma(k)$','interpreter','latex','FontSize',21);

% text(0.51,-0.4,'$\rho=0.2$','FontSize',16,'Interpreter','latex','Color',[0 0 0]);
% text(2.24,-0.17,'$0.4$','FontSize',16,'Interpreter','latex','Color',[0 0 0]);
% text(2.93,0.15,'$0.6$','FontSize',16,'Interpreter','latex','Color',[0 0 0]);
% 
% text(0.04,0.92,'(a)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

hold off;

% nexttile;
% 
% % panel (b)
% 
% hold on
% box on;
% 
% xlim([0 1]);
% ylim([0 1.25]);
% 
% rr=linspace(0.0001,1,1000); 
% rrho=(sqrt(rr)+sqrt(D)).^2;
% 
% plot(rr,rrho,'-b','LineWidth',3);
% 
% bb=1:0.01:1;
% 
% shade(rr,rrho);
% ax=gca;
% set(gca, 'FontName', 'Times New Roman');
% ax.LineWidth=1.1;
% ax.XAxis.FontSize = 15;
% ax.YAxis.FontSize = 15;
% ax.TickLabelInterpreter = 'latex';
% ax.LabelFontSizeMultiplier = 1.15;
% xticks([0 0.5 1]);
% xticklabels({'0','0.5','1'});
% yticks([0 0.5 1]);
% yticklabels({'1','0.5','1'});
% xlabel('$r$','interpreter','latex','FontSize',17);
% ylabel('$\rho$','interpreter','latex','FontSize',17);
% 
% text(0.1,0.96,'Turing','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
% text(0.1,0.86,'unstable','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
% 
% text(0.53,0.42,'Turing','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
% text(0.53,0.30,'stable','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
% 
% text(0.04,0.92,'(b)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);
% 
% hold off;
% 
% nexttile;
% 
% % panel (c)
% 
% hold on
% box on;
% 
% xlim([0 1]);
% ylim([0 1.25]);
% 
% rr=linspace(0.0001,1,1000); 
% rrho=(sqrt(1-rr)+sqrt(D)).^2;
% 
% plot(rr,rrho,'-b','LineWidth',3);
% 
% bb=1:0.01:1;
% 
% shade(rr,rrho);
% ax=gca;
% set(gca, 'FontName', 'Times New Roman');
% ax.LineWidth=1.1;
% ax.XAxis.FontSize = 15;
% ax.YAxis.FontSize = 15;
% ax.TickLabelInterpreter = 'latex';
% ax.LabelFontSizeMultiplier = 1.15;
% xticks([0 0.5 1]);
% xticklabels({'0','0.5','1'});
% yticks([0 0.5 1]);
% yticklabels({'1','0.5','1'});
% xlabel('$r$','interpreter','latex','FontSize',17);
% ylabel('$\rho$','interpreter','latex','FontSize',17);
% 
% text(0.17,0.42,'Turing','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
% text(0.17,0.3,'stable','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
% 
% text(0.43,0.96,'Turing','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
% text(0.43,0.86,'unstable','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
% 
% 
% text(0.835,0.92,'(c)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

pause;
% exportgraphics(t,'Figure_FHNgrowth.png','BackgroundColor','none');
exportgraphics(t,'Figure_7.32_KSgrowth.pdf','BackgroundColor','white');
hold off
close;



