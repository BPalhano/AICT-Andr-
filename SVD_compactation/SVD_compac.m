
clear;
close all;
clc;
% cleaning all values and figures in MATLAB for a new compilation;


Im = imread('Icon_Pinguin_1_512x512.png'); % geting the image;
Samp = double(rgb2gray(Im)); % Preprocessing the image to SVD process;
imshow(Samp);

[R ,C] = size(Samp); % Geting the size of Image to compress;
limits = [0 255];  % Defining limits for plot;


[U ,S ,V] = svd(Samp); % Geting the SVD matrix;

k = 60; % Setting the compression value;

erro_relativo = S(k+1, k+1)/S(1,1); % Computating the relative error;
compress_ratio = (R + C - k + 1) * k / (R*C); % Computating the Compress Ratio;

imshow(U(:,1:k)*S(1:k,1:k)*V(:,1:k)', limits); % Showing the compress image;

figure;

% Generating the image with the k last eightvalues of image;
imshow(U(:,512 - k:512)*S(512 - k:512,512 - k:512)*V(:,512 - k:512)', limits)

figure; % Creating a new figure to plot the compression graph;

K = linspace(1,100,100);
aux = S(K+1, K+1)/S(1,1);
perr = diag(aux)';
comp_r =  (R + C - K + 1) .* K ./ (R*C);

% Relative error ploting (left yaxis bar);
yyaxis left
plot(K, perr);
title('Razão de compressão  erro relativo para K = [0 512].')
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


%                           FONTES:
% Álgebra Linear: Teoria e prática (Autor: Thelmo de Araújo)
% http://databookuw.com/databook.pdf
% https://app.uff.br/riuff/bitstream/handle/1/4173/Juliano%20Vieira%20de%20Oliveira%202016-1.PDF?sequence=1&isAllowed=y
% https://iopscience.iop.org/article/10.1088/1757-899X/263/4/042082/pdf




