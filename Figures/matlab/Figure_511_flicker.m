% Figure_511_flicker
% script to plot scaling function from Brochard-Lennon flicker
% calculation

clear all
close all

chimax=4.0*pi;
chi=linspace(0,chimax,200);

fun = @(x,c) (x.^3).*besselj(0,c*x)./(1+x.^(12));

for n=1:200
    chi_calc=chi(n);
    G(n)=(6*sqrt(3)/pi)*integral(@(x) fun(x,chi_calc),0,Inf);
end

t=figure; 

hold on
box on;

xlim([0 chimax]);
ylim([-0.3 1.1]);

plot(chi,G,'-b','Linewidth',2);

plot([0 chimax],[0 0],'--k','LineWidth',1.5);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 pi 2*pi 3*pi 4*pi]);
xticklabels({'0','','$2\pi$','','$4\pi$'});
yticks([-0.25 0 0.25 0.5 0.75 1]);
yticklabels({'','0','','0.5','','1'});
xlabel('$\chi=R/\ell(\omega)$','interpreter','latex','FontSize',17);
ylabel('$G(\chi)$','interpreter','latex','FontSize',17);

pause;
% exportgraphics(t,'Figure_flickercorrelation.png','BackgroundColor','none');
exportgraphics(t,'Figure_511_flicker.pdf','BackgroundColor','white');
hold off
close;




