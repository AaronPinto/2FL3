% speed of light c in free space, m/s
c  = 299792458;
% relative permittivity of the medium epsilon_r
epsilon_r = 2.28;
% phase velocity vp
vp = c/(sqrt(epsilon_r));

% Harmonic wave parameters
freq = 1e8;
w = 2 * pi * freq;
lambda = vp / freq;
beta = w / vp;
A_wave = 5;
z_step_wave = 1e-3 * lambda;
z_start_wave = -3 * lambda;
z_end_wave = 3 * lambda;
z_window_wave = z_start_wave:z_step_wave:z_end_wave;
max_amp = A_wave;
t_step_wave = 8e-2 * (1 / freq);
t_window_wave = -3 / freq:t_step_wave:3 / freq;

% Gaussian Pulse parameters
alpha = 5e8;
A_pulse = 5;
t_0 = 1;
z_step_pulse = (vp*1e-1)/sqrt(2*alpha);
z_start_pulse = -(3*vp)/sqrt(2*alpha);
z_end_pulse = (3*vp)/sqrt(2*alpha);
z_window_pulse = z_start_pulse:z_step_pulse:z_end_pulse;
max_amplitude = A_pulse;
t_step_pulse = 1e-1*(1/sqrt(2*alpha));
t_window_pulse = t_0- 6/sqrt(2*alpha):t_step_pulse:t_0+6/sqrt(2*alpha);

for T = t_window_pulse
    figure(1);
    
    amplitude1 = gaussian_pulse(A_pulse,alpha,t_0,z_window_pulse,T,vp);
    amplitude2 = gaussian_pulse(A_pulse,alpha,t_0,z_window_pulse,T,-vp);
    
    %plot using axes set to fixed ranges
    subplot(3,1,1)
    plot(z_window_pulse,amplitude1)
    axis([z_start_pulse,z_end_pulse,0,max_amplitude])
    title("Gaussian pulse travelling in +z direction");
    xlabel("z(m)");
    ylabel("Amplitude")
    
    subplot(3,1,2)
    plot(z_window_pulse,amplitude2)
    axis([z_start_pulse,z_end_pulse,0,max_amplitude])
    title("Gaussian pulse travelling in -z direction");
    xlabel("z(m)");
    ylabel("Amplitude")
    
    subplot(3,1,3)
    plot(z_window_pulse,amplitude1 + amplitude2)
    axis([z_start_pulse,z_end_pulse,0,2*max_amplitude]) % Double y-axis range
    title("Superposition of Gaussian pulses");
    xlabel("z(m)");
    ylabel("Amplitude")
    
    pause(1e-3);
end

for T = t_window_wave
    figure(2);
    
    amplitude1 = harmonic_wave(A_wave,w,z_window_wave,T,beta);
    amplitude2 = harmonic_wave(A_wave,w,z_window_wave,-T,beta);
    
    %plot using axes set to fixed ranges
    subplot(3,1,1)
    plot(z_window_wave,amplitude1)
    axis([z_start_wave,z_end_wave,-max_amp,max_amp])
    title("Harmonic wave travelling in +z direction");
    xlabel("z(m)");
    ylabel("Amplitude")
    
    subplot(3,1,2)
    plot(z_window_wave,amplitude2)
    axis([z_start_wave,z_end_wave,-max_amp,max_amp])
    title("Harmonic wave travelling in -z direction");
    xlabel("z(m)");
    ylabel("Amplitude")
    
    subplot(3,1,3)
    plot(z_window_wave,amplitude1 + amplitude2)
    axis([z_start_wave,z_end_wave,-2*max_amp,2*max_amp]) % Double y-axis range
    title("Superposition of Harmonic waves");
    xlabel("z(m)");
    ylabel("Amplitude")
    
    pause(1e-3);
end

function amplitude = gaussian_pulse(A,alpha,t_0,z,t,vp)
    argument = -alpha*(t-(z/vp)-t_0).^2;
    amplitude = A*exp(argument);
end

function amplitude = harmonic_wave(A,omega,z,t,B)
    argument = omega * t - B * z;
    amplitude = A*sin(argument);
end