function [symb] = binNpskmod(N, Mod_order)
%NPSK_SYMBOLS %   Detailed explanation goes here

P = log2(Mod_order);


if Mod_order == 2 % BPSK case
    symb = randi([0 1], N,1);
    for i = 1:N
        if symb(i) < 1
        
            symb(i) = exp(1j*pi); 
        end
    end

else % M-PSK case (M>2)
    symb = randi([0 1], N,1);
 
    for i = 1:N
        if symb(i) < 1

            symb(i) = exp(1j*(pi + pi/(P)));
        end
    end

end

