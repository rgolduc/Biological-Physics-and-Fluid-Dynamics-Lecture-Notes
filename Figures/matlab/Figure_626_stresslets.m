% Figure_626_stresslets.m
% plots stresslet streamlines and heat map of speed for pusher and puller

clear all;
close all;

N=201;     % linear dimension of grid
dx=0.02;    % spacing between grid points in x
dz=dx;     % spacing between grid points in y
L=dx*N;    % physical size of array (linear dimension)
h=1;

x=dx*(-N/2-0.5:N/2+0.5);
y=dx*(-N/2-0.5:N/2+0.5);
z=dz*(0.5:N+1.5);

[X,Y] = meshgrid(x,y); 
meshxy = [X(:) Y(:)]; 

fac1=sqrt(X.^2+Y.^2);
fac13=fac1.^3;
fac15=fac1.^5;

ux_stresslet=((3*X.^2)./fac15-1./fac13).*X;
uy_stresslet=((3*X.^2)./fac15-1./fac13).*Y;
umag_stresslet=sqrt(ux_stresslet.^2+uy_stresslet.^2);

figure('position',[200 200 1000 500]);  % laptop

t1 = tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact');

nexttile;

hold on;
box on;

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
axis([-2 2 -2 2]);
xticks([-2 -1 0 1 2]);
xticklabels({'-2','-1','0','1','2'});
yticks([-2 -1 0 1 2]);
yticklabels({'-2','-1','0','1','2'});
xlabel('$x$','interpreter','latex','FontSize',21);
ylabel('$y$','interpreter','latex','FontSize',21);

% even_stream_line(X,Y,ux_stresslet,uy_stresslet, 2, 6, 'Color', 'k', 'LineWidth', 1);
even_stream_arrow(X,Y,ux_stresslet,uy_stresslet, 1, 2, 'Color', 'k', 'LineWidth', 1.5,'ArrowLength', 4, ...
    'ArrowTipAngle', 45, 'ArrowBaseAngle', 10, 'ArrowDensity', 0.5);
contourf(X,Y,log(umag_stresslet),40,'LineColor','none',FaceAlpha=0.5);

plot(0,0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
text(0.01,0.95,'(a)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);
annotation('arrow',[0.2696 0.315],[0.56 0.56],'color','red','Linewidth',2);
annotation('arrow',[0.2696 0.2296],[0.56 0.56],'color','red','Linewidth',2);

hold off;

nexttile;

hold on;
box on;

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
axis([-2 2 -2 2]);
xticks([-2 -1 0 1 2]);
xticklabels({'-2','-1','0','1','2'});
yticks([-2 -1 0 1 2]);
yticklabels({'-2','-1','0','1','2'});
xlabel('$x$','interpreter','latex','FontSize',21);
ylabel('$y$','interpreter','latex','FontSize',21);

even_stream_arrow(X,Y,-ux_stresslet,-uy_stresslet, 1, 2, 'Color', 'k', 'LineWidth', 1.5,'ArrowLength', 4, ...
    'ArrowTipAngle', 45, 'ArrowBaseAngle', 10, 'ArrowDensity', 0.5);
contourf(X,Y,log(umag_stresslet),40,'LineColor','none',FaceAlpha=0.5);

plot(0,0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
text(0.01,0.95,'(b)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);
annotation('arrow',[0.695 0.745],[0.56 0.56],'color','red','Linewidth',2);
annotation('arrow',[0.81 0.76],[0.56 0.56],'color','red','Linewidth',2);

pause;
exportgraphics(t1,'Figure_6.26_stresslets.pdf','BackgroundColor','white');
hold off
close;

