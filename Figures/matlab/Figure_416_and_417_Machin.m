% Figure_416_and_417.m
% script to plot aspects of Machin problem for finite filaments

clear all;
close all;

t=figure; 

hold on
box on;

xlim([0 7]);
ylim([-1.3 10.3]);

L=1;

chi_mesh=linspace(0,L,100);                               

chi_int=linspace(0,L,1000);    % mesh for interpolation of solutions 

solinit=bvpinit(chi_mesh,@guess);
sol = bvp4c(@bvpfcn,@bcfcn,solinit);   
sol_int=deval(sol,chi_int);
F=sol_int(1,:);
   
tau=0;
func1=real(F*exp(1i*tau));

tau=pi/4;
func2=real(F*exp(1i*tau));

tau=pi/2;
func3=real(F*exp(1i*tau));

tau=3*pi/4;
func4=real(F*exp(1i*tau));

tau=pi;
func5=real(F*exp(1i*tau));

tau=5*pi/4;
func6=real(F*exp(1i*tau));

tau=3*pi/2;
func7=real(F*exp(1i*tau));

tau=7*pi/4;
func8=real(F*exp(1i*tau));

plot(chi_int,func1,chi_int,func2,chi_int,func3,chi_int,func4,chi_int,func5,chi_int,func6,chi_int,func7,chi_int,func8,'Linewidth',2);

L=2;

chi_mesh=linspace(0,L,100);                               

chi_int=linspace(0,L,1000);    % mesh for interpolation of solutions 

solinit=bvpinit(chi_mesh,@guess);
sol = bvp4c(@bvpfcn,@bcfcn,solinit);   
sol_int=deval(sol,chi_int);
F=sol_int(1,:);
   
tau=0;
func1a=3+real(F*exp(1i*tau));

tau=pi/4;
func2a=3+real(F*exp(1i*tau));

tau=pi/2;
func3a=3+real(F*exp(1i*tau));

tau=3*pi/4;
func4a=3+real(F*exp(1i*tau));

tau=pi;
func5a=3+real(F*exp(1i*tau));

tau=5*pi/4;
func6a=3+real(F*exp(1i*tau));

tau=3*pi/2;
func7a=3+real(F*exp(1i*tau));

tau=7*pi/4;
func8a=3+real(F*exp(1i*tau));

plot(chi_int,func1a,chi_int,func2a,chi_int,func3a,chi_int,func4a,chi_int,func5a,chi_int,func6a,chi_int,func7a,chi_int,func8a,'Linewidth',2);

L=4;

chi_mesh=linspace(0,L,100);                               

chi_int=linspace(0,L,1000);    % mesh for interpolation of solutions 

solinit=bvpinit(chi_mesh,@guess);
sol = bvp4c(@bvpfcn,@bcfcn,solinit);   
sol_int=deval(sol,chi_int);
F=sol_int(1,:);
   
tau=0;
func1b=6+real(F*exp(1i*tau));

tau=pi/4;
func2b=6+real(F*exp(1i*tau));

tau=pi/2;
func3b=6+real(F*exp(1i*tau));

tau=3*pi/4;
func4b=6+real(F*exp(1i*tau));

tau=pi;
func5b=6+real(F*exp(1i*tau));

tau=5*pi/4;
func6b=6+real(F*exp(1i*tau));

tau=3*pi/2;
func7b=6+real(F*exp(1i*tau));

tau=7*pi/4;
func8b=6+real(F*exp(1i*tau));

plot(chi_int,func1b,chi_int,func2b,chi_int,func3b,chi_int,func4b,chi_int,func5b,chi_int,func6b,chi_int,func7b,chi_int,func8b,'Linewidth',2);

L=20;

chi_mesh=linspace(0,L,100);                               

chi_int=linspace(0,L,1000);    % mesh for interpolation of solutions 

solinit=bvpinit(chi_mesh,@guess);
sol = bvp4c(@bvpfcn,@bcfcn,solinit);   
sol_int=deval(sol,chi_int);
F=sol_int(1,:);
   
tau=0;
func1c=9+real(F*exp(1i*tau));

tau=pi/4;
func2c=9+real(F*exp(1i*tau));

tau=pi/2;
func3c=9+real(F*exp(1i*tau));

tau=3*pi/4;
func4c=9+real(F*exp(1i*tau));

tau=pi;
func5c=9+real(F*exp(1i*tau));

tau=5*pi/4;
func6c=9+real(F*exp(1i*tau));

tau=3*pi/2;
func7c=9+real(F*exp(1i*tau));

