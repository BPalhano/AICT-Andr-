function [graph] = ber_plot(estimate, real)

    N = size(estimate,1);
    error = zeros(N,1);

    for i = 1:N

        error(i) = biterr(estimate(i,:), real) / 16;
    end


    graph = plot(-20:20, error, 'Color', 'blue');
    hold on
    xlabel("Eb/N0");
    ylabel("BER");
    title("Bit Error Rate x SNR");
    hold off
end

