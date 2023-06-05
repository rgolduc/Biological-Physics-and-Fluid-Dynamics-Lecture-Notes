% Figure_418_stretchcoil.m
% script to plot instability modes for stretch-coil problem

clear all;
close all;

global sig

omega=0;

t=figure; 

hold on
box on;

xlim([-pi/2 pi/2]);
ylim([-1.0 1.0]);

chi_mesh=linspace(-pi/2,pi/2,100);                               

chi_int=linspace(-pi/2,pi/2,1000);    % mesh for interpolation of solutions 

sig=-0.3932; 
solinit=bvpinit(chi_mesh,@guess1,omega);
sol = bvp4c(@bvpfcn,@bcfcn1,solinit);   
sol_int=deval(sol,chi_int);
F=sol_int(1,:);
L2norm=trapz(chi_int,F.^2);
F1norm=F/sqrt(L2norm);
sol.parameters

sig=-1.9876; 
solinit=bvpinit(chi_mesh,@guess2,omega);
sol = bvp4c(@bvpfcn,@bcfcn2,solinit);   
sol_int=deval(sol,chi_int);
F=sol_int(1,:);
L2norm=trapz(chi_int,F.^2);
F2norm=F/sqrt(L2norm);
sol.parameters

sig=-4.955; 
solinit=bvpinit(chi_mesh,@guess3,omega);
sol = bvp4c(@bvpfcn,@bcfcn3,solinit);   
sol_int=deval(sol,chi_int);
F=sol_int(1,:);
L2norm=trapz(chi_int,F.^2);
F3norm=F/sqrt(L2norm);
sol.parameters

plot([-pi/2 pi/2],[0 0],'--k','LineWidth',1.5);
plot(chi_int,F1norm,'-k',chi_int,F2norm,'-b',chi_int,F3norm,'-r','LineWidth',2);

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([-pi/2 -pi/4 0 pi/4 pi/2]);
xticklabels({'$-\pi/2$','','0','','$\pi/2$'});
yticks([-1 -0.5 0 0.5 1 ]);
yticklabels({'-1','','0','','1'});
xlabel('$\chi$','interpreter','latex','FontSize',17);
ylabel('$F(\chi)$','interpreter','latex','FontSize',17);
text(-0.16,-0.77,'$n\!=\!1$','FontSize',15,'Color',[0 0 0],'Interpreter','latex');
text(-0.74,0.71,'$2$','FontSize',15,'Color',[0 0 1],'Interpreter','latex');
text(-0.04,0.73,'$3$','FontSize',15,'Color',[1 0 0],'Interpreter','latex');

pause;
exportgraphics(t,'Figure_stretchcoilmodes.png','BackgroundColor','white');
exportgraphics(t,'Figure_stretchcoilmodes.pdf','BackgroundColor','white');
hold off
close;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dydz= bvpfcn(xx,y,om)  
global sig 
fac=(pi^2)/4;
dydz = [y(2)
        y(3)
        y(4)
        sig*((fac-xx^2)*y(3)-4*xx*y(2)+4*(om-1)*y(1))];
end

function res = bcfcn1(ya,yb,om) 
global sig
res = [ya(1)-1
       ya(3)
       ya(4)
       yb(3)
       yb(4)];
end

function res = bcfcn2(ya,yb,om) 
global sig
res = [ya(2)-1
       ya(3)
       ya(4)
       yb(3)
       yb(4)];
end

function res = bcfcn3(ya,yb,om) 
global sig
res = [ya(2)+1
       ya(3)
       ya(4)
       yb(3)
       yb(4)];
end

function g = guess1(xx) 
  g = [1-2*cos(xx) 
      2*sin(xx) 
      2*cos(xx) 
      -2*sin(xx)];  
end

function g = guess2(xx) 
  g = [sin(2*xx) 
      2*cos(2*xx) 
      -4*sin(2*xx) 
      -8*cos(2*xx)]; 
end

function g = guess3(xx) 
  g = [cos(3*xx) 
      -3*sin(3*xx) 
      -9*cos(3*xx) 
      27*sin(xx)]; 
end


