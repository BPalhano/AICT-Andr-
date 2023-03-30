close all;
clear;
clc;

bits = 16;
EbN0dB = -20:20;
error = 0;

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


semilogy(EbN0dB, qfunc(sqrt(db2pow(EbN0dB))), 'blue')
hold on
lskf_ber(C, bpsk_demapping(x), EbN0dB, n, 10000);
hold off


 