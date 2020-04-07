clc;
clear;
close all;
% variation 7, r1 = 0.03, r2 = 0.06
eps = 8.854e-12;

r1 = 0.03;
r2 = 0.06;
rho_s = 4e-9;

PlotXmin = -0.065;
PlotXmax = 0.065;
PlotYmin = -0.065;
PlotYmax = 0.065;

NumOfXPlotPoints = 40;
NumOfYPlotPoints = 40;

PlotStepX = (PlotXmax - PlotXmin) / (NumOfXPlotPoints-1);
PlotStepY = (PlotYmax - PlotYmin) / (NumOfYPlotPoints-1);

NumOfXPlotPoints2 = 500;
NumOfYPlotPoints2 = 500;

[X,Y] = meshgrid(PlotXmin:PlotStepX:PlotXmax,PlotYmin:PlotStepY:PlotYmax);

Fx = zeros(NumOfYPlotPoints,NumOfXPlotPoints);
Fy = zeros(NumOfYPlotPoints,NumOfXPlotPoints);
Fz = zeros(NumOfYPlotPoints,NumOfXPlotPoints);

PlotStepX2 = (PlotXmax - PlotXmin) / (NumOfXPlotPoints2-1);
PlotStepY2 = (PlotYmax - PlotYmin) / (NumOfYPlotPoints2-1);

[X2,Y2] = meshgrid(PlotXmin:PlotStepX2:PlotXmax,PlotYmin:PlotStepY2:PlotYmax);

V = zeros(NumOfXPlotPoints2,NumOfYPlotPoints2);

C = [0 0];
F = [0 0];

for j=1:NumOfYPlotPoints
    for i=1:NumOfXPlotPoints
        Xplot = X(j,i);
        Yplot = Y(j,i);
        
        p = [Xplot Yplot];
        R = p-C;
        Rmag = norm(R);
        
        if Rmag < r2 && Rmag > r1
            R_Hat = R/Rmag;
            E = R_Hat * (rho_s * r1 ^ 2) / (eps * Rmag ^ 2);
            Fx(j,i) = E(1,1);
            Fy(j,i) = E(1,2);
        end
    end
end

for j=1:NumOfYPlotPoints2
    for i=1:NumOfXPlotPoints2
        Xplot2 = X2(j,i);
        Yplot2 = Y2(j,i);
        
        p = [Xplot2 Yplot2];
        R = p-C;
        Rmag = norm(R);
        
        if Rmag > r1 && Rmag < r2
            V(j,i) = (rho_s * r1 ^ 2) / eps * (1.0 / Rmag - 1.0 / r2);
        elseif Rmag <= r1
            V(j,i) = (rho_s * r1 ^ 2) / eps * (1.0 / r1 - 1.0 / r2);
        end
    end
end

figure('Position', [400 200 640 550]);

quiver(X,Y,Fx,Fy);

hold on;

[C,h] = contour(X2,Y2,V);
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
xlabel('x(m)');
ylabel('y(m)');