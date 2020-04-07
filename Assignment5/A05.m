c  = 299792458; %speed of light c in free space, m/s
Z_0 = 75; %ohm
l = 0.2054; %m
a = 0; %loss-free TL, attn. const = 0

R_s = Z_0; %ohm
L_s = 1e-9; %H
C_s = 1.8e-12; %F

f_lower = 1e9;
f_upper = 5e9;
f_step = 5e6;
f_range = f_lower:f_step:f_upper;
num = (f_upper - f_lower) / f_step;

Z_L = zeros(num, 1);
Z_in = zeros(num, 1);
reflect = zeros(num, 1);
swr = zeros(num, 1);

x = 1;
for f = f_range
    w = 2 * pi * f;
    B = w / c;
    
    % Use 1i instead of j, because i and j are most commonly used as counters
    Z_L(x) = R_s + 1i * w * L_s + 1 / (1i * w * C_s);
    Z_in(x) = Z_0 * ((Z_L(x) + 1i * Z_0 * tan(B * l)) / (Z_0 + 1i * Z_L(x) * tan(B * l)));
    reflect(x) = (Z_L(x) - Z_0) / (Z_L(x) + Z_0);
    swr(x) = (1 + abs(reflect(x))) / (1 - abs(reflect(x)));
    
    x = x + 1;
end

figure('units','normalized','outerposition',[0 0 1 1], 'Name', 'Responses versus frequency')

% plot using auto-generated axes 
subplot(3,1,1);
plot(f_range,real(Z_in));
title("Input resistance vs frequency");
xlabel("frequency (Hz)");
ylabel("resistance (ohm)");

subplot(3,1,2);
plot(f_range,imag(Z_in));
title("Input reactance vs frequency");
xlabel("frequency (Hz)");
ylabel("reactance (ohm)");

subplot(3,1,3);
plot(f_range,swr);
title("SWR vs frequency");
xlabel("frequency (Hz)");
ylabel("swr");
