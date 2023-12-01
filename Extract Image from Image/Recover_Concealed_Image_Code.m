function Code
    % Clear, close, and clc
    clear
    clc
    close all

    % Call the function to recover the concealed image
    recoveredImage = Recover_Concealed_Image();
    
end

function recoveredImage = Recover_Concealed_Image()
    [file, path] = uigetfile('*.png', 'Open original image');
    originalFilePath = fullfile(path, file);

    % Read the original image
    originalImage = imread(originalFilePath);

    % Extract the concealed image from the lowest bit
    concealedImage = bitget(originalImage, 1);

    % Convert to uint8 for visualization
    recoveredImage = uint8(concealedImage * 255);

    % Display the recovered image
    figure;
    imshow(recoveredImage);
    title('Recovered Concealed Image');

    % Save the recovered image
    imwrite(recoveredImage, 'recovered_concealed_image.png');
end
