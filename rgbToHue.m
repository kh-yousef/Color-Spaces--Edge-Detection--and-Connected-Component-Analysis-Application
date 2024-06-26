function hue = rgbToHue(rgb)
    % Input:
    % - rgb: RGB values (in the range [0, 1])

    % Extract individual color components
    r = rgb(1);
    g = rgb(2);
    b = rgb(3);

    % Find the maximum and minimum values
    maxVal = max([r, g, b]);
    minVal = min([r, g, b]);

    % Calculate the difference between max and min
    delta = maxVal - minVal;

    % Initialize hue value
    hue = 0;

    % Calculate hue based on the position of the max color
    if delta ~= 0
        if maxVal == r
            hue = mod((g - b) / delta, 6);
        elseif maxVal == g
            hue = (b - r) / delta + 2;
        elseif maxVal == b
            hue = (r - g) / delta + 4;
        end
    end

    % Convert hue to degrees (0 to 360)
    hue = hue * 60;

    % Ensure hue is non-negative
    if hue < 0
        hue = hue + 360;
    end
end