function [data, eigenV] = mypca(dataset, n)
    if(n > size(dataset, 2))
        disp('PCA dimentionality cannot be larger than dimentions of dataset');
        data = 0;
    else
        if size(dataset, 1) > 1
            % substract means from each dimension
            means = zeros(size(dataset, 2), 1);
            for i=1:size(dataset, 2)
                means(i) = mean(dataset(:, i));
                dataset(:, i) = dataset(:, i)-means(i);
            end
        end
        
        % calculate the covariance matrix 
        C = cov(dataset);    
        % get the eigenvectors and eigenvalues
        [evecs,evals] = eig(C);
        [~, idx] = sort(diag(evals), 'descend');
        % sort eigenvectors
        idx = idx(1:n);
        evecs = evecs(:,idx);
        data = evecs' * dataset';
        data = data';
        eigenV = evecs;
       
    end
end
