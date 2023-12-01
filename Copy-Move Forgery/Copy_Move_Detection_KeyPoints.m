function Copy_Move_Detection_Binary()
    % Get the file path from the user
    [file, path] = uigetfile('./Dataset/*.tif', 'Open image');
    
    % Check if the user canceled the file selection
    if isequal(file, 0)
        disp('File selection canceled.');
        return;
    end

    % Read the input image using the full file path
    fullFilePath = fullfile(path, file);
    I = imread(fullFilePath);

    % Convert the input image to grayscale
    Igrey = rgb2gray(I);

    % Detect SURF keypoints and extract features
    points = detectSURFFeatures(Igrey);
    [features, validPoints] = extractFeatures(Igrey, points);

    % Set a threshold for matching features
    matchingThreshold = 1; % You can adjust this threshold as needed

    % Find feature matches
    indexPairs = matchFeatures(features, features, 'MatchThreshold', matchingThreshold);

    % Extract the locations of matched keypoints
    matchedPoints1 = validPoints(indexPairs(:, 1));
    matchedPoints2 = validPoints(indexPairs(:, 2));

    % Create a binary image to mark the duplicated keypoints
    binaryImage = zeros(size(Igrey));

    % Mark duplicated keypoints in the binary image
    binaryImage(round(matchedPoints1.Location(:, 2)), round(matchedPoints1.Location(:, 1))) = 1;
    binaryImage(round(matchedPoints2.Location(:, 2)), round(matchedPoints2.Location(:, 1))) = 1;

    % Save the binary image with a modified file name
    [filepath, name, ext] = fileparts(fullFilePath); % Get the path, name, and extension of the input file
    outputFileName = fullfile(filepath, [name, '_duplicated_binary.tif']); % Construct the output file name
    imwrite(binaryImage, outputFileName);
end
