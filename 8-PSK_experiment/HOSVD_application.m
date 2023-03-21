close all;
clear;
clc;

% Cleaning all values and figures in MATLAB for a new compilation;

phi1 = [1, exp(1i*pi)];
phi2 = [1, exp(1i*(pi + pi/2))];
phi3 = [1, exp(1i*(pi + pi/4))];
% Generating the already known signals;

phi4 = kron(phi1, phi2);
phi = kron(phi4, phi3);
 % Generating the n-PSK signal;

 signal = reshape(phi, [2 2 2])

 % And now, I can apply HOSVD dim-to-dim for this problem.