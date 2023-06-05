% Figure_414_EHD.m
% script to plot solutions to elastohydrodynamic problem for infinite
% length filament

clear all
close all

C8=cos(pi/8);
S8=sin(pi/8);

chimax=6;

chi=0:0.001:chimax;

tau=0;
func1=0.5*(exp(-C8*chi).*cos(tau+S8*chi)+exp(-S8*chi).*cos(tau-C8*chi));

tau=pi/4;
func2=0.5*(exp(-C8*chi).*cos(tau+S8*chi)+exp(-S8*chi).*cos(tau-C8*chi));

tau=pi/2;
func3=0.5*(exp(-C8*chi).*cos(tau+S8*chi)+exp(-S8*chi).*cos(tau-C8*chi));

tau=3*pi/4;
func4=0.5*(exp(-C8*chi).*cos(tau+S8*chi)+exp(-S8*chi).*cos(tau-C8*chi));

tau=pi;
func5=0.5*(exp(-C8*chi).*cos(tau+S8*chi)+exp(-S8*chi).*cos(tau-C8*chi));

tau=5*pi/4;
func6=0.5*(exp(-C8*chi).*cos(tau+S8*chi)+exp(-S8*chi).*cos(tau-C8*chi));

tau=3*pi/2;
func7=0.5*(exp(-C8*chi).*cos(tau+S8*chi)+exp(-S8*chi).*cos(tau-C8*chi));

tau=7*pi/4;
func8=0.5*(exp(-C8*chi).*cos(tau+S8*chi)+exp(-S8*chi).*cos(tau-C8*chi));

t=figure; 

hold on
box on;

xlim([0 chimax]);
ylim([-1.1 1.1]);

plot(chi,func1,chi,func2,chi,func3,chi,func4,chi,func5,chi,func6,chi,func7,chi,func8,'Linewidth',2);
plot([0 chimax],[0 0],'--k','LineWidth',1.5);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 1 2 3 4 5 6]);
xticklabels({'0','','2','','4','','6'});
yticks([-1 -0.5 0 0.5 1]);
yticklabels({'-1','','0','','1'});
xlabel('$\chi$','interpreter','latex','FontSize',17);
ylabel('$h_{\infty}/h_0$','interpreter','latex','FontSize',17);

pause;
% exportgraphics(t,'Figure_EHDinfinity.png','BackgroundColor','none');
exportgraphics(t,'Figure_EHDinfinity.pdf','BackgroundColor','none');
hold off
close;

