close all;
clear;
clc;
% Cleaning all values and figures in MATLAB for a new compilation;

phi1 = [1 exp(1i*pi)];
phi2 = [1, exp(1i*(pi + pi/2))];
phi3 = [1, exp(1i*(pi + pi/4))];
% Generating the already known signals;

phi4 = kron(phi1, phi2);
phi = kron(phi4, phi3);
 % Generating the n-PSK signal;

t = tiledlayout(2,2);
% Scatterploting

nexttile
scatter(real(phi1), imag(phi1), 'filled', 'blue');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi2), imag(phi2), 'filled', 'red');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi3), imag(phi3), 'filled', 'MarkerFaceColor', '#77AC30');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi), imag(phi),'filled', 'black')
circleplot(0,0,1);
grid on

xlabel("In-Phase")
ylabel("Quadrature")

% :)
% By Igor Braga Palhano
% :)