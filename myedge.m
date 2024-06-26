function edgeImage = myedge(inputImage, kernelType,Diagonal)
    % Input:
    % - inputImage: Input grayscale image
    % - kernelType: 'prewitt', 'sobel', 'kirsch', or 'scharr'
    % Output:
    % - edgeImage: Resulting edge-detected image

    % Convert the input image to double for processing
    inputImage = double(inputImage);

    % Define the convolution kernels
    switch lower(kernelType)
        case 'prewitt'
            horizontalKernel = [-1 -1 -1; 0 0 0; 1 1 1];
            verticalKernel = [-1 0 1; -1 0 1; -1 0 1];
            if Diagonal
                horizontalKernel = [-1 -1 0; -1 0 1; 0 1 1];
                verticalKernel = [0 1 1; -1 0 1; -1 -1 0];
            end
        case 'sobel'
            horizontalKernel = [-1 -2 -1; 0 0 0; 1 2 1];
            verticalKernel = [-1 0 1; -2 0 2; -1 0 1];
            if Diagonal
                horizontalKernel = [0 -1 -2; 1 0 -1; 2 1 0];
                verticalKernel = [-2 -1 0; -1 0 1; 0 1 2];
            end
        case 'kirsch'
            % Kirsch masks for eight orientations
            kirschMasks = {
                [-3 -3 5; -3 0 5; -3 -3 5],
                [-3 5 5; -3 0 5; -3 -3 -3],
                [5 5 5; -3 0 -3; -3 -3 -3],
                [5 5 -3; 5 0 -3; -3 -3 -3],
                [5 -3 -3; 5 0 -3; 5 -3 -3],
                [-3 -3 -3; 5 0 -3; 5 5 -3],
                [-3 -3 -3; -3 0 -3; 5 5 5],
                [-3 -3 -3; -3 0 5; -3 5 5]
            };
            % Apply all masks and find the maximum response
            response = zeros(size(inputImage));
            for i = 1:numel(kirschMasks)
                response = max(response, conv2(inputImage, kirschMasks{i}, 'same'));
            end
            edgeImage = response;
            return; % Skip further processing
        case 'scharr'
            horizontalKernel = [-3 0 3; -10 0 10; -3 0 3];
            verticalKernel = [-3 -10 -3; 0 0 0; 3 10 3];
            if Diagonal
                horizontalKernel = [0 3 10; -3 0 3; -10 -3 0];
                verticalKernel = [-10 -3 0; -3 0 3; 0 3 10];
            end
        otherwise
            error('Invalid kernel type. Choose ''prewitt'', ''sobel'', ''kirsch'', or ''scharr''.');
    end

    % Convolve the image with the horizontal and vertical kernels
    edgesHorizontal = conv2(inputImage, horizontalKernel, 'same');
    edgesVertical = conv2(inputImage, verticalKernel, 'same');

    % Compute the magnitude of the gradient
    edgeImage = sqrt(edgesHorizontal.^2 + edgesVertical.^2);
    edgeImage=mynormalize(edgeImage);
end
