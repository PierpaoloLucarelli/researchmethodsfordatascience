data = readtable('IRIS.csv');
% data = ratings;
% remove the column names and nasdon numeric columns
data = table2array(data(:,1:size(data, 2)-1));
[pca_data1, eigVecs] = mypca(data, 2);
[pca_data2, eigVecs2] = gramPca(data, 2);
[pca_data3, eigVecs3] = snapPca(data, 2, 0.9);
[pca_data4, eigVecs4] = nystrom(data, 2);

% matlabs PCA
evecs = pca(data);
pca_data5 = evecs(:,1:2)' * data';

figure
subplot(2,1,1)
gscatter(pca_data1(:,1), pca_data1(:,2));
title('Classic PCA')  
subplot(2,1,2)
gscatter(pca_data5(1, :), pca_data5(2,:));
title('Matlab PCA')
% subplot(2,2,2)
% gscatter(pca_data2(:,1), pca_data2(:,2));
% title('gram PCA')  
% subplot(2,2,3)
% gscatter(pca_data3(:,1), pca_data3(:,2));
% title('Snapshot PCA')  
% subplot(2,2,4)
% gscatter(pca_data4(:,1), pca_data4(:,2));
% title('Nyström PCA')

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


%%
d = load('mnist.mat');
X = d.trainX;
X = im2double(X(1:100, :));
[pca_data1, eigVecs] = mypca(X, 2);
%%
data_set_choice = 0;

if data_set_choice == 0
    load fisheriris;
    data = meas;
    label = species;
elseif data_set_choice == 1
    fashion_mnist = readtable('fashion_mnist_2.csv');
    data = table2array(fashion_mnist(1:10000,2:end));
    label = table2array(fashion_mnist(1:10000,1)); 
elseif data_set_choice == 2
    importfile('cifar-10.mat');
    data  = double(data); 
    data = data(1:100,:);
    label = double(labels);
    label = label(1:100, :);
else
    heart_data = readtable('heart.csv');
    data = table2array(heart_data(:,1:end-1));
    label = table2array(heart_data(:,end));
end    

%data  = data(10,:);

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
subplot(2,1,1)
gscatter(pca_data2(:,1), pca_data2(:,2), label);
title('Gram PCA')  
subplot(2,1,2)
gscatter(pca_data5(1, :), pca_data5(2,:), label);
title('Matlab PCA')

% figure
% 
% gscatter(pca_data1(:,1), pca_data1(:,2), label);
% 
% figure
% gscatter(pca_data2(:,1), pca_data2(:,2), label);
% 
% figure
% gscatter(pca_data3(:,1), pca_data3(:,2), label);
% 
% figure
% gscatter(pca_data4(:,1), pca_data4(:,2), label);
% 
% figure
% gscatter(sne_op(:,1), sne_op(:,2), label);
