function [data, eigenV] = snapPca(dataset, n, fraction)
    % when number of points (m) is smaller than the number of dimentions (n)
    if(n > size(dataset, 2))
        disp('PCA dimentionality cannot be larger than dimentions of dataset');
        data = 0;
    else
       num_to_fetch = floor(size(dataset, 1) * fraction);
       dataset = dataset(randperm(size(dataset, 1), num_to_fetch), :);
       [data, eigenV] = gramPca(dataset, n);
    end
end