% Figure_634_and_635_stokesletnearsurf.m
% plots various flow fields for a stokeslet near a no-slip surface

clear all;
close all;

N=201;     % linear dimension of grid
dx=0.04;    % spacing between grid points in x
dz=dx;     % spacing between grid points in y
L=dx*N;    % physical size of array (linear dimension)
h=1;

x=dx*(-N/2-0.5:N/2+0.5);
y=dx*(-N/2-0.5:N/2+0.5);
z=dz*(0.5:N+1.5);

[X,Z] = meshgrid(x,z); 
mesh = [X(:) Z(:)]; 

fac1=sqrt(X.^2+(Z-h).^2);
fac13=fac1.^3;
fac2=sqrt(X.^2+(Z+h).^2);
fac23=fac2.^3;
fac25=fac2.^5;


ux_free=X.*(Z-h)./fac13-X.*(Z+h)./fac23;
uz_free=1./fac1-1./fac2+((Z-h).^2)./fac13-((Z+h).^2)./fac23;
umag_free=sqrt(ux_free.^2+uz_free.^2);

ux_horz_free=1./fac1+1./fac2+(X.^2)./fac13+(X.^2)./fac23;
uz_horz_free=X.*(Z-h)./fac13+X.*(Z+h)./fac23;
umag_horz_free=sqrt(ux_horz_free.^2+uz_horz_free.^2);

ux_noslip=X.*(Z-h)./fac13-X.*(Z-h)./fac23-6*h*X.*Z.*(Z+h)./fac25;
uz_noslip=1./fac1-1./fac2+((Z-h).^2)./fac13-(Z.^2+h^2)./fac23-6*h*Z.*((Z+h).^2)./fac25;
umag_noslip=sqrt(ux_noslip.^2+uz_noslip.^2);

%%%%%%%%%%%%%% three-panel figure %%%%%%%%%%%%%%%%%%%%%%

% figure('position',[500 500 1300 500]); % office computer
figure('position',[200 200 1400 450]);  % laptop

t = tiledlayout(1,3,'TileSpacing','Compact','Padding','Compact');

nexttile;

% free surface, vertical stokeslet

hold on
box on;

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
axis([-2 2 0 4]);
xticks([-2 -1 0 1 2]);
xticklabels({'-2','-1','0','1','2'});
yticks([0 1 2 3 4]);
yticklabels({'0','','2','','4'});
xlabel('$x$','interpreter','latex','FontSize',21);
ylabel('$z$','interpreter','latex','FontSize',21);
dim2 = [0.068 0.88 0.035 0.07];
%annotation('rectangle',dim2,'FaceColor','white','FaceAlpha',1)
text(0.01,0.95,'(a)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);
%annotation('textbox',dim2,'String','(a)','FitBoxToText','on');

even_stream_line(X,Z,ux_free,uz_free, 2,6, 'Color', 'k', 'LineWidth', 1);
contourf(X,Z,log(umag_free),40,'LineColor','none',FaceAlpha=0.5);

plot(0,h,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
annotation('arrow',[0.19 0.19 ],[0.362 0.462],'color','red','Linewidth',2);
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nexttile;

% free surface, horizontal stokeslet

hold on
box on;

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
axis([-2 2 0 4]);
xticks([-2 -1 0 1 2]);
xticklabels({'-2','-1','0','1','2'});
yticks([0 1 2 3 4]);
yticklabels({'0','','2','','4'});
xlabel('$x$','interpreter','latex','FontSize',21);
ylabel('$z$','interpreter','latex','FontSize',21);
dim2 = [0.068 0.88 0.035 0.07];
%annotation('rectangle',dim2,'FaceColor','white','FaceAlpha',1)
text(0.01,0.95,'(b)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);
% annotation('textbox',dim2,'String','(a)','FitBoxToText','on');

even_stream_line(X,Z,ux_horz_free,uz_horz_free, 2,6, 'Color', 'k', 'LineWidth', 1);
contourf(X,Z,log(umag_horz_free),40,'LineColor','none',FaceAlpha=0.5);

plot(0,h,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
annotation('arrow',[0.505 0.540],[0.37 0.37],'color','red','Linewidth',2);
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nexttile;

hold on
box on;

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([-2 2 0 4]);
xticks([-2 -1 0 1 2]);
xticklabels({'-2','-1','0','1','2'});
yticks([0 1 2 3 4]);
yticklabels({'0','','2','','4'});
xlabel('$x$','interpreter','latex','FontSize',21);
ylabel('$z$','interpreter','latex','FontSize',21);
text(0.01,0.95,'(c)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);

even_stream_line(X,Z,ux_noslip,uz_noslip, 2, 6, 'Color', 'k', 'LineWidth', 1);
contourf(X,Z,log(umag_noslip),40,'LineColor','none',FaceAlpha=0.5);

plot(0,h,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
annotation('arrow',[0.8195 0.8195],[0.362 0.462],'color','red','Linewidth',2);
pause;
exportgraphics(t,'Figure_6.34_stokesletsurfaceflow.pdf','BackgroundColor','white');
hold off
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X,Y] = meshgrid(x,y); 
meshxy = [X(:) Y(:)]; 

zee=h;

fac1=sqrt(X.^2+Y.^2);
fac13=fac1.^3;
fac15=fac1.^5;
fac2=sqrt(X.^2+Y.^2+4*h^2);
fac23=fac2.^3;
fac25=fac2.^5;


ux_para_noslip=1./fac1+(X.^2)./fac13-(1./fac2+(X.^2)./fac23)-2*h*zee*(1./fac23-3*(X.^2)./fac25);
uy_para_noslip=X.*Y./fac13-X.*Y./fac23+6*h*zee*X.*Y./fac25;
umag_para_noslip=sqrt(ux_para_noslip.^2+uy_para_noslip.^2);

[FX,FY]=gradient(ux_para_noslip);
[GX,GY]=gradient(uy_para_noslip);

gradmag_para_noslip=sqrt(FX.^2+GX.^2);
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

even_stream_line(X,Y,ux_para_noslip,uy_para_noslip, 2, 6, 'Color', 'k', 'LineWidth', 1);
contourf(X,Y,log(umag_para_noslip),40,'LineColor','none',FaceAlpha=0.5);

plot(0,0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
text(0.01,0.95,'(a)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);
annotation('arrow',[0.2696 0.3096],[0.5584 0.5584],'color','red','Linewidth',2);

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
ax.LabelFontSizeMultiplier = 1.15;
axis([-2 2 -2 2]);
xticks([-2 -1 0 1 2]);
xticklabels({'-2','-1','0','1','2'});
yticks([-2 -1 0 1 2]);
yticklabels({'-2','-1','0','1','2'});
xlabel('$x$','interpreter','latex','FontSize',21);
ylabel('$y$','interpreter','latex','FontSize',21);

even_stream_line(X,Y,FX,GX, 2, 6, 'Color', 'k', 'LineWidth', 1);
contourf(X,Y,log(gradmag_para_noslip),40,'LineColor','none',FaceAlpha=0.5);

plot(0,0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
text(0.01,0.95,'(b)','Units','normalized','FontSize',19,'Interpreter','latex','Color',[0 0 0]);
annotation('arrow',[0.7488 0.7888],[0.5584 0.5584],'color','red','Linewidth',2);

pause;
exportgraphics(t1,'Figure_6.35_stokesletparallelflow.pdf','BackgroundColor','white');
hold off
close;

