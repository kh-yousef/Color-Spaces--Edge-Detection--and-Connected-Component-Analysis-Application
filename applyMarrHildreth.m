function output = applyMarrHildreth(image1, std, n, thresholdRatio) 
% Convert image to grayscale if it's not already
if size(image1, 3) == 3
image1 = rgb2gray(image1);
end

% Apply Gaussian filter
gaussianKernel = fspecial('gaussian', n, std);
smoothed = imfilter(double(image1), gaussianKernel, 'replicate');

% Laplacian
laplacianKernel = fspecial('laplacian', 0);
laplacian = imfilter(smoothed, laplacianKernel, 'replicate');

% Find zero crossings
threshold = thresholdRatio * max(abs(laplacian(:)));
edges = edge(laplacian, 'zerocross', threshold);

% Output the edge image as uint8 
output = uint8(edges);
end
