function signal = bpsk_demapping(symbols)

signal = zeros(size(symbols));

N = size(symbols,2);

for i = 1:N

    if(symbols(1,i) == 1)
    
        signal(1,i) = 1;

    end


end

