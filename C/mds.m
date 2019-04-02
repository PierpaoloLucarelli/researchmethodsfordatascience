function [data, stress] = mds(D, l)
    D = D.^2; 
    n = size(D, 1);
    I_n = eye(n);
    e = ones(n, 1);
    J = I_n  - ((1/n)*e*e');
    G = -0.5 * J * D * J;
    [evecs,evals] = eig(G);
    [evals, idx] = sort(diag(evals), 'descend');
    % sort eigenvectors
    idx = idx(1:l);
    evecs = evecs(:,idx);
    data = zeros(n, l);
    for i=1:l
        data(:,i) = sqrt(evals(i)) * evecs(:,i);
    end
    
    % get stress
    num = 0;
    den = 0;
    for i=1:size(D,1)
        for j=1:size(G,1)
            num = num + (D(i,j) - G(i,j))^2;
            den = den + D(i,j)^2;
        end
    end
    stress = sqrt(num/den);
        
end