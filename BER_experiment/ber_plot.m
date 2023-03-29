function [graph] = ber_plot(estimate, real, loop)

    N = size(estimate,1);
    error = zeros(N/loop,1);
    MC_error = zeros(loop,1);
    counter = 1;

    for i = 1:N

        MC_error(i) = (biterr(estimate(i,:), real)/ size(estimate, 2));
        if mod(i,loop) == 0
            
            error(counter) = mean(MC_error(:));
            MC_error = zeros(loop,1);
            counter = counter + 1;
        end
    end


    graph = semilogy(linspace(-20,20, N/loop), error, 'Color', 'blue');
    hold on
    xlabel("Eb/N0");
    ylabel("BER");
    title("Bit Error Rate x SNR");
    hold off
end

