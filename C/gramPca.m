function [data, eigenV] = gramPca(dataset, n)
    % when number of points (m) is smaller than the number of dimentions (n)
    if(n > size(dataset, 2))
        disp('PCA dimentionality cannot be larger than dimentions of dataset');
        data = 0;
    else
        % substract means from each dimension
        means = zeros(size(dataset, 2), 1);
        for i=1:size(dataset, 2)
            means(i) = mean(dataset(:, i));
            dataset(:, i) = dataset(:, i)-means(i);
        end
        gram = dataset * dataset';
        [evecs,evals] = eig(gram);
        [~, idx] = sort(diag(evals), 'descend');
        % sort eigenvectors
        idx = idx(1:n);
        evecs = evecs(:,idx);
        evals = diag(evals);
        evals = evals(idx);
        
        % compute the basis vectors
        eigenV = zeros(size(dataset, 2), n);
        for i=1:n
            eigenV(:,i) = 1 / (sqrt(evals(i))) * (dataset' * evecs(:,i));
        end
        data = eigenV' * dataset';
        data = data';
    end
end