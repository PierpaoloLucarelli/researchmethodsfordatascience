function [data, U_] = nystrom(dataset, l)
    S = dataset(:, 1:l);
    means = zeros(size(S, 2), 1);
    for i=1:size(S, 2)
        means(i) = mean(S(:,i));
        S(:, i) = S(:, i)-means(i);
    end
  
    C = zeros(l,l);
    for i=1:size(dataset, 2)
        for j=1:l
            c = cov(dataset(:,i), dataset(:,j));
            C(i,j) = c(1,2);
        end
    end
    
   A = C(1:l, :);
   B = C(l+1:end, :);
   [Ua,eigVals] = eig(A);
   [Va, idx] = sort(diag(eigVals), 'descend');
   Va = diag(Va);
   Ua = Ua(:,idx);
   U_ = [ Ua ; B*Ua*inv(Va)];
   data = U_' * dataset';
   data = data';
   
   % add mean back to view vec image
   % U_ = U_ + means;
end
