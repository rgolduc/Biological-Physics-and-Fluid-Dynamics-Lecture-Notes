% Figure_724_labyrinth.m
% script to compute labyrinthine pattern formation in FHN model
% modified version of github code

clear all;
close all;

Nx=512;
Ny=512;
Tfinal=15000; % 7000
dt=2;
Moutput=20;
Nfinal=Tfinal/dt;
Noutput=Nfinal/Moutput;

bc_flag=0; % 0 uses fft, 1 uses dct

global Lx Ly
Lx=40;  
Ly=40;
D=0.01;
r=0.52;
rho=0.15;

x=(2*Lx/Nx)*(-Nx/2:Nx/2-1); 
xx=-Nx/2:Nx/2-1;
y=(2*Ly/Ny)*(-Ny/2:Ny/2-1);
yy=-Ny/2:Ny/2-1;
[ex,wy]=meshgrid(x,y);
[indexx,indexy]=meshgrid(xx,yy);
radius=sqrt(ex.^2+wy.^2);
index_radius=sqrt(indexx.^2+indexy.^2);

radgrid_spacing=16;
radgrid=0:radgrid_spacing:Nx/2;

Ngrid=Nx/radgrid_spacing+1;
max_index=Nx/(2*radgrid_spacing)+1;
rows=Ny;
columns=Nx;

radii=radgrid_spacing*(1:Ngrid);
centersx=(Nx/2+1+0*radii)';
centersy=(Nx/2+1+0*radii)';
centers=horzcat(centersx,centersy);

dx=x(2)-x(1);
CFL=D*dt/(dx^2)

[u,v]=initial(x,y);
if (bc_flag==0)
    uhat=fft2(u);
    vhat=fft2(v);
elseif (bc_flag==1)
    uhat=dct2(u);
    vhat=dct2(v);
end
ukeep=zeros(Ny,Nx,1+Nfinal/Noutput); 
ukeep(:,:,1)=u;
vkeep=zeros(Ny,Nx,1+Nfinal/Noutput); 
vkeep(:,:,1)=v;
tkeep=dt*[0:Noutput:Nfinal];

averageRadialProfile=zeros(1+Nfinal/Noutput,max_index);

kx=(pi/Lx)*[0:Nx/2 -Nx/2+1:-1]'; 
ky=(pi/Ly)*[0:Ny/2 -Ny/2+1:-1]'; 
[kxx,kyy]=meshgrid(kx,ky);
ksq=kxx.^2+kyy.^2;
%-----------------Runge-Kutta----------------------------------
Eu=exp(dt*(-D*ksq+rho*ksq./(1+ksq)-r)/2); 
Eu2=Eu.^2;

progressbar
for n=1:Nfinal
    progressbar(n/Nfinal);
    dui=rhside(u,r); 
    if (bc_flag==0)
        k1u=dt*fft2(dui); 
        u2=real(ifft2(Eu.*(uhat+k1u/2))); 
        dui=rhside(u2,r); 
        k2u=dt*fft2(dui); 
        u3=real(ifft2(Eu.*uhat+k2u/2)); 
        dui=rhside(u3,r); 
        k3u=dt*fft2(dui); 
        u4=real(ifft2(Eu2.*uhat+Eu.*k3u)); 
        dui=rhside(u4,r); 
        k4u=dt*fft2(dui); 
        uhat=Eu2.*uhat+(Eu2.*k1u+2*Eu.*(k2u+k3u)+k4u)/6;
    elseif (bc_flag==1)
        k1u=dt*dct2(dui); 
        u2=real(idct2(Eu.*(uhat+k1u/2))); 
        dui=rhside(u2,r); 
        k2u=dt*dct2(dui); 
        u3=real(idct2(Eu.*uhat+k2u/2)); 
        dui=rhside(u3,r); 
        k3u=dt*dct2(dui); 
        u4=real(idct2(Eu2.*uhat+Eu.*k3u)); 
        dui=rhside(u4,r); 
        k4u=dt*dct2(dui); 
        uhat=Eu2.*uhat+(Eu2.*k1u+2*Eu.*(k2u+k3u)+k4u)/6;
    end


    vhat=uhat./(1+ksq);

    if (bc_flag==0)
        u=real(ifft2(uhat)); 
        v=real(ifft2(vhat));
    elseif (bc_flag==1)
        u=real(idct2(uhat)); 
        v=real(idct2(vhat));
    end

    if mod(n,Noutput)==0
        ukeep(:,:,1+n/Noutput)=u;
        vkeep(:,:,1+n/Noutput)=v;
        uposter=u;
        uposter(uposter>0.5)=255;
        uposter(uposter<0.5)=0;
        ugray(:,:,1+n/Noutput)=uposter;
 
        profileSums = zeros(1, max_index);
        profileCounts = zeros(1, max_index);
        Ibin=imbinarize(uposter);
        % Scan the original image getting gray level, and scan edtImage getting distance.
        % Then add those values to the profile.
        for column = 1 : columns
	        for row = 1 : rows
		        thisDistance = index_radius(row,column);
		        index=1+floor(thisDistance/radgrid_spacing);
                if (index<=max_index)
                    profileSums(index) = profileSums(index) + Ibin(row, column);
                    profileCounts(index) = profileCounts(index) + 1;
                end
	        end
        end
        % Divide the sums by the counts at each distance to get the average profile
        averageRadialProfile(1+n/Noutput,:) = profileSums./profileCounts;
        front_index=find(averageRadialProfile(1+n/Noutput,:)<0.25,1);
        front_position(1+n/Noutput)=radgrid_spacing*dx*front_index;
    end
    
