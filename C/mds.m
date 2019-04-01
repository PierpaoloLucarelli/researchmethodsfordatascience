function data = mds(D, l)
    n = size(D, 1);
    I_n = eye(n);
    e = ones(n, 1);
    J = I_n  - ((1/n)*e*e');
    G = -0.5 * J * D * J;
    [evecs,evals] = eig(G);
    [evals, idx] = sort(diag(evals), 'descend');
    % sort eigenvectors
    idx = idx(1:n);
    evecs = evecs(:,idx);
    data = zeros(n, l);
    for i=1:n
        data(i,:) = sqrt(evals(i)) * evecs(i) * i;
    end
        
end