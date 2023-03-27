function symbols_hat = bpsk_decider(symbols, filter)

symbols_hat = zeros(size(symbols,1), size(symbols,2));

for i = 1:size(symbols, 1)

    if(symbols(i) < filter)
        symbols_hat(i) = 0;

    else
        symbols_hat(i) = 1;
    end
end


end

