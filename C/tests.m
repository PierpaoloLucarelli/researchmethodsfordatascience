data_set_choice = 1;

if data_set_choice == 0
    load fisheriris;
    data = meas;
    label = species;
elseif data_set_choice == 1
    fashion_mnist = readtable('fashion_mnist_2.csv');
    data = table2array(heart_data(:,2:end));
    label = table2array(heart_data(:,1)); 
else
    heart_data = readtable('heart.csv');
    data = table2array(heart_data(:,1:end-1));
    label = table2array(heart_data(:,end));
end    
 
% remove the column names and non numeric columns
%data = table2array(data(:,1:size(data, 2)-1));

[pca_data1, eigVecs] = mypca(data, 2);
[pca_data2, eigVecs2] = gramPca(data, 2);
[pca_data3, eigVecs3] = snapPca(data, 2, 1);
[pca_data4, eigVecs4] = nystrom(data, 2);
sne_op = tsne(data);


figure
gscatter(pca_data1(:,1), pca_data1(:,2), label);

figure
gscatter(pca_data2(:,1), pca_data2(:,2), label);

figure
gscatter(pca_data3(:,1), pca_data3(:,2), label);

figure
gscatter(pca_data4(:,1), pca_data4(:,2), label);

figure
gscatter(sne_op(:,1), sne_op(:,2), label);
