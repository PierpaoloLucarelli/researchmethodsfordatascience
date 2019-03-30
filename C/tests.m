data = readtable('IRIS.csv');
% remove the column names and non numeric columns
data = table2array(data(:,1:size(data, 2)-1));
[pca_data1, eigVecs] = mypca(data, 3);
[pca_data2, eigVecs2] = gramPca(data, 3);
[pca_data3, eigVecs3] = snapPca(data, 3, 0.9);
[pca_data4, eigVecs4] = nystrom(data, 3);


% notes
% discuss complexity 
% test: check if the gram and cov are the same. show that code works 
% norm of difference