end

% uslice(:,:)=ukeep(:,N/2+1,:);
% 
% plot(x,uslice);
% pause;
% close;
% 
% for count=1:length(tkeep)
%     surf(x,y,squeeze(ukeep(:,:,count))'); view(-30,70); shading('interp')
%     xlabel('x');ylabel('y');zlabel('u')
%     axis([-L L -L L -1 1]);
%     Fmovie(count)=getframe;
% end
% movie(Fmovie);
% 
% pause;
% close;

colormap(gray);
for count=1:length(tkeep)
    imshow(ugray(:,:,count));
    axis image;
    Umovie(count)=getframe;
end
movie(Umovie);

% save('labyrinthe2D_RK4.mat','tkeep','ukeep','vkeep','Moutput','Nx','Ny','Lx','Ly','x','y','Nfinal','Noutput');

pause;
close;

t=figure;

I=ugray(:,:,Moutput);
Ibin=imbinarize(I);
imshow(Ibin);
hold on;
Iskel=bwskel(Ibin);
axis image;

% viscircles(centers,radii);

exportgraphics(t,'pattern.png');
pause;
hold off;
close;

t0=figure;
ax=gca;
box on;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.3;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
axis([0 60 0 0.8]);
xticks([0 20 40 60]);
xticklabels({'0','20','40','60'});
yticks([0 0.2 0.4 0.6 0.8]);
yticklabels({'0','0.2','0.4','0.6','0.8'});
xlabel('$r$)','interpreter','latex'); 
ylabel('$\langle u\rangle$','interpreter','latex');

hold on;

for i=1:max_index
    plot(radgrid_spacing*dx*(1:length(averageRadialProfile)), averageRadialProfile, '-', 'LineWidth',2);
end

pause;
exportgraphics(t0,'fronts.png');
hold off;
close;

t2=figure;
ax=gca;
box on;
set(gca, 'FontName', 'Times New Roman');

ax.LineWidth=1.3; 
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;

plot(sqrt(D)*tkeep, front_position,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',8);
axis([0 sqrt(D)*Tfinal 0 120]);

xticks([0 500 1000]);
xticklabels({'0','500','1000'});
yticks([0 50 100 150]);
yticklabels({'0','50','100','150'});
xlabel('$\sqrt{D}t$','interpreter','latex'); 
ylabel('$r_{front}$','interpreter','latex');

pause;
exportgraphics(t2,'front_position.png');
close;

Iover=labeloverlay(I,Iskel,'Transparency',0,'Colormap','autumn');
Ibranchpoints=bwmorph(Iskel,'branchpoints');
Iendpoints=bwmorph(Iskel,'endpoints');
[bx,by]=find(Ibranchpoints==1);
[ex,ey]=find(Iendpoints==1);

t1=figure;
imshow(Iover);
axis image;
hold on;
plot(by,bx,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 1],'MarkerSize',6);
plot(ey,ex,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 1 0],'MarkerSize',6);

pause;

exportgraphics(t1,'skeleton.png');
hold off;
close;

t3=figure;
imshow(~Iskel);
axis image;
hold on;
plot(by,bx,'o','MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'MarkerSize',6);
plot(ey,ex,'o','MarkerEdgeColor','k','MarkerFaceColor',[0 1 0],'MarkerSize',6);

pause;

exportgraphics(t3,'skeleton_only.png');
hold off;
close;




% branches = y & ~mn; % set branch points to zero
% branchesLabeled = bwlabel( branches, 4 ); % label connected components
% sts = regionprops( branchesLabeled, 'Area', 'Perimeter' ); % extract properties

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------Initial Condition ---------------------------------
function [u,v]=initial(x,y)
[xx,yy]=meshgrid(x,y);
global Lx Ly
xcenter=0;
ycenter=0;
r2=(xx-xcenter).^2+(yy-ycenter).^2;
theta=atan2(yy-ycenter,xx-xcenter);
amps=2*rand(1,5)-1;
nn=1:5;
r0=3+0.2*(amps(2)*cos(2*theta)+amps(3)*cos(3*theta)+amps(4)*cos(4*theta)+amps(5)*cos(5*theta));
common_exp=exp(-r2./(r0.^2));
u = common_exp;
v = common_exp;
end

%---------------Right Hand Side-----------------------------------
function rhs=rhside(u,r)
rhs=-(u.^2).*(u-1-r); 
end