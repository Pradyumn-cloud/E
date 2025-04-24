% M-file: term_char_a.m
% This script plots the terminal characteristics of the generator 
% in Example 5-4 with a 0.8 PF lagging load.

% Initialize the current amplitudes (21 values in the range 0 to 60 A)
i_a = linspace(0, 60, 21);

% Initialize all other values
v_phase = zeros(1, 21);
e_a = 277.0;  % Internal generated voltage
x_s = 1.0;    % Synchronous reactance
theta = 36.87 * (pi / 180);  % Convert degrees to radians

% Calculate v_phase for each current level
for ii = 1:21
    v_phase(ii) = sqrt((e_a - x_s * i_a(ii) * cos(theta))^2 + (x_s * i_a(ii) * sin(theta))^2);
end

% Calculate terminal voltage from the phase voltage
v_t = v_phase * sqrt(3);

% Plot the terminal characteristic
plot(i_a, v_t, 'Color', 'k', 'LineWidth', 2.0);
xlabel('Line Current (A)', 'FontWeight', 'Bold');
ylabel('Terminal Voltage (V)', 'FontWeight', 'Bold');
title('Terminal Characteristic for 0.8 PF Lagging Load', 'FontWeight', 'Bold');
grid on;
axis([0 60 400 550]);