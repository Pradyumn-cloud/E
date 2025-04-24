clc;
clear;
close all;

% Set up the basic conditions
bmax = 1; % Normalize bmax to 1
freq = 60; % 60 Hz
P = 2; % Number of poles (set to 2 for standard operation)
w = 2 * pi * freq * P / 2; % Adjusted angular velocity (pole dependent)

% Rotor parameters
rotor_speed = w / P; % Mechanical speed of rotor magnetic field
initial_angle = pi/4; % Initial misalignment angle

t = 0:1/6000:1/60; % Time vector

% Generate the three-phase magnetic fields
Baa = sin(w*t).*(cos(0) + j*sin(0));
Bbb = sin(w*t - 2*pi/3) .* (cos (2*pi/3) + j*sin(2*pi/3)) ;
Bcc = sin(w*t + 2*pi/3) .* (cos (- 2*pi /3) + j*sin(- 2*pi /3)) ;

% Calculate Bnet
Bnet = Baa + Bbb + Bcc;

% Rotor magnetic field (one-loop rotor interaction)
Brotor = bmax * (cos(rotor_speed * t + initial_angle) + j * sin(rotor_speed * t + initial_angle));

% Calculate a reference circle representing the expected maximum
circle = 1.5 * (cos(w*t) + j*sin(w*t));

% Plot the magnitude and direction of the resulting magnetic fields
figure;
for ii = 1:length(t)
    clf;
    % Plot the reference circle
    plot(circle, 'k');
    hold on;
    
    % Plot the three-phase stator magnetic fields
    plot([0 real(Baa(ii))], [0 imag(Baa(ii))], 'k', 'LineWidth', 2);
    plot([0 real(Bbb(ii))], [0 imag(Bbb(ii))], 'b', 'LineWidth', 2);
    plot([0 real(Bcc(ii))], [0 imag(Bcc(ii))], 'm', 'LineWidth', 2);
    
    % Plot the net rotating magnetic field
    plot([0 real(Bnet(ii))], [0 imag(Bnet(ii))], 'r', 'LineWidth', 3);
    
    % Plot the rotor magnetic field
    plot([0 real(Brotor(ii))], [0 imag(Brotor(ii))], 'g', 'LineWidth', 3);
    
    axis square;
    axis([-2 2 -2 2]);
    drawnow;
    hold off;
end