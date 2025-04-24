
% Initialize values
r1 = 0.641;       % Stator resistance
x1 = 1.106;       % Stator reactance
r2 = 0.332;       % Rotor resistance
x2 = 0.464;       % Rotor reactance
xm = 26.3;        % Magnetization branch reactance
v_phase = 460 / sqrt(3);  % Phase voltage
n_sync = 1800;    % Synchronous speed (rpm)
w_sync = 188.5;   % Synchronous speed (rad/s)

% Calculate Thevenin equivalent voltage and impedance
z_th = 1i * xm * (r1 + 1i * x1) / (r1 + 1i * (x1 + xm));
v_th = abs(v_phase * (1i * xm) / (r1 + 1i * (x1 + xm)));
r_th = real(z_th);
x_th = imag(z_th);

% Calculate torque-speed characteristic
s = linspace(0.001, 1, 51);      % Slip values (avoid 0 to prevent division by zero)
n_run = (1 - s) * n_sync;        % Mechanical speed (rpm)

% Torque for original rotor resistance
t_ind1 = zeros(size(s));
for ii = 1:length(s)
    t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
        (w_sync * ((r_th + r2 / s(ii))^2 + (x_th + x2)^2));
end

% Torque for doubled rotor resistance
t_ind2 = zeros(size(s));
for ii = 1:length(s)
    t_ind2(ii) = (3 * v_th^2 * (2 * r2) / s(ii)) / ...
        (w_sync * ((r_th + (2 * r2) / s(ii))^2 + (x_th + x2)^2));
end

% Torque for halved rotor resistance
t_ind3 = zeros(size(s));
for ii = 1:length(s)
    t_ind3(ii) = (3 * v_th^2 * (r2 / 2) / s(ii)) / ...
        (w_sync * ((r_th + (r2 / 2) / s(ii))^2 + (x_th + x2)^2));
end

% Plot the torque-speed curves
plot(n_run, t_ind1, 'k', 'LineWidth', 2.0);
hold on;
plot(n_run, t_ind2, 'k--', 'LineWidth', 2.0);
plot(n_run, t_ind3, 'k:', 'LineWidth', 2.0);  % Dashed line for halved R_2
xlabel('n_{m} (rpm)', 'FontWeight', 'bold');
ylabel('\tau_{ind}', 'FontWeight', 'bold');
title('Induction Motor Torque-Speed Characteristic', 'FontWeight', 'bold');
legend('Original R_2', 'Doubled R_2', 'Halved R_2');
grid on;

% Annotate value of R_2/2
text(n_run(end) - 250, t_ind3(end), ['R_2/2 = ', num2str(r2/2)], ...
    'FontSize', 10, 'FontWeight', 'bold', 'Color', 'k');

hold off;
