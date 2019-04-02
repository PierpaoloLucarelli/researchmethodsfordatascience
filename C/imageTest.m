outDim = 100;
images = read_celeb_img(100);
%%
[pca_data, evecs] = mypca(images, outDim);
% visualize the principal componenets
image_array = zeros(sqrt(size(evecs, 1)), sqrt(size(evecs, 1)), size(evecs, 2));
for i=1:outDim
    image_array(:,:,i) = rescale(reshape(evecs(:,i), sqrt(size(evecs, 1)), sqrt(size(evecs, 1))));
end
figure 
subplot(2, 2, 1)
montage(image_array)
title('Classic PCA') 

outDim = 95;
[pca_data, evecs] = gramPca(images, outDim);
% visualize the principal componenets
image_array = zeros(sqrt(size(evecs, 1)), sqrt(size(evecs, 1)), size(evecs, 2));
for i=1:outDim
    image_array(:,:,i) = rescale(reshape(evecs(:,i), sqrt(size(evecs, 1)), sqrt(size(evecs, 1))));
end

subplot(2, 2, 2)
montage(image_array)
title('Gram PCA') 

outDim = 100;
[pca_data, evecs] = nystrom(images, outDim);
% visualize the principal componenets
image_array = zeros(sqrt(size(evecs, 1)), sqrt(size(evecs, 1)), size(evecs, 2));
for i=1:outDim
    image_array(:,:,i) = rescale(reshape(evecs(:,i), sqrt(size(evecs, 1)), sqrt(size(evecs, 1))));
end
subplot(2, 2, 4)
montage(image_array)
title('Nyström PCA') 
outDim = 60;
[pca_data, evecs] = snapPca(images, outDim, 0.8);
% visualize the principal componenets
image_array = zeros(sqrt(size(evecs, 1)), sqrt(size(evecs, 1)), size(evecs, 2));
for i=1:outDim
    image_array(:,:,i) = rescale(reshape(evecs(:,i), sqrt(size(evecs, 1)), sqrt(size(evecs, 1))));
end
subplot(2, 2, 3)
montage(image_array)
title('Snapshot PCA') 

%%
outDim = 100;
images = read_celeb_img(100);
[pca_data, evecs] = mypca(images, outDim);
faces = viewEigenImages(pca_data, evecs(:,1));
imshow(faces);
%%
images = loadMNISTImages('train-images-idx3-ubyte');
images = images';
labels = loadMNISTLabels('train-labels-idx1-ubyte');
n = 1000;
images = images(1:n, :);
labels = labels(1:n);
[pca_data, evecs] = mypca(images, 2);
figure
subplot(2,2,1)
gscatter(pca_data(:,1), pca_data(:,2), labels);
title('Implemented PCA') 

[pca_data2, evecs2] = gramPca(images, 2);
subplot(2,2,2)
gscatter(pca_data2(:,1), pca_data2(:,2), labels);
title('Gram PCA') 

fraction = 0.5;
[pca_data3, evecs3] = snapPca(images, 2, fraction);
subplot(2,2,3)
num_to_fetch = floor(size(images, 1) * fraction);
l = labels(1:num_to_fetch);
gscatter(pca_data3(:,1), pca_data3(:,2), l);
title('Snap PCA using 50% of the samples') 

[pca_data4, evecs4] = nystrom(images, 2);
subplot(2,2,4)
gscatter(pca_data4(:,1), pca_data4(:,2), labels);
title('Nyström PCA') 

%%
time1   = clock;
[pca_data1, eigVecs1] = mypca(images, 100);
time2   = clock;
fprintf('Covar-PCA:   %g\n', etime(time2, time1));
imageArray = viewEigenImages(images, eigVecs(:,1));
figure
subplot(2,2,1);
imshow(imageArray);
title('Classic PCA') 


time1   = clock;
[pca_data1, eigVecs2] = gramPca(images, 100);
time2   = clock;
fprintf('Covar-PCA:   %g\n', etime(time2, time1));
imageArray = viewEigenImages(images, eigVecs(:,1));
subplot(2,2,2);
imshow(imageArray);
title('Gram PCA') 

time1   = clock;
[pca_data1, eigVecs2] = snapPca(images, 60, 0.8);
time2   = clock;
fprintf('Covar-PCA:   %g\n', etime(time2, time1));
imageArray = viewEigenImages(images, eigVecs(:,1));
subplot(2,2,3);
imshow(imageArray);
title('Snapshot PCA') 

time1   = clock;
[pca_data1, eigVecs2] = nystrom(images, 100);
time2   = clock;
fprintf('Covar-PCA:   %g\n', etime(time2, time1));
imageArray = viewEigenImages(images, eigVecs(:,1));
subplot(2,2,4);
imshow(imageArray);
title('Nyström PCA') 

