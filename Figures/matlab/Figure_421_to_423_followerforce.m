% Figure_421_to_423_followerforce.m
% script to plot various quantities related to the follower-force problem

clear all;
close all;

M=90;  % number of values of sigma for calculation of growth rate
sigmax=45;
N=400; % number of grid points in x mesh

sigma=zeros(1,M);
modes=zeros(M,N+1);
x=linspace(0,1,N+1);
dx=x(2)-x(1);
k=1:N+1;

red=zeros(1,M);
blue=zeros(1,M);
green=zeros(1,M);

linear=1:M;

red=1.0-1.0*linear/M;
green=0.0*linear/M;
blue=linear/M; 

newcolors(:,1)=red;
newcolors(:,2)=green;
newcolors(:,3)=blue;

fun=@f;

for p=1:20   % find first 20 roots of transcendental equations
    wroot(p)=fzero(fun,pi*(2*p-1)/2)/(0.5*pi);
end

dx1=2*dx;
dx2=dx^2;
dx4=dx^4;

A=zeros(N+1,N+1); 


for mm=1:M
    sigarray(mm)=sigmax*(mm-1)/(M-1);
    sigma=sigarray(mm);

    A(1,1) = -3/dx4;
    A(1,2) = 14/dx4-2*sigma/dx2;
    A(1,3) = -26/dx4;
    A(1,4) = 24/dx4;
    A(1,5) = -11/dx4;
    A(1,6) = 2/dx4;

    A(2,2) = -7/dx4+2*sigma/dx2;
    A(2,3) = 4/dx4-sigma/dx2;
    A(2,4) = -1/dx4;

    A(3,2) = 4/dx4-sigma/dx2;
    A(3,3) = -6/dx4+2*sigma/dx2;
    A(3,4) = 4/dx4-sigma/dx2;
    A(3,5) = -1/dx4;

    for j=4:N-1
      A(j,j-2) = -1/dx4;
      A(j,j-1) = 4/dx4-sigma/dx2;
      A(j,j) = -6/dx4+2*sigma/dx2;
      A(j,j+1) = 4/dx4-sigma/dx2;
      A(j,j+2) = -1/dx4;
    end

    A(N,N-2)= -1/dx4;
    A(N,N-1)= 4/dx4-sigma/dx2;
    A(N,N)= -5/dx4+2*sigma/dx2;
    A(N,N+1) = 2/dx4-sigma/dx2;

    A(N+1,N-1) = -2/dx4;
    A(N+1,N) = 4/dx4;
    A(N+1,N+1) = -2/dx4;

    [V,D]=eig(A);
    Ddiag=diag(D);
    [eigens,ind]=sort(real(diag(D)),'descend');
    Ds=D(ind,ind);
    eigen_real(mm)=real(Ds(1));
    eigen_imag(mm)=imag(Ds(1));
    
    unstablemode=V(:,ind(1));
    L2norm=trapz(dx,unstablemode.^2);
    modes(mm,:)=unstablemode(:)/sqrt(L2norm);
end

% interpolate near zero crossing of eigenvalue to estimate critical sigma
% for Hopf bifurcation
mm_crit=find(eigen_real>0,1);
slope=eigen_real(mm_crit)-eigen_real(mm_crit-1);
intercept=eigen_real(mm_crit-1)-slope*(mm_crit-1);
sigma_crit=sigmax*(-intercept/slope-1)/(M-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=figure('position',[300 200 800 500]);

hold on;
box on;
plot(sigarray,eigen_real,'-b','LineWidth',1.8);
plot(sigarray,eigen_imag,'-','Color',[0.4660 0.6740 0.1880],'LineWidth',1.8);
plot(sigma_crit,0,'or','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',[1,0,0])
ax=gca;
set(gca, 'FontName', 'Palatino Linotype');
set(gca,'PlotBoxAspectRatio',[1 0.5 1]);
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 50 -150 200]);
plot([0 50],[0 0],'--k','LineWidth',1.0);
xticks([0 10 20 30 40 50]);
xticklabels({'0','10','20','30','40','50'});
yticks([-150 -100 -50 0 50 100 150 200]);
yticklabels({'','-100','','0','','100','','200'});
xlabel('$\sigma$','Interpreter','latex','Fontsize',17);
ylabel('$\omega$','Interpreter','latex','Fontsize',17);

