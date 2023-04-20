clear;
clc;
close all;

tx = 8; rx = 2;
Mod_order = 64;
data = randi([0 Mod_order-1], tx, 1);
txSig = pskmod(data, Mod_order, pi/Mod_order);

f = 2.4e9;
Fd = (2/3.6)/(physconst('LightSpeed')/f);

RayleighFF = @(tx,rx) (rand(tx,rx) + 1j*rand(tx,rx))/sqrt(2);

Rff = RayleighFF(tx,rx);

sig = 4; % dB

SS = randn()*sig; % dB
SS = db2pow(SS); % linear

PL = 32.4 + 17.3*log10(2.9) + 31.9*log10(300);
PL = db2pow(PL)^(-1);

h = PL*SS*Rff;



