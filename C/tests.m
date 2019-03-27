%data = readtable('IRIS.csv');

load fisheriris;
data = meas;

% remove the column names and non numeric columns
%data = table2array(data(:,1:size(data, 2)-1));

[pca_data1, eigVecs] = mypca(data, 2);
[pca_data2, eigVecs2] = gramPca(data, 2);
[pca_data3, eigVecs3] = snapPca(data, 2, 0.5);
[pca_data4, eigVecs4] = nystrom(data, 2);


figure
gscatter(pca_data1(:,1), pca_data1(:,2), species);

figure
gscatter(pca_data2(:,1), pca_data2(:,2), species);

figure
gscatter(pca_data3(:,1), pca_data3(:,2), species);

figure
gscatter(pca_data4(:,1), pca_data4(:,2), species);
