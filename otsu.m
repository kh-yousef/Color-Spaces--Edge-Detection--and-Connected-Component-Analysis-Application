function binaryImg_otsu_auto = otsu(image)
    % Görüntüyü double türüne dönüştür ve normalize et
    grayImg = double(image) / 255;

    % Otomatik olarak Otsu'nun yöntemini uygula
    threshold = graythresh(grayImg);

    % Eşik değeri ile binarize et
    binaryImg_otsu_auto = grayImg > threshold;

    
end