tau=7*pi/4;
func8c=9+real(F*exp(1i*tau));

plot(chi_int,func1c,chi_int,func2c,chi_int,func3c,chi_int,func4c,chi_int,func5c,chi_int,func6c,chi_int,func7c,chi_int,func8c,'Linewidth',2);

plot([0 7],[0 0],'--k','LineWidth',1.5);
plot([0 7],[3 3],'--k','LineWidth',1.5);
plot([0 7],[6 6],'--k','LineWidth',1.5);
ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 1 2 3 4 5 6 7]);
xticklabels({'0','1','2','3','4','5','6','7'});
yticks([-1 0 1 2 3 4 5 6 7 8 9 10]);
yticklabels({'-1','0','1','-1','0','1','-1','0','1','-1','0','1'});
xlabel('$\chi$','interpreter','latex','FontSize',17);
ylabel('$h(x)/h_0$','interpreter','latex','FontSize',17);
text(1.2,0.4,'${\cal L}\!=\!1$','FontSize',15,'Interpreter','latex');
text(2.2,3.4,'$2$','FontSize',15,'Interpreter','latex');
text(4.2,6.4,'$4$','FontSize',15,'Interpreter','latex');
text(6.2,8.4,'$\infty$','FontSize',15,'Interpreter','latex');

pause;
exportgraphics(t,'Figure_Machin.png','BackgroundColor','none');
exportgraphics(t,'Figure_Machin.pdf','BackgroundColor','none');
hold off
close;


t1=figure; 

count=0;
for L=0.1:0.1:10
    count=count+1;
    ell(count)=L;
    chi_mesh=linspace(0,L,100);                               
    
    chi_int=linspace(0,L,1000);    % mesh for interpolation of solutions 
    dchi=chi_int(2)-chi_int(1);

    solinit=bvpinit(chi_mesh,@guess);
    sol = bvp4c(@bvpfcn,@bcfcn,solinit);   
    sol_int=deval(sol,chi_int);
    F=sol_int(1,:);
    Fchi=sol_int(2,:);
    F3chi=sol_int(4,:);
    F4chi=gradient(F3chi,dchi);
    vertdiss(count)=trapz(chi_int,real(F4chi).*real(F4chi)+imag(F4chi).*imag(F4chi));
    propulsion(count)=-(real(Fchi(1))*real(F3chi(1))+imag(Fchi(1))*imag(F3chi(1)));
    efficiency(count)=5*(propulsion(count)^2)/(vertdiss(count)*ell(count));
    speed(count)=propulsion(count)/ell(count);
end

hold on
box on;

xlim([0 10]);
ylim([0 0.55]);

plot([0 10],[1 1],'--k','LineWidth',1.5);
plot(ell,propulsion,'-b','LineWidth',2);
plot(ell,efficiency,'-r','LineWidth',2);
plot(ell,5*speed,'-k','LineWidth',2);
text(7.26,0.39,'$Y$','FontSize',15,'Color',[0 0 1],'Interpreter','latex');
text(4.56,0.48,'$V$','FontSize',15,'Color',[0 0 0],'Interpreter','latex');
text(4.86,0.24,'$Z$','FontSize',15,'Color',[1 0 0],'Interpreter','latex');

ax=gca;
set(gca, 'FontName', 'Times New Roman');
ax.LineWidth=1.1;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.LabelFontSizeMultiplier = 1.15;
xticks([0 1 2 3 4 5 6 7 8 9 10]);
xticklabels({'0','','','','','5','','','','','10'});
yticks([0 0.1 0.2 0.3 0.4 0.5]);
yticklabels({'0','0.1','0.2','0.3','0.4','0.5'});
xlabel('${\mathcal L}$','interpreter','latex','FontSize',17);
ylabel('$Y({\mathcal L}),V({\mathcal L}),Z({\mathcal L})$','interpreter','latex','FontSize',17);

pause;
exportgraphics(t1,'Figure_Machin_propulsion.png','BackgroundColor','none');
exportgraphics(t1,'Figure_Machin_propulsion.pdf','BackgroundColor','none');
hold off
close;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dydz= bvpfcn(xx,y)  
dydz = [y(2)
        y(3)
        y(4)
        -1i*y(1)];
end

function res = bcfcn(ya,yb) 
res = [ya(1)-1
       ya(3)
       yb(3)
       yb(4)];
end

function g = guess(xx) 
  C8=cos(pi/8);
  S8=sin(pi/8);
  g = [exp(-xx) -exp(-xx) exp(-xx) -exp(-xx)]; 
end


