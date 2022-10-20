clear;
close all;
clc;
% cleaning all values and figures in MATLAB for a new compilation;

Im = imread('Icon_Pinguin_1_512x512.png'); % geting the image;
Im_n = imnoise(Im,'salt & pepper', 0.02); % Adding salt and pepper noise to image;
Samp = double(rgb2gray(Im_n)); % Preprocessing the image to SVD process;
imshow(Im_n);
figure;
[R ,C] = size(Samp); % Geting the size of Image to compress;
limits = [0 255];  % Defining limits for plot;


[U ,S ,V] = svd(Samp); % Geting the SVD matrix;

k = 200; % Setting the compression value;

erro_relativo = S(k+1, k+1)/S(1,1); % Computating the relative error;
compress_ratio = (R + C - k + 1) * k / (R*C); % Computating the Compress Ratio;

imshow(U(:,1:k)*S(1:k,1:k)*V(:,1:k)', limits); % Showing the compress image;


figure; % Creating a new figure to plot the compression graph;

K = linspace(1,100,100);
aux = S(K+1, K+1)/S(1,1);
perr = diag(aux)';
comp_r =  (R + C - K + 1) .* K ./ (R*C);

% Relative error ploting (left yaxis bar);
yyaxis left
plot(K, perr);
title('Razão de compressão  erro relativo para K = [0 100].')
xlabel('K')
ylabel('Relative error.')

% Compression Ratio ploting (right yaxis bar);
yyaxis right
plot(K,comp_r);
ylabel('Compression Ratio.')

% Creating containers for PSNR and MSE about the orginal and compressed
% image;
Im_PSNR = [];
Im_MSE = [];

% Iterating through K size;
for e = 1:100

    aux_psnr = psnr(U(:,1:e)*S(1:e,1:e)*V(:,1:e)', Samp);
    aux_mse = immse(U(:,1:e)*S(1:e,1:e)*V(:,1:e)', Samp);
    Im_PSNR = [Im_PSNR, aux_psnr];
    Im_MSE = [Im_MSE, aux_mse];
    % Storing the value of PSNR and MSE for all compression values;
end

figure;


% Ploting the function;
plot(Im_MSE, Im_PSNR)
title('MSE x PSNR')
xlabel('MSE')
ylabel('PSNR')



