clc;
clear;
close all;

% variation 37, K = 140 (num turns), Rin = 1 cm, Rout = 2.3 cm
K = 140; % Total number of turns in toroid
I = 5; % current (A)
r_in = 1e-2; % inner radius (m)
r_out = 2.3e-2; % outer radius (m)
r_av = (r_in + r_out) / 2.0;
a = (r_out - r_in) / 2.0;
num_segments = 4000;
x_plot_points = 20;
y_plot_points = 20;
extent = r_out + 0.1 * r_out;
x_min = -extent;
x_max = extent;
y_min = -extent;
y_max = extent;
[x_data, y_data] = meshgrid(linspace(x_min, x_max, x_plot_points + 1), linspace(y_min, y_max, y_plot_points + 1));
z_plot = 0;
H_x = zeros(y_plot_points + 1, x_plot_points + 1);
H_y = zeros(y_plot_points + 1, x_plot_points + 1);

for i = 1: (x_plot_points + 1)
   for j = 1: (y_plot_points + 1)
       x_current = x_data(j, i);
       y_current = y_data(j, i);
       r_obs = [x_current, y_current, z_plot];
       
       for n = 1: num_segments - 1
           alpha_n = ((2 * pi * K) * (n - 1)) / num_segments;
           phi_n = 2 * pi * (n - 1) / num_segments;
           r_n = r_av + a * cos(alpha_n);
           x_s = r_n * cos(phi_n);
           y_s = r_n * sin(phi_n);
           z_s = -a * sin(alpha_n);
           
           alpha_n_plus = ((2 * pi * K) * n) / num_segments;
           phi_n_plus = 2 * pi * n / num_segments;
           r_n_plus = r_av + a * cos(alpha_n_plus);
           x_e = r_n_plus * cos(phi_n_plus);
           y_e = r_n_plus * sin(phi_n_plus);
           z_e = -a * sin(alpha_n_plus);
           
           delta_l = [(x_e - x_s), (y_e - y_s), (z_e - z_s)];
           r_centre = 0.5 * [(x_s + x_e), (y_s + y_e), (z_s + z_e)];
           r = r_obs - r_centre;
           mag_r = norm(r);
           unit_r = r / mag_r;
           dH = (I / (4 * pi * mag_r * mag_r) * cross(delta_l, unit_r));
           H_x(j, i) = H_x(j, i) + dH(1, 1);
           H_y(j, i) = H_y(j, i) + dH(1, 2);
       end
   end
end

figure('Position', [450 250 560 490]);
quiver(x_data, y_data, H_x, H_y);
axis([-0.04, 0.04, -0.04, 0.04]);
xlabel('x(m)');
ylabel('y(m)');
grid on;
