close all;
clear;
clc;

phi1 = [1, exp(1i*(pi))]; % BPSK
phi2 = [1, exp(1i*(pi + pi/2))]; % QPSK
phi3 = [1, exp(1i*(pi + pi/4))]; % 8-PSK
phi4 = [1, exp(1i*(pi + pi/8))]; % 16-PSK

% Generating the full 16-PSK constelation.
phi = kron(phi1, phi2);
phi = kron(phi, phi3);
phi = kron(phi, phi4);

% Visualizating
hold on
scatter(real(phi), imag(phi), 'filled', 'black');
circleplot(0,0,1);
grid on
hold off

figure;

[phi4_hat, teta] = norm_lskf(reshape(phi, [2 8]));
[phi3_hat, eta] = norm_lskf(reshape(teta, [2 4]));
[phi2_hat, phi1_hat] = norm_lskf(reshape(eta, [2 2]));

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
scatter(real(phi4_hat), imag(phi4_hat),'filled', 'black')
circleplot(0,0,1);
grid on

xlabel("In-Phase")
ylabel("Quadrature")

figure;

% Recompose of signal after LSKF:
phi_hat = kron(phi1_hat, phi2_hat);
phi_hat = kron(phi_hat, phi3_hat);
phi_hat = kron(phi_hat, phi4_hat);

scatter(real(phi_hat), imag(phi_hat), 'filled', 'black');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

function [A,B] = norm_lskf(tensor)
    [u,s,v] = svd(tensor);
    sig = s(1,1);
    
    A = u(:,1) * sqrt(sig);
    B = sqrt(sig) * conj(v(:,1));

    norm_A = 1 / A(1,1);
    norm_B = 1 / B(1,1);

    A = A * norm_A;
    B = B * norm_B;

end