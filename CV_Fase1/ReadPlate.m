function [var2] = ReadPlate(im)
    Iprops=regionprops(im,'BoundingBox','Area', 'Image');
    count = numel(Iprops);
    var2='';
    for n=1:count
        bbox = Iprops(n).BoundingBox;
        slice = imcrop(im, bbox);
        max = -1;

        chars = dir('caracteres\*.png');

        for char = chars'
            filename = strcat(pwd, strcat('\caracteres\', char.name));

            xTemp = imread(filename);

            [x, y] = size(slice);
            xTemp = imresize(xTemp, [x, y]);
            xTemp = xTemp(:, :, 1);

            rate = corr2(xTemp, slice);
            if max < rate
                max = rate;
                var1 = char.name;
            end
        end
        if max >= 0.50
            var2 = strcat(var2, var1(1));
        else 
            var2 = strcat(var2, '?');
        end
        
    end
end


