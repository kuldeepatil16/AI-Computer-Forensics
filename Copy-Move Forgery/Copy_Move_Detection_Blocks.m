function error = DetectCopyMoveBlocks()
    [file, path] = uigetfile('./Dataset/*.tif', 'Open image');
    file_path = fullfile(path, file); % Create the full file path
    
    I = imread(file_path);
    [file_path_dir, file_name, file_ext] = fileparts(file_path);
    output_file = fullfile(file_path_dir, [file_name, '_Block_duplicated', file_ext]);

    % Define the block size (you can adjust this based on your requirements)
    blockSize = 8;

    % Get the image dimensions
    [rows, cols, ~] = size(I);

    % Initialize a binary mask to identify duplicated blocks
    duplicateMask = false(rows, cols);

    for x = 1:blockSize:cols
        for y = 1:blockSize:rows
            % Extract a block from the image
            block = I(y:min(y+blockSize-1, rows), x:min(x+blockSize-1, cols), :);

            % Search for duplicate blocks
            for i = x+blockSize:cols-blockSize
                for j = y+blockSize:rows-blockSize
                    % Extract a comparison block
                    compBlock = I(j:j+blockSize-1, i:i+blockSize-1, :);

                    % Calculate the mean squared difference (MSD) between blocks
                    MSD = sum(sum(sum((block - compBlock).^2))) / (blockSize^2);

                    % Define a threshold for considering two blocks as duplicates
                    threshold = 500; % You can adjust this threshold

                    if MSD < threshold
                        duplicateMask(y:y+blockSize-1, x:x+blockSize-1) = true;
                    end
                end
            end
        end
    end

    % Create a binary image showing the duplicated pixels
    binaryImage = uint8(duplicateMask) * 255;

    % Save the binary image in the same directory as the original image
    imwrite(binaryImage, output_file);

    error = 0;
end