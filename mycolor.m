function coloredImage = mycolor(inputImage, selectedColor)
    % BW oluşturulur ve bağlı bileşenler bulunur
    BW = inputImage;
    CC = bwconncomp(BW);

    % Seçilen renge göre renk haritası belirlenir
    cmap = colormap(selectedColor);

    % RGB formatta renklendirilmiş görüntü için boş bir matris oluşturulur
    coloredImage = zeros([size(BW), 3]);

    % Renklendirme işlemi yapılır
    for i = 1:CC.NumObjects
        colorIndex = randi(size(cmap, 1));
        pixels = CC.PixelIdxList{i};

        % Renklendirme işlemi
        coloredImage(pixels) = cmap(colorIndex, 1);  % Red
        coloredImage(pixels + numel(BW)) = cmap(colorIndex, 2);  % Green
        coloredImage(pixels + 2*numel(BW)) = cmap(colorIndex, 3);  % Blue
    end

    % Görüntü uint8 formatına dönüştürülür
    coloredImage = uint8(coloredImage * 255);
    close all;  % Tüm açık grafik pencereleri kapatılır
end
