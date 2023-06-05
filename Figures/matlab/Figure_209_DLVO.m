% Figure_209_DLVO.m
% plots the DLVO potential versus surface separation, in scaled units

clear all
close all

Xmax=2.0;

x=0.001:0.001:Xmax;
A=30;


vdW=-(x.^(-2)-2*(1+x).^(-2)+(2+x).^(-2));

K=5.0;
electro=A*(coth(0.5*K*x)-1);
energy1=vdW+electro;

K=5.5;
electro=A*(coth(0.5*K*x)-1);
energy2=vdW+electro;

K=6.0;
electro=A*(coth(0.5*K*x)-1);
energy3=vdW+electro;

K=6.5;
electro=A*(coth(0.5*K*x)-1);
energy4=vdW+electro;

K=7.0;
electro=A*(coth(0.5*K*x)-1);
energy5=vdW+electro;

t=figure; 

hold on
box on;

xlim([0 Xmax]);
ylim([-5 5]);

plot(x,vdW,'-b','Linewidth',2);
plot(x,electro,'-r','Linewidth',2);
plot(x,energy1,'-k','Linewidth',3);
plot(x,energy2,'-k','Linewidth',3);
plot(x,energy3,'-k','Linewidth',3);
plot(x,energy4,'-k','Linewidth',3);
plot(x,energy5,'-k','Linewidth',3);
plot([0 Xmax],[0 0],'--k','LineWidth',1.5);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1 1.5 2]);
xticklabels({'0','0.5','1','1.5','2'});
yticks([-5 0 5]);
yticklabels({'-5','0','5'});
xlabel('$x$','interpreter','latex','FontSize',17);
ylabel('${\cal V}$','interpreter','latex','FontSize',17);

pause;
exportgraphics(t,'Figure_DLVO.pdf','BackgroundColor','none');
hold off
close;

t1=figure; 

hold on
box on;

xlim([0 Xmax]);
ylim([-5 5]);

plot(x,vdW,'-b','Linewidth',2);
plot(x,electro,'-r','Linewidth',2);
plot(x,energy1,'-k','Linewidth',3);
plot(x,energy2,'-k','Linewidth',3);
plot(x,energy3,'-k','Linewidth',3);
plot(x,energy4,'-k','Linewidth',3);
plot(x,energy5,'-k','Linewidth',3);
plot([0 Xmax],[0 0],'--k','LineWidth',1.5);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1 1.5 2]);
xticklabels({'','','','',''});
yticks([-5 0 5]);
yticklabels({'','',''});
% xlabel('$x$','interpreter','latex','FontSize',17);
% ylabel('${\cal V}$','interpreter','latex','FontSize',17);

pause;
exportgraphics(t1,'Figure_DLVO.png');
hold off
close;


