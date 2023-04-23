function [FF] = ric_model(K_dB, L)
% Rician channel model
% Inputs:
% K_dB : K factor (in [dB])
% L : Number of Channel Realizations
% Outputs:
% FF = Channel  fast-term fadding vector

K = 10 ^(K_dB/10);
FF = sqrt(K/(K + 1)) + sqrt(1/(K + 1))*ray_model(L);

end

