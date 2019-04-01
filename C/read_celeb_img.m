function [data] = read_celeb_img(n)

    i=0;
    files = dir('img_align_celeba/*.jpg');
    data=[];
    for file = files'

        colorImg = imread(strcat('img_align_celeba/',file.name));
        grayImg = imresize(rgb2gray( colorImg ), [50,50]);

        vectorImg = reshape(grayImg,1,[]);
        data = [data; vectorImg];

        if size(data,1) == n
            break
        end

    end
    data = double(data);
end