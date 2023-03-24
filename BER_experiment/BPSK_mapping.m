function signal = BPSK_mapping(source)

signal = zeros(size(source,1), size(source,2));

N = size(signal,2);

for i = 1:N

    if(source(1,i) == 1)
        signal(1,i) = 1;
    else
        signal(1,i) = -1;
    end

end

