function hsi_image = rgb_to_hsi(rgb_image_path)
    % Load RGB image
    rgb_image = imread(rgb_image_path);

    % Check if the image is loaded successfully
    if isempty(rgb_image)
        error(['Error: Unable to read the image at path: ' rgb_image_path]);
    else
        % Convert RGB to HSI
        hsi_image = zeros(size(rgb_image));
        [height, width, ~] = size(rgb_image);

        for y = 1:height
            for x = 1:width
                b = double(rgb_image(y, x, 3)) / 255.0;
                g = double(rgb_image(y, x, 2)) / 255.0;
                r = double(rgb_image(y, x, 1)) / 255.0;

                r_normalized = r;
                g_normalized = g;
                b_normalized = b;

                angle = acos(0.5 * ((r_normalized - g_normalized) + (r_normalized - b_normalized)) / sqrt((r_normalized - g_normalized)^2 + (r_normalized - b_normalized) * (g_normalized - b_normalized)));
                h = angle;

                if b > g
                    h = 2 * pi - h;
                end

                % Fix the min function usage
                min_rgb_normalized = min([r_normalized, g_normalized, b_normalized]);
                s = 1.0 - (3.0 / (r_normalized + g_normalized + b_normalized) * min_rgb_normalized);
                i = (r_normalized + g_normalized + b_normalized) / 3.0;

                hsi_image(y, x, 1) = h;
                hsi_image(y, x, 2) = s;
                hsi_image(y, x, 3) = i;
            end
        end
    end
end