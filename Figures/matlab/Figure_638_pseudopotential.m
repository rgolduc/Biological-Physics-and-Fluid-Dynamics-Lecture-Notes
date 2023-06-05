% Figure_638_pseudopotential.m
% plots the effective potential for two Volvox spheres near a no-slip
% surface

clear all
close all

x=linspace(0,6,200);

func=(-1/pi)./(x.^2+4).^(3/2);
func_approx=(-1/pi)./x.^3;

t=figure; 

hold on
box on;

xlim([0 6]);
ylim([-0.042 0]);

plot(x,func,'-b','Linewidth',2);
plot([2 2],[-0.042 0],'--k','LineWidth',1.5);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
xticks([0 2 4 6]);
xticklabels({'0','2','4','6'});
yticks([-1/(8*pi) 0]);
yticklabels({'$-1/8\pi$','0'});
xlabel('$X$','interpreter','latex','FontSize',21);
ylabel('$V(X)$','interpreter','latex','FontSize',21);

pause;
exportgraphics(t,'Figure_6.38_pseudopotential.pdf','BackgroundColor','white');
hold off
close;

