% Figure_304_polymers.m
% script to plot force-extension curves for polymer models
clear all
close all

f=0.001:0.001:5;

fhc=tanh(f);
fjc=coth(f)-1./f;

t=figure; 

hold on
box on;

xlim([0 5]);
ylim([0 1.03]);

plot(f,fhc,'-b','Linewidth',2);
plot(f,fjc,'-','Color',[0.4660 0.6740 0.1880],'Linewidth',2);
plot([0 5],[1 1],'--k','LineWidth',1.5);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 1 2 3 4 5]);
xticklabels({'0','1','2','3','4','5'});
yticks([0 0.25 0.5 0.75 1]);
yticklabels({'0','','0.5','','1'});
xlabel('$f$','interpreter','latex','FontSize',17);
ylabel('$\langle z\rangle/L$','interpreter','latex','FontSize',17);

pause;
exportgraphics(t,'Figure_polymers.png','BackgroundColor','none');
exportgraphics(t,'Figure_polymers.pdf','BackgroundColor','none');
hold off
close;

