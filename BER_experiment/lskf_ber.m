function [graph] = lskf_ber(signal, SNR_range, n)
    
    act_error = 0;
    mean_error = 0;
    counter = 1;

    errors = zeros(size(SNR_range));
    
    for i = SNR_range

        while act_error < 100
            

            y = awgn(signal, i);
            
            [Bhat,Ahat] = norm_lskf(reshape(y, [n n]), 1);

            signal_hat = [Ahat' Bhat'];
            signal_hat = bpsk_decider(signal_hat, 0);
            
            act_ber = biterr(signal, signal_hat) / (2*n);
            act_error = act_error + biterr(signal, signal_hat);
            mean_error = max(mean_error, act_ber);

        end

        act_error = 0;
        errors(counter) = mean_error;
        mean_error = 0;
        
    end

    graph = semilogy( SNR_range, errors, 'Color', 'Red'); 
    xlabel("Eb/N0");
    ylabel("BER");
    title("Bit Error Rate x Eb/N0");

end

