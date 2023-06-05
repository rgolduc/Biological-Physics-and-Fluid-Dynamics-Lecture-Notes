% Figure_502_and_504_catenoids.m
% script to plot various quantities related to catenoid stability

close all;
clear all;

% first plot transcendental relationship for several values of h/2r_0 and
% find solutions by a simple crossing criterion

D=[0.1 0.3 0.5 0.60];

alpha=linspace(0,1.0,200);

figure('position',[300 500 1060 400]);
t = tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact');

% panel (a)

nexttile;
c=colororder;

func=alpha.*cosh(D(1)./alpha)-1;
k_high=find(func(112:200)>0,1);
cross_high(1)=alpha(112+k_high-1)-(alpha(112+k_high)-alpha(112+k_high-1))*func(112+k_high-1)/(func(112+k_high)-func(112+k_high-1));
k_low=find(func(1:108)<0,1);
cross_low(1)=0.5*(alpha(k_low-1)+alpha(k_low));

plot(alpha,func,'Linewidth',1.5,'Color',[c(1,1) c(1,2) c(1,3)]);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;

hold on;
plot(cross_low(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'MarkerSize',6);
plot(cross_high(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 1],'MarkerSize',6);
axis([0.0 1 -0.9 0.9]);
xticks([0 0.25 0.5 0.75 1]);
xticklabels({'0','','0.5','','1'});
yticks([-0.75 -0.5 -0.25 0 0.25 0.5 0.75]);
yticklabels({'','-0.5','','0','','0.5',''});

xlabel('$\alpha$','interpreter','latex');
ylabel('$\alpha \cosh(D/\alpha)-1$','interpreter','latex');
plot([0.0 1],[0 0],'--k','Linewidth',1.5);
for j=2:4
    func=alpha.*cosh(D(j)./alpha)-1;
    k_high=find(func(112:200)>0,1);
    cross_high(j)=alpha(112+k_high-1)-(alpha(112+k_high)-alpha(112+k_high-1))*func(112+k_high-1)/(func(112+k_high)-func(112+k_high-1));
    k_low=find(func(1:108)<0,1);
    cross_low(j)=0.5*(alpha(k_low-1)+alpha(k_low));
    plot(alpha,func,'Linewidth',1.5,'Color',[c(j,1) c(j,2) c(j,3)]);
    plot(cross_low(j),0,'o','MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'MarkerSize',6);
    plot(cross_high(j),0,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 1],'MarkerSize',6);
end

func=alpha.*cosh((0.66274)./alpha)-1;
plot(alpha,func,'Linewidth',1.5,'Color',[c(5,1) c(5,2) c(5,3)]);
plot(0.5524,0,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',6);

func=alpha.*cosh((0.8)./alpha)-1;
plot(alpha,func,'Linewidth',1.5,'Color',[c(6,1) c(6,2) c(6,3)]);

text(0.05,-0.7,'$D\!=\!0.1$','FontSize',14,'Interpreter','latex','Color',[c(1,1) c(1,2) c(1,3)]);
text(0.08,-0.5,'$0.3$','FontSize',15,'Interpreter','latex','Color',[c(2,1) c(2,2) c(2,3)]);
text(0.25,-0.25,'$0.5$','FontSize',15,'Interpreter','latex','Color',[c(3,1) c(3,2) c(3,3)]);
text(0.32,-0.11,'$0.6$','FontSize',15,'Interpreter','latex','Color',[c(4,1) c(4,2) c(4,3)]);
text(0.40,0.12,'$D_c$','FontSize',15,'Interpreter','latex','Color',[c(5,1) c(5,2) c(5,3)]);
text(0.48,0.38,'$0.8$','FontSize',15,'Interpreter','latex','Color',[c(6,1) c(6,2) c(6,3)]);

text(0.91,0.94,'(a)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

hold off;

% crossing points using fzero routine and good guesses

nexttile;

% panel (b)

ho2rz=linspace(0.01,0.662,652);

ar_high=zeros(1,652);
ar_high(652)=0.5742; % ar_high(1)=1;

for j=652:-1:1
    ho2r=ho2rz(j);
    myfun=@(x,ho2r) x*cosh(ho2r/x)-1;
    fun = @(x) myfun(x,ho2r);
    if j==652
        x = fzero(fun,ar_high(652));
    else
        x = fzero(fun,ar_high(j+1));
    end
    ar_high(j)=x;
end

ar_low=zeros(1,652);
ar_low(652)=0.5306; % ar_low(1)=0.02;

for j=652:-1:1
    ho2r=ho2rz(j);
    myfun=@(x,ho2r) x*cosh(ho2r/x)-1;
    fun = @(x) myfun(x,ho2r);
    if j==652
        x = fzero(fun,ar_low(652));
    else
        x = fzero(fun,ar_low(j+1));
    end
    ar_low(j)=x;
end

plot(ho2rz,ar_high,'-b',ho2rz,ar_low,'-r','LineWidth',1.5);
hold on;
plot(0.66274,0.5524,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',6);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;

axis([0 0.8 0.0 1]);

xticks([0 0.2 0.4 0.6]);
xticklabels({'0','0.2','0.4','0.6'});
yticks([0 0.25 0.5 0.75 1]);
yticklabels({'0','0.25','0.5','0.75','1'});

xlabel('$D$','interpreter','latex');
ylabel('$\alpha$','interpreter','latex');
text(0.4,0.22,'$\alpha_-$','FontSize',15,'Interpreter','latex','Color',[1 0 0]);
text(0.4,0.85,'$\alpha_+$','FontSize',15,'Interpreter','latex','Color',[0 0 1]);

plot([0.66274 0.66274],[0 0.2],'--k','LineWidth',1.5);
plot([0 0.1],[0.5524 0.5524],'--k','LineWidth',1.5);
plot([0.66274 0.80],[0.5524 0.5524],':k','LineWidth',1.8);

text(0.645,0.21,'$D_c$','FontSize',14,'Interpreter','latex','Color',[0 0 0]);
text(0.11,0.55,'$\alpha_c$','FontSize',14,'Interpreter','latex','Color',[0 0 0]);

text(0.91,0.94,'(b)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

epsilon=linspace(0,0.4);
alpha_plus=0.5524+sqrt(2)*((0.5524^2)/0.66274)*sqrt(epsilon);
alpha_minus=0.5524-sqrt(2)*((0.5524^2)/0.66274)*sqrt(epsilon);
plot(0.66274*(1-epsilon),alpha_plus,'--b',0.66274*(1-epsilon),alpha_minus,'--r','LineWidth',1.5)

% exportgraphics(t,'Figure_catenoidrelations.png','BackgroundColor','none');
exportgraphics(t,'Figure_502_catenoidrelations.pdf','BackgroundColor','white');

pause;
hold off;
close;

figure('position',[300 500 530 400]);
t = tiledlayout(1,1,'TileSpacing','Compact','Padding','Compact');

nexttile;

rescaled_area_high=0.5*(sinh(2*ho2rz./ar_high)+2*ho2rz./ar_high)./(cosh(ho2rz./ar_high).^2);
rescaled_area_low=0.5*(sinh(2*ho2rz./ar_low)+2*ho2rz./ar_low)./(cosh(ho2rz./ar_low).^2);

xcrit=0.66274/0.5524;
alphac=0.5524;
epsilon=linspace(0,0.36);
Dee=0.66274*(1+epsilon);
area_stretched=tanh(xcrit*(1+epsilon)).*(alphac^2+tanh(xcrit*(1+epsilon)).^2).^0.5...
    +alphac^2*asinh(tanh(xcrit*(1+epsilon))/alphac);

plot(ho2rz,rescaled_area_high,'-b',ho2rz,rescaled_area_low,'-r','LineWidth',1.5);
hold on;
plot(0.66274,1.199,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',6);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;

axis([0 0.85 0.0 1.4]);

xticks([0 0.2 0.4 0.6 0.8]);
xticklabels({'0','0.2','0.4','0.6','0.8'});
yticks([0 0.25 0.5 0.75 1 1.25]);
yticklabels({'0','0.25','0.5','0.75','1', '1.25'});

xlabel('$D$','interpreter','latex');
ylabel('${\cal A}$','interpreter','latex');

text(0.35,1.12,'unstable','FontSize',14,'Rotation',5,'Interpreter','latex','Color',[1 0 0]);
text(0.40,0.67,'stable','FontSize',14,'Rotation',42,'Interpreter','latex','Color',[0 0 1]);
text(0.15,0.20,'subcritical','FontSize',14,'Rotation',42,'Interpreter','latex','Color',[0 0 0]);
text(0.71,1.17,'super-','FontSize',14,'Rotation',22,'Interpreter','latex','Color',[0 0 0]);
text(0.72,1.08,'critical','FontSize',14,'Rotation',22,'Interpreter','latex','Color',[0 0 0]);


plot([0.66274 0.66274],[0 0.4],'-.k',[0.66274 0.66274],[0.5 1.199],'-.k','LineWidth',1.5);
plot(Dee,area_stretched,':k','LineWidth',1.8);
plot([0.528 0.528],[0 0.4],':k',[0.528 0.528],[0.5 1.0],':k','LineWidth',1.5);
plot([0 0.15],[1.199 1.199],'-.k','LineWidth',1.5);
% plot([0.528 0.80],[1.0 1.0],':k','LineWidth',1.5);


text(0.645,0.44,'$D_c$','FontSize',15,'Interpreter','latex','Color',[0 0 0]);
text(0.51,0.44,'$D^*$','FontSize',15,'Interpreter','latex','Color',[0 0 0]);
text(0.145,1.18,'${\cal A}_c$','FontSize',15,'Interpreter','latex','Color',[0 0 0]);

text(0.015,0.94,'(c)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

% exportgraphics(t,'Figure_catenoidarea.png','BackgroundColor','none');
exportgraphics(t,'Figure_504_catenoidarea.pdf','BackgroundColor','white');
pause;
hold off;
close; 

