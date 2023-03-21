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

% Reshaping the signal to do SVD:
signal = reshape(phi, [2 4]);

% Do SVD and recompose the eta and phi3:
[U1, S1, V1] = svd(signal);
sigma1 = S1(1,1);
phi3_hat = U1(:,1)*sqrt(sigma1);
eta = sqrt(sigma1)*conj(V1(:,1));

% Cat the bases and signal to resolve the scale problem:
alpha = 1 / phi3_hat(1,1);
beta = 1 / eta(1,1);

% Normalizing tensors:
phi3_hat = phi3_hat * alpha;
eta = eta * beta;

% Repeat the process to eta to get phi1 and phi2:
eta = reshape(eta, [2 2]);

[U2, S2, V2] = svd(eta);
sigma2 = S2(1,1);

phi2_hat = U2(:,1)*sqrt(sigma2);
phi1_hat = sqrt(sigma2)*conj(V2(:,1));

gamma = 1 / phi2_hat(1,1);
teta = 1 / phi1_hat(1,1);

phi2_hat = phi2_hat * gamma;
phi1_hat = phi1_hat * teta;

% And now, I will recompse the signal phi:
phi_hat = kron(phi1_hat, phi2_hat);
phi_hat = kron(phi_hat, phi3_hat);


t = tiledlayout(2,2);
% Scatterploting

nexttile
scatter(real(phi1_hat), imag(phi1_hat), 'filled', 'blue');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi2_hat), imag(phi2_hat), 'filled', 'red');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi3_hat), imag(phi3_hat), 'filled', 'MarkerFaceColor', '#77AC30');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi_hat), imag(phi_hat),'filled', 'black')
circleplot(0,0,1);
grid on

xlabel("In-Phase")
ylabel("Quadrature")

% :)
% By Igor Braga Palhano
% :)
