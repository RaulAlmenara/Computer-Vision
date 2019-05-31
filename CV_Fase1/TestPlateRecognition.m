    matricula = "matricula1B";
    im = imread("plates/"+matricula+".jpg");
    imageRed = im(:, :, 1);
    imageRed = wiener2(imageRed,[5 5]);
    imageGreen = im(:, :, 2);
    imageGreen = wiener2(imageGreen,[5 5]);
    BW1 = imageGreen - imageRed;
    im = imbinarize(BW1);
    im = bwareaopen(im, 5500);
    im = imresize(im, [480 NaN]);
    imshow(im);
    resultPlate = ReadPlate(im);
    disp(resultPlate)
    