# Sigle Value Decomposition for Gray images

My first step in TSP was to review some linear algebra concepts and how to 
apply them using MATLAB. In this code, I compressed the 
`Icon_Pinguin_1_512x512` and generated some graphs.

In the first code (`SVD_compac.m`) I compressed the image with noise, then 
generated the images `PSNRxMSE.jpg` and `bigraph.jpg`, in the former I 
generated a PSNR vs MSE curve, and in the latter I printed the Relative 
Error vs Compression Rate.

In the second code (`SVD_noisy_im.m`) I first generated a color noisy image
 and then used the SVD technique to compress the noisy image and generate 
the same graphs as in the first code.