text(30,-75,'Re($\omega$)','FontSize',17,'Interpreter','latex','Color',[0 0 1]);
text(30,126,'Im($\omega$)','FontSize',17,'Interpreter','latex','Color',[0.4660 0.6740 0.1880]);

pause;
exportgraphics(t,'Figure_followerforceomega.png','BackgroundColor','none');
exportgraphics(t,'Figure_followerforceomega.pdf','BackgroundColor','none');
hold off;
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=figure('position',[300 200 800 500]);

hold on;
box on;

for j=1:3:M
    modesign=sign(modes(j,N));
    plot(x(:),real(modes(j,:)*modesign),'-b','LineWidth',1.5,'Color',[newcolors(j,1) newcolors(j,2) newcolors(j,3)]);
    % plot(ex(:),modes(j,:),'-b','LineWidth',1.5);
end
ax=gca;
set(gca, 'FontName', 'Times New Roman');
set(gca,'PlotBoxAspectRatio',[1 0.5 1]);
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 1 -0.5 3]);
hold on;
plot([0 1],[0 0],'--k','LineWidth',1.0);
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([-1 0 1 2 3]);
yticklabels({'-1','0','1','2','3'});
xlabel('$\chi$','Interpreter','latex','Fontsize',15);
ylabel('$G(\chi)$','Interpreter','latex','Fontsize',17);

pause;
exportgraphics(t1,'Figure_followerforcemodes.png','BackgroundColor','none');
exportgraphics(t1,'Figure_followerforcemodes.pdf','BackgroundColor','none');
hold off;
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t2=figure('position',[300 200 800 500]);

hold on;
box on;

omegatau=0;
func1=cos(omegatau)*real(modes(M,:))-sin(omegatau)*imag(modes(M,:));

omegatau=pi/4;
func2=cos(omegatau)*real(modes(M,:))-sin(omegatau)*imag(modes(M,:));

omegatau=pi/2;
func3=cos(omegatau)*real(modes(M,:))-sin(omegatau)*imag(modes(M,:));

omegatau=3*pi/4;
func4=cos(omegatau)*real(modes(M,:))-sin(omegatau)*imag(modes(M,:));

omegatau=pi;
func5=cos(omegatau)*real(modes(M,:))-sin(omegatau)*imag(modes(M,:));

omegatau=5*pi/4;
func6=cos(omegatau)*real(modes(M,:))-sin(omegatau)*imag(modes(M,:));

omegatau=3*pi/2;
func7=cos(omegatau)*real(modes(M,:))-sin(omegatau)*imag(modes(M,:));

omegatau=7*pi/4;
func8=cos(omegatau)*real(modes(M,:))-sin(omegatau)*imag(modes(M,:));

plot(x,func1,x,func2,x,func3,x,func4,x,func5,x,func6,x,func7,x,func8,'Linewidth',2);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
set(gca,'PlotBoxAspectRatio',[1 0.5 1]);
ax.LineWidth=1.4;
ax.XAxis.FontSize = 17;
ax.YAxis.FontSize = 17;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 1 -2.1 2.1]);
hold on;
plot([0 1],[0 0],'--k','LineWidth',1.0);
xticks([0 0.5 1]);
xticklabels({'0','0.5','1'});
yticks([-2 -1 0 1 2]);
yticklabels({'-2','-1','0','1','2'});
xlabel('$\chi$','Interpreter','latex','Fontsize',15);
ylabel('$H(\chi)$','Interpreter','latex','Fontsize',17);

pause;
exportgraphics(t2,'Figure_followerforcewave.png','BackgroundColor','none');
exportgraphics(t2,'Figure_followerforcewave.pdf','BackgroundColor','none');
hold off;
close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function w = f(x)
w = cos(x)*cosh(x)+1;
end