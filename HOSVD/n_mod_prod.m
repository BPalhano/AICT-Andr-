function [ten] = n_mod_prod(ten,matrices,modes)
    dim = size(ten);
    number = numel(matrices);
    if nargin < 3
       modes = 1:number; 
    end
    
    for i = modes
        ten = cell2mat(matrices(i))*unfold(ten,i);
        [aux,~] = size(cell2mat(matrices(i)));
        dim(i) = aux;
        ten = fold(ten,[dim],i);
    end
end
