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

A = x(:,1:n);
B = x(:,n+1:end);

% Generating C:
C = kron(A,B);

% Generating AWGN:


% Here I have to do a Monte-Carlo simulation.
for i = -5:20 % SNR range
    
    EbN0 = 10^(i/10);
    sigma = norm(C, "fro") / (EbN0 * norm(n,"fro"));
    
    y = C + n;
    [A_hat, B_hat] = norm_lskf(reshape(y, [8 8]));
    
end



 