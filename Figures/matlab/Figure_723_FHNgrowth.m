% Figure_722_FHNgrowth
% script to plot FHN growth rate in fast inhibitor limit

clear all
close all


D=0.01;
r=0.35;
rho=[0.2 0.4 0.6];

k=linspace(0.0,10,1000); 
k2=k.^2;
sigma1=-D*k2 -r +rho(1)*k2./(1+k2);
sigma2=-D*k2 -r +rho(2)*k2./(1+k2);
sigma3=-D*k2 -r +rho(3)*k2./(1+k2);


figure;
t = tiledlayout(1,3,'TileSpacing','Compact','Padding','Compact');

nexttile;

hold on
box on;

xlim([0 10]);
ylim([-1 0.25]);

plot(k,sigma1,'-b','LineWidth',3);
plot(k,sigma2,'-b','LineWidth',3);
plot(k,sigma3,'-b','LineWidth',3);
plot([0 10],[0 0],'--k','LineWidth',1);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 5 10]);
xticklabels({'0','5','10'});
yticks([-1 -0.5 0]);
yticklabels({'-1','-0.5','0'});
xlabel('$k$','interpreter','latex','FontSize',17);
ylabel('$\sigma(k)$','interpreter','latex','FontSize',17);

text(0.51,-0.4,'$\rho=0.2$','FontSize',16,'Interpreter','latex','Color',[0 0 0]);
text(2.24,-0.17,'$0.4$','FontSize',16,'Interpreter','latex','Color',[0 0 0]);
text(2.93,0.15,'$0.6$','FontSize',16,'Interpreter','latex','Color',[0 0 0]);

text(0.04,0.92,'(a)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

hold off;

nexttile;

% panel (b)

hold on
box on;

xlim([0 1]);
ylim([0 1.25]);

rr=linspace(0.0001,1,1000); 
rrho=(sqrt(rr)+sqrt(D)).^2;

plot(rr,rrho,'-b','LineWidth',3);

bb=1:0.01:1;

shade(rr,rrho);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([0 0.5 1]);
yticklabels({'1','0.5','1'});
xlabel('$r$','interpreter','latex','FontSize',17);
ylabel('$\rho$','interpreter','latex','FontSize',17);

text(0.1,0.96,'Turing','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
text(0.1,0.86,'unstable','FontSize',17,'Interpreter','latex','Color',[0 0 1]);

text(0.53,0.42,'Turing','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
text(0.53,0.30,'stable','FontSize',17,'Interpreter','latex','Color',[0 0 1]);

text(0.04,0.92,'(b)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

hold off;

nexttile;

% panel (c)

hold on
box on;

xlim([0 1]);
ylim([0 1.25]);

rr=linspace(0.0001,1,1000); 
rrho=(sqrt(1-rr)+sqrt(D)).^2;

plot(rr,rrho,'-b','LineWidth',3);

bb=1:0.01:1;

shade(rr,rrho);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([0 0.5 1]);
yticklabels({'1','0.5','1'});
xlabel('$r$','interpreter','latex','FontSize',17);
ylabel('$\rho$','interpreter','latex','FontSize',17);

text(0.17,0.42,'Turing','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
text(0.17,0.3,'stable','FontSize',17,'Interpreter','latex','Color',[0 0 1]);

text(0.43,0.96,'Turing','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
text(0.43,0.86,'unstable','FontSize',17,'Interpreter','latex','Color',[0 0 1]);


text(0.835,0.92,'(c)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

pause;
exportgraphics(t,'Figure_FHNgrowth.pdf','BackgroundColor','none');
exportgraphics(t,'Figure_FHNgrowth.png','BackgroundColor','none');
hold off
close;



