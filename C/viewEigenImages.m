function [showArray] = viewEigenImages(data, em1)
    
    eigVec=[];
    for i=1:size(data,1)
        x = data(i,:)';
        imgData = rescale(x .* em1);
        eigVec=[eigVec imgData];
    end    
    imageArray=[];
    rowcount=10;
    colcount=10;
    
    for i=1:size(eigVec,2)
        imgMat = reshape(eigVec(:,i),floor(sqrt(size(eigVec,1))),floor(sqrt(size(eigVec,1))));
        imageArray = [imageArray imgMat];
    end
    showArray = zeros(rowcount*50, colcount*50);
    
    startCounter=1;
    endCounter=50;

    for x=1:50:rowcount*50
        for y=1:50:colcount*50
            showArray(x:(x-1)+50,y:(y-1)+50) = imageArray(:,startCounter:endCounter);
            startCounter = startCounter + 50;
            endCounter   = endCounter + 50;
        end
    end
    %imageArray = reshape(imageArray, 10 * 50,  10 * 50);
end