close all;
clear;
clc;

A = [1, exp(1i*pi)];
B = [1, exp(1i*(pi + pi/2))];

C = kron(A,B);

[X,Y] = asim_lskf(C, size(A,1), size(A,2), size(B,1), size(B,2));

Z = kron(X,Y);

scatter(real(C), imag(C), 'filled', 'red');
figure;
scatter(real(Z), imag(Z),'filled', 'blue');