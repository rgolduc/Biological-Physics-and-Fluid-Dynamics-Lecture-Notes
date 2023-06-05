% Figure_608_Taylordissipation.m
% plots dissipation ratio for two-sheet problem from Taylor (1951)

clear;
close;

N=201;


kh=linspace(0,4,N); 

num=sinh(kh).*cosh(kh)-kh;
den=sinh(kh).*cosh(kh)+kh;
ratio=(num./den).*tanh(kh).^2


t=figure('position',[100 250 600 500]);

hold on
box on;


plot(kh,ratio,'-b','Linewidth',3);


ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 4 0 1.05]);
xticks([0 1 2 3 4]);
xticklabels({'0','1','2','3','4'});
yticks([0 0.5 1]);
yticklabels({'0','0.5','1'});
xlabel('$\delta=kh$','interpreter','latex','FontSize',21);
ylabel('${\cal R}$','interpreter','latex','FontSize',21);

pause;
%exportgraphics(t,'Figure_Taylorsheet.png','BackgroundColor','none');
exportgraphics(t,'Figure_6.08_Taylordissipation.pdf','BackgroundColor','white');
hold off
close;









