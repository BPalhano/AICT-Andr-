function [demod_Signal] = binNpskdemod(mod_Signal, mod_Order)

P = log2(mod_Order);
demod_Signal = zeros(size(mod_Signal));

if mod_Order == 2 % BPSK case
    constellation = [1 exp(1j*pi)];
    
    for i = 1:length(mod_Signal)
        [~, index] = min(abs(mod_Signal(i)-constellation));
        demod_Signal(i) = index -1;
    end

else % MPSK, M > 2
    constellation = [1 exp(1j*(pi + pi/P))];
    for i = 1:length(mod_Signal)
        [~, index] = min(abs(mod_Signal(i)-constellation));
        demod_Signal(i) = index -1;
    end

end

