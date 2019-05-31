
directory = dir('plates\*.jpg');
numFiles = numel(directory);
disp(numFiles);
result = [0 0 0 0 0 0 0];
for image = directory'
    matricula = strcat(pwd, strcat('\plates\', image.name));
    im = imread(matricula);
    im = imresize(im, [1080 NaN]);
    im = FindPlate(im);
    im = rgb2gray(im);
    im = histeq(im);
    im=  imbinarize(im,0.25);
    im = bwareaopen(~im, 400);
    resultPlate = ReadPlate(im);
    numRate = 0;
    j = 1;
    matricula = convertStringsToChars(image.name);
    resultPlate = convertStringsToChars(resultPlate);
    while(j < numel(resultPlate)+1)
        i = 1;
        while(i < numel(matricula)+1)
            if matricula(i) == resultPlate(j)
                numRate = numRate + 1; 
                matricula(i)='-';
            end
            i = i+1;
        end
        j = j+1;
    end
    fprintf("%s : %s => %d\n",resultPlate,matricula,numRate);
    result(numRate+1) = result(numRate+1) + 1;
end 

for i=1 :numel(result)
     percent=double((result(i)/numFiles)*100);
     fprintf("En %d imatges s'han reconegut %d caracters (%.2f%%)\n",result(i),i-1,percent);
end

