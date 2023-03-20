close all;
clear;
clc;
% Cleaning all values and figures in MATLAB for a new compilation;

phi = [1.00000000000000 + 0.00000000000000i	-0.707106781186548 - 0.707106781186548i	
    -1.83697019872103e-16 - 1.00000000000000i	-0.707106781186547 + 0.707106781186548i
    -1.00000000000000 + 1.22464679914735e-16i	0.707106781186548 + 0.707106781186547i	
    3.06161699786838e-16 + 1.00000000000000i	0.707106781186547 - 0.707106781186548i];
% Importing the received value;

% I have to suppose to know at last one element of tensor I will first
% stract from phi? I say, all tensors utilized to generate Phi have a
% element in commum (1). What's the first tensor I will get?;




scatter(real(phi), imag(phi), 'filled');
circleplot(0,0,1);