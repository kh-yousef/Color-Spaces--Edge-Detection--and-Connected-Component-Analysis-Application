function hueImage = rgbImageToHue(rgbImage)
    % Input:
    % - rgbImage: RGB image (values in the range [0, 255])

    % Convert RGB image to double in the range [0, 1]
    rgbImage = double(rgbImage) / 255;

    % Extract individual color components
    r = rgbImage(:, :, 1);
    g = rgbImage(:, :, 2);
    b = rgbImage(:, :, 3);

    % Find the maximum and minimum values for each pixel
    maxVal = max(rgbImage, [], 3);
    minVal = min(rgbImage, [], 3);

    % Calculate the difference between max and min
    delta = maxVal - minVal;

    % Initialize hue image
    hueImage = zeros(size(rgbImage, 1), size(rgbImage, 2));

    % Find pixels with non-zero delta to avoid division by zero
    nonzeroDelta = delta ~= 0;

    % Calculate hue based on the position of the max color
    hueImage(nonzeroDelta) = mod(60 * (mod((g(nonzeroDelta) - b(nonzeroDelta)) ./ delta(nonzeroDelta), 6)), 360);

    % Ensure hue is non-negative
    hueImage(hueImage < 0) = hueImage(hueImage < 0) + 360;
end
