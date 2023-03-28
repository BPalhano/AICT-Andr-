close all;
clear;
clc;

bits = 16;

% Generating the mapping again:
BPSK = [1, exp(1i*pi)];

% Generating the information;
s = randi(5,1,bits);
s = (s < 5);
x = BPSK_mapping(s);
 
% generating A and B;
n = bits/2;

A_8x1 = x(:,1:n);
B_8x1 = x(:,n+1:end);

% Generating C:
C_8x1 = kron(A_8x1,B_8x1);

plot_8x1 = [];

realization = 100;

% Here I have to do a Monte-Carlo simulation.
for EbN0 = -20:20 % SNR range (dB)

    sigma = 1/(10^(EbN0/10)); 
    % Noise = rand(size(C_8x1,1), size(C_8x1,2));
    % sigma = norm(C_8x1, "fro") / (i * norm(Noise,"fro"));

    for ii = 1:realization
        
        noise = sqrt(sigma) * sqrt(1/2) * (randn(size(C_8x1)) + 1i*randn(size(C_8x1)));
        y_8x1 = C_8x1 + noise;
        [B_8x1_hat, A_8x1_hat] = norm_lskf(reshape(y_8x1, [n n]), 1);
    
        A_8x1_hat = bpsk_decider(A_8x1_hat, 0);
        B_8x1_hat = bpsk_decider(B_8x1_hat, 0);

        plot_8x1 = [plot_8x1; A_8x1_hat', B_8x1_hat'];
    end
    
end

ber_plot(plot_8x1, s)


 