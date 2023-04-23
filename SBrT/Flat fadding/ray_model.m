function FF = ray_model(L)
% Rayleigh Channel Model
% Inputs:
% L : Number of Channel Realizations
% Outputs:
% FF = Channel fast-term fadding vector

FF = (randn(1,L) +1j*randn(1,L)/sqrt(2));