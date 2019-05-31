function [outputArg1] = FindPlate(inputArg1)

    im = rgb2gray(inputArg1);
    im = edge(im, 'sobel');

    im = imdilate(im, strel('diamond', 2));
    im = imfill(im, 'holes');
    im = imerode(im, strel('diamond', 10));

    Iprops=regionprops(im,'BoundingBox','Area', 'Image');
    maxArea = Iprops.Area;
    count = numel(Iprops);
    boundingBox = Iprops.BoundingBox;

    for i=1:count
       if maxArea<Iprops(i).Area
           maxArea=Iprops(i).Area;
           boundingBox=Iprops(i).BoundingBox;
       end
    end    

    im = imcrop(inputArg1, boundingBox);
    outputArg1 = im;
end

