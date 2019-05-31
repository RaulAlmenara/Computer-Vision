    matricula = "BITD60";
    im = imread("plates/"+matricula+".jpg");
    im = imresize(im, [1080 NaN]);
    im = FindPlate(im);
    im = rgb2gray(im);
    im = histeq(im);
    im=  imbinarize(im,(::1));
    im = bwareaopen(~im, 400);
    imshow(im);
    resultPlate = ReadPlate(im);
    numRate = 0;
    i = 1;
    j = 1;
    matricula = convertStringsToChars(matricula);
    resultPlate = convertStringsToChars(resultPlate);
    while( i < numel(matricula)+1 && j < numel(resultPlate)+1)
        while(resultPlate(j)=='?' & j < numel(resultPlate))
            j = j+1;
        end
        fprintf("%c : %c\n",resultPlate(j),matricula(i));
        if resultPlate(j)==matricula(i)
            numRate = numRate + 1;  
        end
        j = j+1;
        i = i+1;
    end
    fprintf("%s : %s",resultPlate,matricula);
    disp(numRate);
    