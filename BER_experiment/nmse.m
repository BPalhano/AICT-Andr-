function [graph] = nmse(tensor_hat, tensor, EbN0_range)
    
    NMSE = zeros(size(tensor_hat, 1), size(tensor_hat, 2));

    for i = 1:size(tensor,2)
        
        NMSE(i,:) = ((norm(tensor(i,:) - tensor_hat(i,:), "fro")) ...
            / (norm(tensor(i,:), "fro"))^2);
    end

    graph = plot(EbN0_range, NMSE, "Marker","diamond");

end

