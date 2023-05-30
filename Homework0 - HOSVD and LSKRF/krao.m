function C = krao(A,B)
[ia,ja] = size(A);
[ib] = size(B,1);

C = zeros(ia*ib,ja);

for j = 1:ja
   C(:,j) = kron(A(:,j),B(:,j));
end


end