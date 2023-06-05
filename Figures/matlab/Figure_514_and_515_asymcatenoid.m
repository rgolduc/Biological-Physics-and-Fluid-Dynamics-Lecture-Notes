% Figure_514_and_515_asymcatenoid.m
% script to plot quantities associated with asymmetric catenoid

clear all;
close all;

betalist=[0.05 0.2 0.4 0.6 0.8 1];

t=figure; 

hold on;

c=colororder;

for n=1:6
    beta=betalist(n);
    alpha=linspace(0,beta,200);
    numplus=beta+sqrt(beta^2-alpha.^2);
    numminus=beta-sqrt(beta^2-alpha.^2);
    denom=1-sqrt(1-alpha.^2);
    Dplus=0.5*alpha.*log(numplus./denom);
    Dminus=0.5*alpha.*log(numminus./denom);
    [M,I]=max(Dplus);
    Dmax(n)=M;
    alphamax(n)=alpha(I);
    plot(alpha,Dplus,'-',alpha,Dminus,'-k','LineWidth',2,'Color',[c(n,1) c(n,2) c(n,3)]);
    plot(alpha(I),Dplus(I),'o','LineWidth',2,'MarkerSize',6,'MarkerEdgeColor','k','MarkerFaceColor',[c(n,1) c(n,2) c(n,3)]);
end

text(0.0656,0.1113,'$0.05$','FontSize',17,'Interpreter','latex','Rotation',40,'Color',[c(1,1) c(1,2) c(1,3)]);
text(0.214,0.256,'$0.2$','FontSize',17,'Interpreter','latex','Color',[c(2,1) c(2,2) c(2,3)]);
text(0.410,0.290,'$0.4$','FontSize',17,'Interpreter','latex','Color',[c(3,1) c(3,2) c(3,3)]);
text(0.618,0.328,'$0.6$','FontSize',17,'Interpreter','latex','Color',[c(4,1) c(4,2) c(4,3)]);
text(0.808,0.357,'$0.8$','FontSize',17,'Interpreter','latex','Color',[c(5,1) c(5,2) c(5,3)]);
text(0.958,0.378,'$1$','FontSize',17,'Interpreter','latex','Color',[c(6,1) c(6,2) c(6,3)]);

box on;
ax=gca;
set(gca, 'FontName', 'Times New Roman');
set(gca,'PlotBoxAspectRatio',[1 0.6 1]);
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 1.1 0 0.7]);
xticks([0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]);
xticklabels({'0','','','','','0.5','','','','','1'});
yticks([0 0.1 0.2 0.3 0.4 0.5 0.6 0.7]);
yticklabels({'0','','','','','0.5','',''});
xlabel('$\alpha$','Interpreter','latex','Fontsize',17);
ylabel('D','Interpreter','latex','Fontsize',17);

pause;
exportgraphics(t,'Figure_asymcatenoid.png','BackgroundColor','none');
exportgraphics(t,'Figure_asymcatenoid.pdf','BackgroundColor','none');
hold off;
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=figure('position',[900 250 1500 900]);

y=linspace(0,1,200);

hold on;

for n=1:3
    cat=alphamax(n)*cosh(y*Dmax(n)/alphamax(n)-acosh(1/alphamax(n)));
   
    plot(cat+2.3*(n-1),1+y*Dmax(n),'-b',-cat+2.3*(n-1),1+y*Dmax(n),'-b','LineWidth',3);
    plot([-1+2.3*(n-1) 1+2.3*(n-1)],[1+y(1)*Dmax(n) 1+y(1)*Dmax(n)],'-k','LineWidth',1);
    plot([-cat(200)+2.3*(n-1) cat(200)+2.3*(n-1)],[1+y(200)*Dmax(n) 1+y(200)*Dmax(n)],'-k','LineWidth',1);
    plot(-1+2.3*(n-1),1+y(1)*Dmax(n),'o',-cat(200)+2.3*(n-1),1+y(200)*Dmax(n),'o','MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'MarkerSize',10);
    plot(1+2.3*(n-1),1+y(1)*Dmax(n),'o',cat(200)+2.3*(n-1),1+y(200)*Dmax(n),'o','MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'MarkerSize',10);

end

for n=4:6
    cat=alphamax(n)*cosh(y*Dmax(n)/alphamax(n)-acosh(1/alphamax(n)));
   
    plot(cat+2.3*(n-4),y*Dmax(n),'-b',-cat+2.3*(n-4),y*Dmax(n),'-b','LineWidth',3);
    plot([-1+2.3*(n-4) 1+2.3*(n-4)],[y(1)*Dmax(n) y(1)*Dmax(n)],'-k','LineWidth',1);
    plot([-cat(200)+2.3*(n-4) cat(200)+2.3*(n-4)],[y(200)*Dmax(n) y(200)*Dmax(n)],'-k','LineWidth',1);
    plot(-1+2.3*(n-4),y(1)*Dmax(n),'o',-cat(200)+2.3*(n-4),y(200)*Dmax(n),'o','MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'MarkerSize',10);
    plot(1+2.3*(n-4),y(1)*Dmax(n),'o',cat(200)+2.3*(n-4),y(200)*Dmax(n),'o','MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'MarkerSize',10);

end

axis equal;
set(gca,'XColor','none');
set(gca,'YColor','none')
box off;
axis([-1.05 5.65 -0.05 1.45]);
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});

pause;
% exportgraphics(t1,'Figure_asymcatenoidsolutions.png','BackgroundColor','none');
exportgraphics(t1,'Figure_asymcatenoidsolutions.pdf','BackgroundColor','white');
hold off;
close;
