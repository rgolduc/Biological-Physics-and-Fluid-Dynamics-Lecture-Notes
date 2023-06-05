% Figure_622_stokeslet.m
% graphs streamlines and heat map of speed for a stokeslet

clear all;
close all;

N=201;     % linear dimension of grid
dx=0.02;    % spacing between grid points in x
dz=dx;     % spacing between grid points in y
L=dx*N;    % physical size of array (linear dimension)

x=dx*(-N/2-0.5:N/2+0.5);
z=dz*(-N/2-0.5:N/2+0.5);

[X,Z] = meshgrid(x,z); 
mesh = [X(:) Z(:)]; 

fac1=sqrt(X.^2+Z.^2);
fac13=fac1.^3;

ux_free=X.*Z./fac13;
uz_free=1./fac1+(Z.^2)./fac13;
umag_free=sqrt(ux_free.^2+uz_free.^2);

% figure('position',[500 500 1300 500]); % office computer
t=figure('position',[200 200 400 400]);  % laptop

hold on
box on;

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 19;
ax.YAxis.FontSize = 19;
ax.TickLabelInterpreter = 'latex';
axis([-1 1 -1 1]);
xticks([-1 0 1]);
xticklabels({'-1','0','1'});
yticks([-1 0 1]);
yticklabels({'-1','0','1'});
xlabel('$x$','interpreter','latex','FontSize',21);
ylabel('$z$','interpreter','latex','FontSize',21);

even_stream_line(X,Z,ux_free,uz_free,2,6, 'Color', 'k', 'LineWidth', 1);
contourf(X,Z,log(umag_free),40,'LineColor','none',FaceAlpha=0.5);

plot(0,0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
annotation('arrow',[0.534 0.534],[0.55 0.65],'color','red','Linewidth',2);

pause;
exportgraphics(t,'Figure_6.22_stokeslet.pdf','BackgroundColor','white');
hold off
close;









