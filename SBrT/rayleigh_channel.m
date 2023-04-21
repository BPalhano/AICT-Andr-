clear;
clc;
close all;

EbN0dB = -20:0.5:20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tx = 8; rx = 2;
Mod_order = 64;
data = randi([0 Mod_order-1], tx, 1);
txSig = pskmod(data, Mod_order, pi/Mod_order);
f = 2.4e9; sig = 4; % dB
Fd = (2/3.6)/(physconst('LightSpeed')/f);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numErr = 100;
numbits = 1e6;
lenEbN0 = length(EbN0dB);

RayleighFF = @(tx,rx) (rand(tx,rx) + 1j*rand(tx,rx))/sqrt(2);

Rff = RayleighFF(rx,tx);
SS = db2pow(randn()*sig);
PL = db2pow(32.4 + 17.3*log10(2.9) + 31.9*log10(300))^(-1);

h = PL*SS*Rff;
y = h * txSig;
y = awgn(y,20);



for i = EbN0dB
    
    % Simular a BER.
    


end

