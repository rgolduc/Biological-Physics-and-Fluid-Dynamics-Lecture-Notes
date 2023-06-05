% Figure_302_stringvar.m
% plots the variance of a tense string as a function of position

clear all
close all

ex=linspace(0,1,200);

N=100;

sum=0*ex;
for n=1:N
   sum = sum + (sin(n*pi*ex).^2)/(n^2);
end

variance=(2/(pi^2))*sum;

t=figure; 

hold on
box on;

xlim([0 1]);
ylim([0 0.3]);

plot(ex,variance,'-b','Linewidth',2);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([0 0.1 0.2 0.3]);
yticklabels({'0','0.1','0.2','0.3'});
xlabel('$\xi=x/L$','interpreter','latex','FontSize',17);
ylabel('$F(\xi)$','interpreter','latex','FontSize',17);

pause;
% exportgraphics(t,'Figure_3.02_stringvar.png','BackgroundColor','none');
exportgraphics(t,'Figure_3.02_stringvar.pdf','BackgroundColor','none');
hold off
close;

