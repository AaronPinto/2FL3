clc;
clear;
% variation 7, p1 = 0.3, p2 = 0.4
rho_s = 2e-6;
epsilon0 = 8.854e-12;
numRSteps = 2000;
numphiSteps = 2000;
r_lower = 0.3;
r_upper = 0.4;
phi_lower = 0;
phi_upper = 2 * pi;
dr = (r_upper - r_lower) / numRSteps;
dphi = (phi_upper - phi_lower) / numphiSteps;

P = [0, 0, 1];
E = [0, 0, 0];
r = r_lower + dr / 2;
phi = phi_lower + dphi / 2;

for i = 1: numphiSteps
    for j = 1: numRSteps
        Rs = [r * cos(phi), r * sin(phi), 0];
        R = P - Rs;
        RMag = norm(R);
        E = E + ((rho_s * r * dr * dphi) / (4 * pi * epsilon0 * RMag ^ 3)) * R;
        r = r + dr;
    end
    phi = phi + dphi;
    r = r_lower;
end
E