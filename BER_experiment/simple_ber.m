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

% Here I have to do a Monte-Carlo simulation.
for EbN0 = -20:20 % SNR range (dB)
    
    i = 10^(EbN0/10);
    sigma = norm(C_8x1, "fro") / (i * norm(n,"fro"));    
    Noise = rand(size(C_8x1,1), size(C_8x1,2));
    
    y_8x1 = C_8x1 + sigma*Noise;
    [B_8x1_hat, A_8x1_hat] = norm_lskf(reshape(y_8x1, [8 8]), 1);
    
    A_8x1_hat = bpsk_decider(A_8x1_hat, 0);
    B_8x1_hat = bpsk_decider(B_8x1_hat, 0);

    plot_8x1 = [plot_8x1; A_8x1_hat', B_8x1_hat'];
    
end

nmse(plot_8x1, s)


 