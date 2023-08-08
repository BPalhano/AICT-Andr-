clear; clc; close all;

s1 = [1, exp(pi*1i)];
s2 = [1, exp((pi + pi/2)*1i)];
s3 = [1, exp((pi + pi/4)*1i)];

s = kron(s1,s2);
s = kron(s,s3);

s = reshape(s, [2 2 2]);

su1 = unfold(s,1);
su2 = unfold(s,2);
su3 = unfold(s,3);

[u1, s_1, v1] = svd(su1);

s1hat = sqrt(s_1(1,1)) .* u1(:,1);
s1hat = (s1(1,1))/ (s1hat(1,1)) .* s1hat;

[u2, s_2, v2] = svd(su2);

s2hat = sqrt(s_2(1,1)) .* u2(:,1);
s2hat = (s2(1,1)/ s2hat(1,1)) .* s2hat;

[u3, s_3, v3] = svd(su3);

s3hat = sqrt(s_3(1,1)) .* u3(:,1);
s3hat = (s3(1,1)/s3hat(1,1)) .* s3hat;


function [A] = unfold(ten,mode)
    dim = size(ten);
    order = 1:numel(dim);
    order(mode) = [];
    order = [mode order];
    A = reshape(permute(ten,order), dim(mode), prod(dim)/dim(mode));
end
