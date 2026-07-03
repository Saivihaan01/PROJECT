clc;
clear;
close all;

%% INPUT PARAMETERS
rho = 1000;            % fluid density (kg/m^3)
mu = 0.001;            % viscosity (Pa.s)
D = 0.1;               % pipe diameter (m)
L = 10;                % pipe length (m)

velocity = 0.5:0.1:5;  % flow velocity range (m/s)

% material properties (steel example)
hardness = 200;        % HV (relative scale)
erosion_coeff = 1e-5;  % material erosion constant

%% CALCULATIONS

Re = (rho .* velocity .* D) ./ mu;

% friction factor (Blasius equation for turbulent flow approx)
f = 0.316 ./ (Re .^ 0.25);

% pressure drop (Darcy-Weisbach)
pressure_drop = f .* (L/D) .* (rho .* velocity.^2 / 2);

% erosion rate model (velocity-dependent wear)
erosion_rate = erosion_coeff .* (velocity.^2) ./ hardness;

%% PLOTS

figure;

subplot(3,1,1);
plot(velocity, Re, 'b', 'LineWidth', 2);
xlabel('Velocity (m/s)');
ylabel('Reynolds Number');
title('Flow Regime Analysis');
grid on;

subplot(3,1,2);
plot(velocity, pressure_drop, 'r', 'LineWidth', 2);
xlabel('Velocity (m/s)');
ylabel('Pressure Drop (Pa)');
title('Fluid Loss in Pipeline');
grid on;

subplot(3,1,3);
plot(velocity, erosion_rate, 'g', 'LineWidth', 2);
xlabel('Velocity (m/s)');
ylabel('Erosion Rate');
title('Material Wear due to Fluid Flow');
grid on;

%% OUTPUT
fprintf('Max Reynolds Number: %.2f\n', max(Re));
fprintf('Max Pressure Drop: %.2f Pa\n', max(pressure_drop));