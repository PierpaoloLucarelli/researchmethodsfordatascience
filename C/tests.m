
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
subplot(2,2,2)
gscatter(pca_data2(:,1), pca_data2(:,2));
title('gram PCA')  
subplot(2,2,3)
gscatter(pca_data3(:,1), pca_data3(:,2));
title('Snapshot PCA')  
subplot(2,2,4)
gscatter(pca_data4(:,1), pca_data4(:,2));
title('Nystr�m PCA')

%% MDS
data = readtable('IRIS.csv');
data = table2array(data(:,1:size(data, 2)-1));
D = pdist(data, 'euclidean');
D = squareform(D);
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
elseif data_set_choice == 3
    data = read_celeb_img(100);
else
    heart_data = readtable('heart.csv');
    data = table2array(heart_data(:,1:end-1));
    label = table2array(heart_data(:,end));
end    


%%
time1   = clock;
[pca_data2, eigVecs2] = gramPca(data, 2);
time2   = clock;
fprintf('Gram-PCA:   %g\n', etime(time2, time1));
imageArray = viewEigenImages(eigVecs2, eigVecs2(:,1));
figure
imshow(imageArray);

time1   = clock;
[pca_data1, eigVecs] = mypca(data, 2);
time2   = clock;
fprintf('Covar-PCA:   %g\n', etime(time2, time1));

time1   = clock;
[pca_data4, eigVecs4] = nystrom(data, 2);
time2   = clock;
fprintf('Nyst-PCA:   %g\n', etime(time2, time1));

time1   = clock;
sne_op = tsne(data);
time2   = clock;
fprintf('SNE:   %g\n', etime(time2, time1));

time1   = clock;
fraction = 0.8;
[pca_data3, eigVecs3] = snapPca(data, 2, fraction);
time2   = clock;
num_to_fetch = floor(size(data, 1) * fraction);
l2 = label(1:num_to_fetch);
fprintf('Snap-PCA:   %g\n', etime(time2, time1));

%%
% mds
D = pdist(data, 'euclidean');
D = squareform(D);
[mds_data, stress] = mds(D, 2);
% scatter(mds_data(:,1), mds_data(:,2))
figure;
subplot(2,1,1)
gscatter(mds_data(:,1), mds_data(:,2), label);
title("MDS with IRIS dataset");

mds_data2 = cmdscale(D, 2);

subplot(2,1,2)
gscatter(mds_data2(:, 1), mds_data2(:,2), label);
title("MATLAB MDS with IRIS dataset");


%%
data = ones(10000,100);
t1 = clock;
d = mypca(data, 10);
t2 = clock;
fprintf('PCA:   %g\n', etime(t2, t1));

t1 = clock;
d = gramPca(data, 10);
t2 = clock;
fprintf('Gram:   %g\n', etime(t2, t1));

t1 = clock;
d = snapPca(data, 10, 0.5);
t2 = clock;
fprintf('Snapshot:   %g\n', etime(t2, t1));

t1 = clock;
d = nystrom(data, 10);
t2 = clock;
fprintf('nystrom PCA:   %g\n', etime(t2, t1));

