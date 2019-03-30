data = readtable('IRIS.csv');
% data = ratings;
% remove the column names and nasdon numeric columns
data = table2array(data(:,1:size(data, 2)-1));
data = data(1:5, :);
[pca_data1, eigVecs] = mypca(data, 2);
[pca_data2, eigVecs2] = gramPca(data, 2);
[pca_data3, eigVecs3] = snapPca(data, 2, 0.9);
[pca_data4, eigVecs4] = nystrom(data, 2);


%% MDS
% make similarity matrix
D = zeros(size(data, 1), size(data, 1));
for i=1:size(data, 1)
    for j=1:size(data, 1)
        D(i,j) = sum((data(i,:) - data(j,:)).^ 2);
    end
end

mds_data= mds(D, 2);
scatter(mds_data(:,1), mds_data(:,2))
% notes
% discuss complexity 
% test: check if the gram and cov are the same. show that code works 
% norm of difference
