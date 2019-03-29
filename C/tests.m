data_set_choice = 1;

if data_set_choice == 0
    load fisheriris;
    data = meas;
    label = species;
elseif data_set_choice == 1
    fashion_mnist = readtable('fashion_mnist_2.csv');
    data = table2array(fashion_mnist(1:10000,2:end));
    label = table2array(fashion_mnist(1:10000,1)); 
else
    heart_data = readtable('heart.csv');
    data = table2array(heart_data(:,1:end-1));
    label = table2array(heart_data(:,end));
end    

time1   = clock;
[pca_data1, eigVecs] = mypca(data, 2);
time2   = clock;
fprintf('Covar-PCA:   %g\n', etime(time2, time1));

time1   = clock;
[pca_data2, eigVecs2] = gramPca(data, 2);
time2   = clock;
fprintf('Gram-PCA:   %g\n', etime(time2, time1));

time1   = clock;
[pca_data3, eigVecs3] = snapPca(data, 2, 1);
time2   = clock;
fprintf('Snap-PCA:   %g\n', etime(time2, time1));

time1   = clock;
[pca_data4, eigVecs4] = nystrom(data, 2);
time2   = clock;
fprintf('Nyst-PCA:   %g\n', etime(time2, time1));

time1   = clock;
sne_op = tsne(data);
time2   = clock;
fprintf('SNE:   %g\n', etime(time2, time1));


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
