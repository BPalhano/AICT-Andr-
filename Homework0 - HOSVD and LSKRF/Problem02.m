clear; close all; clc;

step = 5;
ebnoVec = -10:5:20;
nmseVecX1 = zeros(size(ebnoVec));nmseVecX2 = zeros(size(ebnoVec));nmseVecX3 = zeros(size(ebnoVec));
act_nmseX1 = zeros(1,5e3); act_nmseX2 = zeros(1,5e3); act_nmseX3 = zeros(1,5e3); counter = 1;

for ebno = ebnoVec

    sigma = 1/10^(ebno/10);

    for ii = 1:5e3
        % data1 = randi([0 1], 10,1); % X1 symbols
        % data2 = randi([0 1], 20,1); % X2 symbols
        % data3 = randi([0 1], 10,1); % X3 symbols
        %    
        % data2_bin = bit2int(data2,2); % Generating the binary string for data2.
        %
        % Data = [data1; data2_bin ; data3];

        X1 = [1, exp(1j*pi); 1, exp(1j*pi); 1, exp(1j*pi); 1, exp(1j*pi);]';
        X2 = [1, exp(1j*(pi + pi/2)), exp(1j*pi), exp(1j*(pi-pi/2));
             1, exp(1j*(pi + pi/2)), exp(1j*pi), exp(1j*(pi-pi/2));
             1, exp(1j*(pi + pi/2)), exp(1j*pi), exp(1j*(pi-pi/2));
             1, exp(1j*(pi + pi/2)), exp(1j*pi), exp(1j*(pi-pi/2))]';
        X3 = [1, exp(1j*pi);1, exp(1j*pi);1, exp(1j*pi);1, exp(1j*pi);]';

        X1kX2 = krao(X1, X2);
        X = krao(X1kX2, X3);
        
        N = sqrt(sigma/2)*(randn(size(X)) + 1j*randn(size(X)));
        Y = X + N;

        % LSKF factorization and removing scale anbiguity
        [X1kX2hat , X3hat] = LSKRF(Y, size(X1kX2,1), size(X3,1));
        [X1hat, X2hat] = LSKRF(X1kX2hat,size(X1,1), size(X2,1));

        X1hat = X1hat .* (1 ./ X1hat(1,:));
        X2hat = X2hat .* (1 ./ X2hat(1,:));
        X3hat = X3hat .* (1 ./ X3hat(1,:));

        % data1hat = pskdemod(X1hat,2);
        % data2hat = pskdemod(X2hat,4);
        % data3hat = pskdemod(X3hat,2);
        %
        %data2hat_bits = int2bit(data2hat,2);
        %
        % nmseX1 =  nmse(data1, data1hat);
        % nmseX2 =  nmse(data2hat_bits, data2);
        % nmseX3 =  nmse(data3, data3hat);

        nmseX1 =  nmse(X1, X1hat);
        nmseX2 =  nmse(X2, X2hat);
        nmseX3 =  nmse(X3, X3hat);

        act_nmseX1(1,ii) = nmse(X1, X1hat);
        act_nmseX2(1,ii) = nmse(X2, X2hat);
        act_nmseX3(1,ii) = nmse(X3, X3hat);

        disp(["Actual SNR: " ebno "loop: " num2str(ii)]);
        disp([num2str(act_nmseX1(1,ii)) " " num2str(act_nmseX2(1,ii)) " " num2str(act_nmseX3(1,ii))]);
        
    end

    nmseVecX1(counter) = mean(act_nmseX1,2);
    nmseVecX2(counter) = mean(act_nmseX2,2);
    nmseVecX3(counter) = mean(act_nmseX3,2);

    act_nmseX1 = zeros(1,5e3);  act_nmseX2 = zeros(1,5e3);  act_nmseX3 = zeros(1,5e3);
    counter = counter + 1;


end

plot(ebnoVec,nmseVecX1, 'r--o');
hold on
plot(ebnoVec, nmseVecX2, 'g--o');
plot(ebnoVec, nmseVecX3, 'b--o');

xlim([ebnoVec(1) ebnoVec(end)]);
title("Linear plot for NMSE");

xlabel("Eb/N0 [dB]");
ylabel("NMSE");

legend({'X1(BPSK)','X2(QPSK)','X3(BPSK)'});

figure;

semilogy(ebnoVec,nmseVecX1, 'r--o');
hold on
semilogy(ebnoVec, nmseVecX2, 'g--o');
semilogy(ebnoVec, nmseVecX3, 'b--o');

xlim([ebnoVec(1) ebnoVec(end)]);
title("Semilogy plot for NMSE");

xlabel("Eb/N0 [dB]");
ylabel("NMSE");

legend({'X1(BPSK)','X2(QPSK)','X3(BPSK)'});


