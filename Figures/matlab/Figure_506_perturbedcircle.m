% Figure_506_perturbedcircle.m
% script to plot shapes of a circle perturbed with mode 1 function

close all;
clear all;

theta=linspace(0,2*pi,200);

Rzero=1;
epsilon=0.8;


xcircle=Rzero*cos(theta);
ycircle=Rzero*sin(theta);

t=figure('position',[900 250 1000 900]);

hold on;
plot(xcircle,ycircle,'-b','LineWidth',3);
for epsilon=0.1:0.1:0.8
    rhozero=Rzero*sqrt(1-epsilon^2/(2*Rzero^2));
    xcircle1=(rhozero+epsilon*cos(theta)).*cos(theta);
    ycircle1=(rhozero+epsilon*cos(theta)).*sin(theta);
    plot(xcircle1,ycircle1,'-','LineWidth',3);
end
axis equal;
box off;
%axis([-1.7 1.7 -1.7 1.7]);
hold on;
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});

pause;
% exportgraphics(t,'Figure_perturbedcircle.png','BackgroundColor','none');
exportgraphics(t,['Figure_506_perturbedcircle.pdf'],'BackgroundColor','white');
hold off;
close;



