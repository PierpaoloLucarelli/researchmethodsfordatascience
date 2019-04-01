function [data, U_] = nystrom(dataset, l)
    S = dataset(:, 1:l);
    
    means = zeros(size(S, 2), 1);
    for i=1:size(S, 2)
        means(i) = mean(S(:,i));
        S(:, i) = S(:, i)-means(i);
    end
    % calculate the covariance matrix 
    C = cov(dataset);    
    C_ = C(1:l, :)';
    
   A = C_(1:l, :);
   B = C_(l+1:end, :);
   [Ua,eigVals] = eig(A);
   [Va, idx] = sort(diag(eigVals), 'descend');
   Va = diag(Va);
   Ua = Ua(:,idx);
   U_ = [ Ua ; B*Ua*inv(Va)];
   data = U_' * dataset';
   data = data';
   
   % add mean back to view vec image
   U_ = U_ + means;
end
