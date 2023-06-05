% Figure_616_bacterialswimming.m
% script to plot RFT calculations of various properties of swimming bacteria vs. flagellar
% length

clear all;
close all;

ell=linspace(0,20,201); 
ell2=ell.^2;

rhos=2;
rhos3=rhos^3;

theta=pi/6;
s=sin(theta);
c=cos(theta);
s2=s^2;
c2=c^2;

rhos=0.5;
rhos3=rhos^3;

Unum1=4*ell*rhos3*s*c;
Uden1=(3*rhos+(1+s2)*ell).*(4*rhos3+(1+c2)*ell)-ell2*s2*c2;
Uratio1=Unum1./Uden1;
Onum1=ell*(1+c2).*(3*rhos+(1+s2)*ell)-ell2*s2*c2;
Oratio1=Onum1./Uden1;

rhos=1;
rhos3=rhos^3;

Unum2=4*ell*rhos3*s*c;
Uden2=(3*rhos+(1+s2)*ell).*(4*rhos3+(1+c2)*ell)-ell2*s2*c2;
Uratio2=Unum2./Uden2;
Onum2=ell*(1+c2).*(3*rhos+(1+s2)*ell)-ell2*s2*c2;
Oratio2=Onum2./Uden2;

rhos=2;
rhos3=rhos^3;

Unum3=4*ell*rhos3*s*c;
Uden3=(3*rhos+(1+s2)*ell).*(4*rhos3+(1+c2)*ell)-ell2*s2*c2;
Uratio3=Unum3./Uden3;
Onum3=ell*(1+c2).*(3*rhos+(1+s2)*ell)-ell2*s2*c2;
Oratio3=Onum3./Uden3;

%%%%%%%%%%%%%% three-panel figure %%%%%%%%%%%%%%%%%%%%%%

figure('position',[500 500 1600 500]);
t = tiledlayout(1,3,'TileSpacing','Compact','Padding','Compact');

nexttile;
hold on
box on;

plot(ell,Uratio1,'-k','Linewidth',3);
plot(ell,Uratio2,'-r','Linewidth',3);
plot(ell,Uratio3,'-b','Linewidth',3);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 20 0 0.2]);
xticks([0 5 10 15 20]);
xticklabels({'0','','10','','20'});
yticks([0 0.1 0.2]);
yticklabels({'0','0.1','0.2'});
xlabel('$\ell$','interpreter','latex','FontSize',21);
ylabel('swimming speed ${\cal U}$','interpreter','latex','FontSize',21);

text(1.93,0.04,'$\rho_c=0.5$','FontSize',18,'Interpreter','latex','Color',[0 0 0]);
text(5.34,0.085,'$\rho_c=1$','FontSize',18,'Interpreter','latex','Color',[1 0 0]);
text(12.7,0.14,'$\rho_c=2$','FontSize',18,'Interpreter','latex','Color',[0 0 1]);
text(0.01,0.95,'(a)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);

hold off;

nexttile;
hold on
box on;

plot(ell,Oratio1,'-k','Linewidth',3);
plot(ell,Oratio2,'-r','Linewidth',3);
plot(ell,Oratio3,'-b','Linewidth',3);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 20 0 1]);
xticks([0 5 10 15 20]);
xticklabels({'0','','10','','20'});
yticks([0 0.5 1]);
yticklabels({'0','0.5','1'});
xlabel('$\ell$','interpreter','latex','FontSize',21);
ylabel('body rotation frequency $\tilde{\Omega}$','interpreter','latex','FontSize',21);
text(0.01,0.95,'(b)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);

hold off;

nexttile;
hold on
box on;

plot(ell,Oratio1-1,'-k','Linewidth',3);
plot(ell,Oratio2-1,'-r','Linewidth',3);
plot(ell,Oratio3-1,'-b','Linewidth',3);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 20 -1 0]);
xticks([0 5 10 15 20]);
xticklabels({'0','','10','','20'});
yticks([-1 -0.5 0]);
yticklabels({'-1','-0.5','0'});
xlabel('$\ell$','interpreter','latex','FontSize',21);
ylabel('flagellar rotation frequency $\tilde{\Omega}-1$','interpreter','latex','FontSize',21);
text(0.01,0.95,'(c)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);

pause;
exportgraphics(t,'Figure_6.16_bacterialswimming.pdf','BackgroundColor','white');
hold off
close;









