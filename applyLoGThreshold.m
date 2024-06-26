function binaryImage = applyLoGThreshold(inputImage, n, std, threshold)
    % Generate Laplacian of Gaussian (LoG) kernel
    [x, y] = meshgrid(-(n-1)/2:(n-1)/2, -(n-1)/2:(n-1)/2);
    log_kernel = -1 / (pi * std^4) * (1 - (x.^2 + y.^2) / (2 * std^2)) .* exp(-(x.^2 + y.^2) / (2 * std^2));
    
    % Normalize the kernel
    log_kernel = log_kernel / sum(abs(log_kernel(:)));

    % Apply LoG filter to the input image
    filteredImage = conv2(double(inputImage), log_kernel, 'same');
    
    % Apply threshold
    binaryImage = filteredImage > threshold;
    
    % Display the original and processed images
    figure;
    subplot(1, 3, 1); imshow(inputImage); title('Original Image');
    subplot(1, 3, 2); imshow(filteredImage, []); title('Filtered Image');
    subplot(1, 3, 3); imshow(binaryImage); title('Binary Image with LoG Threshold');
end
