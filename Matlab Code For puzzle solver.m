clear all;
close all;
clc;

% Load the Image
image = imread('noisy_colorful_image.jpg'); % Replace with your filename

% Add Salt Noise
noisy_image = imnoise(image, 'salt & pepper', 0.02);

% Split the Channels (Red, Green, Blue)
R = noisy_image(:, :, 1);
G = noisy_image(:, :, 2);
B = noisy_image(:, :, 3);

% Apply Median Filtering to Each Channel
R_filtered = medfilt2(R, [4 4]);
G_filtered = medfilt2(G, [4 4]);
B_filtered = medfilt2(B, [4 4]);

% Combine the Channels Back
denoised_image = cat(3, R_filtered, G_filtered, B_filtered);

% Display the Results
subplot(1, 2, 1);
imshow(noisy_image);
title('Noisy Image');

subplot(1, 2, 2);
imshow(denoised_image);
title('Denoised Image');

% Use denoised image as the color image
colorImage = denoised_image;

% Load the puzzle pieces and convert them to grayscale
for i = 1:16
    Pieces{i} = imread(['a' num2str(i) '.jpg']);
    grayscalePieces{i} = rgb2gray(Pieces{i});
end

% Define block size and ensure integer dimensions
[height, width, ~] = size(colorImage);
blockHeight = round(height / 4);
blockWidth = round(width / 4);

% Divide colorImage into 4x4 blocks and convert to grayscale
blocks = cell(4, 4);
for i = 1:4
    for j = 1:4
        % Calculate exact block boundaries
        rowStart = (i-1) * blockHeight + 1;
        rowEnd = min(i * blockHeight, height);
        colStart = (j-1) * blockWidth + 1;
        colEnd = min(j * blockWidth, width);
        
        % Extract and resize color block to grayscale block of standard size
        colorBlock = colorImage(rowStart:rowEnd, colStart:colEnd, :);
        grayscaleBlock = rgb2gray(colorBlock);
        
        % Resize block to standard size to match puzzle pieces
        blocks{i, j} = imresize(grayscaleBlock, [blockHeight, blockWidth]);
    end
end

% Find optimal positions for each block, including rotation
optimalPositions = zeros(4, 4);
optimalRotations = zeros(4, 4); % Store the optimal rotation for each block

for i = 1:4
    for j = 1:4
        bestMatch = 0;
        bestRotation = 0;
        minError = Inf;
        
        for k = 1:16
            % Test all four rotations for the current puzzle piece
            for rotation = [0, 90, 180, 270]
                % Rotate and resize the puzzle piece to match block size
                rotatedPiece = imrotate(grayscalePieces{k}, rotation, 'crop');
                resizedPiece = imresize(rotatedPiece, [blockHeight, blockWidth]);
                
                % Compute error (using Mean Squared Error)
                error = immse(double(resizedPiece), double(blocks{i, j}));
                if error < minError
                    minError = error;
                    bestMatch = k;
                    bestRotation = rotation;
                end
            end
        end
        
        % Store the best matching piece index and its rotation
        optimalPositions(i, j) = bestMatch;
        optimalRotations(i, j) = bestRotation;
    end
end

% Reconstruct the image using the optimal positions and rotations
reconstructedImage = zeros(height, width);
for i = 1:4
    for j = 1:4
        pieceIndex = optimalPositions(i, j);
        rotation = optimalRotations(i, j);
        
        % Rotate and resize the selected piece to the exact block size
        rotatedPiece = imrotate(grayscalePieces{pieceIndex}, rotation, 'crop');
        
        % Define boundaries in reconstructed image
        rowStart = (i-1) * blockHeight + 1;
        rowEnd = min(i * blockHeight, height);
        colStart = (j-1) * blockWidth + 1;
        colEnd = min(j * blockWidth, width);
        
        % Resize rotated piece to fit exactly within the reconstructed block size
        resizedPiece = imresize(rotatedPiece, [rowEnd - rowStart + 1, colEnd - colStart + 1]);
        
        % Place the resized and rotated piece into the reconstructed image
        reconstructedImage(rowStart:rowEnd, colStart:colEnd) = resizedPiece;
    end
end

% Display the reconstructed image
figure;
imshow(reconstructedImage, []);
title('Reconstructed Grayscale Image with Rotations');

% Display the optimalRotations and optimalPositions matrices
disp('Optimal rotations matrix (in degrees):');
disp(optimalRotations);
disp('Optimal positions matrix:');
disp(optimalPositions);


