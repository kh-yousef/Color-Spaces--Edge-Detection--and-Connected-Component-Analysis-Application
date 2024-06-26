function edges = mycanny(image, n,std, lowThreshold, highThreshold)
    % Convert the image to grayscale if it's not already
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % Step 1: Smoothing (Gaussian filter)
    smoothedImage = imgaussfilt(image, std);

    % Sobel operators for computing derivatives
    horizontalKernel = [-1 -2 -1; 0 0 0; 1 2 1];
    verticalKernel = [-1 0 1; -2 0 2; -1 0 1];

    % Step 2: Find derivatives using Sobel operator
    Gx = conv2(smoothedImage, horizontalKernel, 'same');
    Gy = conv2(smoothedImage, verticalKernel, 'same');

    % Step 3: Find the magnitude and orientation of the gradient
    magnitude = sqrt(Gx.^2 + Gy.^2);
    magnitude= (magnitude/max(magnitude(:)))*255;
    orientation = atan2(Gy, Gx) ;

    % Step 4: Non-maximum suppression
    magnitude = nonMaxSuppression(magnitude, orientation);

    % Step 5: Linking and thresholding (Hysteresis)
    edges = thresholdAfterNonMaxSuppression(magnitude, lowThreshold, highThreshold);
 
end

function Z = nonMaxSuppression(magnitude, orientation)
    angle = orientation * 180 / pi;
    angle(angle < 0) = angle(angle < 0) + 180;
    [rows, cols] = size(magnitude);
    G=magnitude;
    Z = zeros(rows, cols);
    
    for i = 2:rows-1
        for j = 2:cols-1
            q = 255;
            r = 255;
    
    
            if (0 <= angle(i, j) < 22.5) || (157.5 <= angle(i, j) <= 180)
                r = G(i, j-1);
                q = G(i, j+1);
    
            elseif (22.5 <= angle(i, j) < 67.5)
                r = G(i-1, j+1);
                q = G(i+1, j-1);
    
            elseif (67.5 <= angle(i, j) < 112.5)
                r = G(i-1, j);
                q = G(i+1, j);
    
            elseif (112.5 <= angle(i, j) < 157.5)
                r = G(i+1, j+1);
                q = G(i-1, j-1);
            end
    
            if (G(i, j) >= q) && (G(i, j) >= r)
                Z(i, j) = G(i, j);
            else
                Z(i, j) = 0;
            end
        end
end
    
    
end


function result_img = thresholdAfterNonMaxSuppression(img, lowThresholdRatio, highThresholdRatio)
    % Define high and low thresholds
    highThreshold = max(img(:)) * highThresholdRatio; % 0.7 as ratio
    lowThreshold = highThreshold * lowThresholdRatio; % 0.3 as ratio

    % Initialize result image
    [M, N] = size(img);
    result_img = zeros(M, N, 'uint8');

    % Apply thresholding
    for i = 1:M
        for j = 1:N
            % Check if the pixel is above the upper threshold
            if img(i, j) >= highThreshold
                result_img(i, j) = 255; % Pixel is accepted as an edge
            % Check if the pixel is above the lower threshold and connected to a pixel above the upper threshold
            elseif img(i, j) >= lowThreshold && any(img(max(1, i-1):min(M, i+1), max(1, j-1):min(N, j+1)) >= highThreshold, 'all')
                result_img(i, j) = 255; % Pixel is accepted as an edge
            end
        end
    end
end
