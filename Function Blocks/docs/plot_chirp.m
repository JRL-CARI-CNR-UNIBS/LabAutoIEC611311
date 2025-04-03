% Clear workspace, close all figures, and clear command window
clear all; close all; clc

% Generate a time vector from 0 to 10 seconds with 1e5 points (high resolution)
t = linspace(0, 10, 1e5)';

% Generate a linear chirp signal: starts at 1 Hz and ends at 30 Hz over 10 s
s = chirp(t, 1, 10, 30);

% Plot the original chirp signal (position-like behavior)
plot(t, s);

% Compute time step
dt = t(2) - t(1);

% Compute the first derivative (velocity) using finite differences
ds = [0; diff(s) / dt];

% Compute the second derivative (acceleration)
dds = [0; diff(ds) / dt];

% Integrate the signal once to simulate position from velocity input
is = cumtrapz(t, s);

% Integrate twice to simulate position from acceleration input
iis = cumtrapz(t, is);

%% Plot 1: Chirp as Position Input
figure;
sgtitle('Chirp Signal Applied to Position');

subplot(3,1,1);
plot(t, s, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Position [units]');

subplot(3,1,2);
plot(t, ds, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Velocity [units/s]');

subplot(3,1,3);
plot(t, dds, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Acceleration [units/s^2]');

% Export figure to high-res transparent PNG
export_fig chirp_position.png -r 300 

%% Plot 2: Chirp as Velocity Input
figure;
sgtitle('Chirp Signal Applied to Velocity');

subplot(3,1,1);
plot(t, is, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Position [units]');

subplot(3,1,2);
plot(t, s, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Velocity [units/s]');

subplot(3,1,3);
plot(t, ds, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Acceleration [units/s^2]');

export_fig chirp_velocity.png -r 300 

%% Plot 3: Chirp as Acceleration Input
figure;
sgtitle('Chirp Signal Applied to Acceleration');

subplot(3,1,1);
plot(t, iis, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Position [units]');

subplot(3,1,2);
plot(t, is, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Velocity [units/s]');

subplot(3,1,3);
plot(t, s, 'LineWidth', 1.5);
grid on;
xlabel('Time [s]');
ylabel('Acceleration [units/s^2]');

export_fig chirp_acceleration.png -r 300
