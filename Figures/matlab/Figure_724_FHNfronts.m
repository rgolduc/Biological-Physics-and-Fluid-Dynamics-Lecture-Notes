% Figure_723_FHNfronts.m
% script to plot front evolution in FHN equation

clear all;
close all;

m = 0;
global epsilon D r rho

epsilon=0.01;
D=0.04;
r=0.40;
rho=0.15;

Tmax=350;
timefactor=10;
plotlist=[1 timefactor*Tmax/5 2*timefactor*Tmax/5 3*timefactor*Tmax/5 4*timefactor*Tmax/5 timefactor*Tmax];
offset=1.5;
x = linspace(-15,15,1001);
deltax=x(2)-x(1);
time = linspace(0,Tmax,timefactor*Tmax+1);
scaled_time=time*sqrt(2*D)*(0.5-r);

sol = pdepe(m,@pdex1pde,@pdex1ic1,@pdex1bc,x,time);
u = sol(:,:,1);
v = sol(:,:,2);

% find approximate front location by identifying first position where p<1/2
for i=1:timefactor*Tmax+1
   front_index(i)=find(u(i,:)<0.5,1);
   j=front_index(i);
   uj=u(i,j);
   ujm1=u(i,j-1);
   front_position(i)=x(j)+(0.5-ujm1)*deltax/(uj-ujm1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Position',[500 800 1000 400]);
t = tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact');

nexttile;

hold on
box on;

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;

axis([-10 10 -0.3 1.7+5*offset]);

xticks([-10 -5 0 5 10]);
xticklabels({'-10','-5','0','5','10'});
yticks([0 1]);
yticklabels({'0','1'});
xlabel('$x$','interpreter','latex');
ylabel('$u(x,t),v(x,t)$','interpreter','latex');

plot([-10 10],[0 0],'--k','LineWidth',1);
plot([-10 10],[offset offset],'--k','LineWidth',1);
plot([-10 10],[2*offset 2*offset],'--k','LineWidth',1);
plot([-10 10],[3*offset 3*offset],'--k','LineWidth',1);
plot([-10 10],[4*offset 4*offset],'--k','LineWidth',1);
plot([-10 10],[5*offset 5*offset],'--k','LineWidth',1);

plot(x,u(plotlist(1),:),'-b',x,u(plotlist(2),:)+offset,'-b',x,u(plotlist(3),:)+2*offset,'-b',x,u(plotlist(4),:)+3*offset,'-b',x,u(plotlist(5),:)+4*offset,'-b',x,u(plotlist(6),:)+5*offset,'-b','LineWidth',2.5);
plot(x,v(plotlist(1),:),'-r',x,v(plotlist(2),:)+offset,'-r',x,v(plotlist(3),:)+2*offset,'-r',x,v(plotlist(4),:)+3*offset,'-r',x,v(plotlist(5),:)+4*offset,'-r',x,v(plotlist(6),:)+5*offset,'-r','LineWidth',1);

plot(front_position(plotlist(1)),0.5,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
plot(front_position(plotlist(2)),0.5+offset,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
plot(front_position(plotlist(3)),0.5+2*offset,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
plot(front_position(plotlist(4)),0.5+3*offset,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
plot(front_position(plotlist(5)),0.5+4*offset,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
plot(front_position(plotlist(6)),0.5+5*offset,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);

text(0.02,0.874,'(a)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[p,S,mu]=polyfit(time(20:50),front_position(20:50),1);
x1=linspace(time(20),time(50),10);
y1=polyval(p,x1,S,mu);

speed=p(1)/mu(2);

nexttile;

hold on;
box on;

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;

axis([0 10 0 5]);

xticks([0 1 2 3 4 5 6 7 8 9 10]);
xticklabels({'0','','','','','5','','','','','10',''});
yticks([0 1 2 3 4 5]);
yticklabels({'0','1','2','3','4','5'});
xlabel('$(1/2-r)\sqrt{2D}t$','interpreter','latex');
ylabel('$Q(t)$','interpreter','latex');

plot(scaled_time,-front_position,'-b','LineWidth',2);
plot(x1,y1,'-k','LineWidth',2);

text(0.09,0.92,'(b)','Units','normalized','FontSize',17,'Interpreter','latex','Color',[0 0 0]);

pause;
exportgraphics(t,'Figure_FHNfrontmotion.pdf','BackgroundColor','white');
exportgraphics(t,'Figure_FHNfrontmotion.png','BackgroundColor','white');
hold off;
close;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c,f,s] = pdex1pde(x,t,u,DuDx)
global epsilon D r rho
   c = [1; epsilon];
   f = [D; 1].*DuDx;
   s = [-u(1)*(u(1)-r)*(u(1)-1)-rho*(u(2)-u(1)); u(1)-u(2)];
end

% --------------------------------------------------------------------------

function u0 = pdex1ic1(x)
global D  
width=2*sqrt(2*D);
    uzero = 0.5*(1-tanh((x+5)/width))+0.5*(1+tanh((x-5)/width));
    if (x<-5)
        vzero = 1-sinh(5)*exp(x);
    elseif ((x>=-5) && (x<=5))
        vzero=exp(-5)*cosh(x);
    elseif (x>5)
        vzero=1-sinh(5)*exp(-x);
    end
    u0=[uzero;vzero];
end

function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t)
   pl = [ul(1)-1; ul(2)-1];
   ql = [0;0];
   pr = [ur(1)-1; ur(2)-1];
   qr = [0;0];
end

