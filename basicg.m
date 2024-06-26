function I = basicg(I,t)
    % Eğer I bir RGB görüntüsü ise, gri tonlamalıya çevir
    if size(I, 3) == 3
        I = rgb2gray(I);
    end
    
   
    [rows, cols] = size(I);
    binaryimage = zeros(rows, cols);

    for i = 1:rows
        for j = 1:cols
            if I(i, j) > t
                binaryimage(i, j) = 1; % Beyaz
            else
                binaryimage(i, j) = 0; % Siyah
            end
        end
    end

    % Normalize işlemi yaparak çıktıyı döndür
    I = mynormalize(binaryimage);
end

function normalizedImage = mynormalize(binaryImage)
    % 0-1 aralığına normalize et
    normalizedImage = double(binaryImage) / max(binaryImage(:));
end
