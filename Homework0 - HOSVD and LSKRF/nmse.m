function [nmse_metric] = nmse(A,Ahat)

nmse_metric = (norm((A - Ahat), "fro")/norm(A,"fro"))^2;

end

