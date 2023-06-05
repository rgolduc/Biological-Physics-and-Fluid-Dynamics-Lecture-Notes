% Figure_404_and_405_biharmonic.m
% script to plot solutions of biharmonic equations

clear all
close all

kL=0:0.001:12;

modes=zeros(5,200);  
normalised_modes=zeros(5,200);    
L2norm=zeros(5,1);
ex=linspace(0,1,200);

func1=cos(kL);
func2=1./cosh(kL);

fun = @(x) cos(x)*cosh(x)-1; % function

x0=[0 3*pi/2 5*pi/2 7*pi/2 9*pi/2];
for n=1:5
    xzero = x0(n) ; % initial point
    x(n) = fzero(fun,xzero);
    f(n)=cos(x(n));
    B(n)=-(sinh(x(n))-sin(x(n)))/(cosh(x(n))-cos(x(n)));
end

normalised_modes(1,:)=cos(0*ex);
for m=2:5
    modes(m,:)=sin(x(m)*ex)+sinh(x(m)*ex)+B(m)*(cos(x(m)*ex)+cosh(x(m)*ex));
    L2norm(m)=trapz(ex,modes(m,:).^2);
    normalised_modes(m,:)=modes(m,:)/sqrt(L2norm(m));
end

t=figure; 

hold on
box on;

xlim([0 12]);
ylim([-1.1 1.1]);

plot(kL,func1,'-b',kL,func2,'-g','Linewidth',2);
plot([0 12],[0 0],'--k','LineWidth',1.5);
plot(x,f,'or','LineWidth',2,'MarkerSize',10,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor',[1,0,0]);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 pi/2 pi 3*pi/2 2*pi 5*pi/2 3*pi]);
xticklabels({'0',' ','$\pi$','','$2\pi$','','$3\pi$'});
yticks([-1 -0.5 0 0.5 1]);
yticklabels({'-1','-0.5','0','0.5','1'});
xlabel('$kL$','interpreter','latex','FontSize',17);
ylabel('$\cos kL$, $1/\cosh kL$','interpreter','latex','FontSize',17);

pause;
exportgraphics(t,'Figure_biharmonic.png','BackgroundColor','none');
exportgraphics(t,'Figure_biharmonic.pdf','BackgroundColor','none');
hold off
close;

t1=figure; 

hold on
box on;

c=colororder;

xlim([-0.1 1.1]);
ylim([-2.1 2.1]);

for j=1:5
    plot(ex,normalised_modes(j,:),'LineWidth',1.5,'Color',[c(j,1) c(j,2) c(j,3)]);
end 

plot([-1.1 1.1],[0 0],'--k','LineWidth',1.5);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([-2 -1.5 -1 -0.5 0 0.5 1 1.5 2]);
yticklabels({'-2','','-1','','0','','1','','2'});
xlabel('$x/L$','interpreter','latex','FontSize',17);
ylabel('$W_n(x)$','interpreter','latex','FontSize',17);

pause;
exportgraphics(t1,'Figure_biharmonic2.png','BackgroundColor','none');
exportgraphics(t1,'Figure_biharmonic2.pdf','BackgroundColor','none');
hold off
close;

