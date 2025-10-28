Image Denoising and Puzzle Reconstruction Project
=================================================

Overview
--------

This MATLAB project implements a comprehensive image processing pipeline that performs two main functions:

1.  **Image Denoising**: Removes salt-and-pepper noise from color images using median filtering
    
2.  **Puzzle Reconstruction**: Reassembles a divided image using puzzle piece matching with rotational optimization
    

The project demonstrates advanced image processing techniques including noise reduction, color channel manipulation, block processing, and template matching with rotational invariance.

Features
--------

### 1\. Image Denoising Module

*   **Noise Addition**: Simulates salt-and-pepper noise on input images
    
*   **Channel Separation**: Processes RGB channels independently
    
*   **Median Filtering**: Applies 4×4 median filtering to each color channel
    
*   **Image Reconstruction**: Combines filtered channels back into denoised color image
    

### 2\. Puzzle Reconstruction Module

*   **Block Division**: Divides the main image into 4×4 grid blocks
    
*   **Puzzle Piece Processing**: Loads and converts 16 puzzle pieces to grayscale
    
*   **Rotational Matching**: Tests each puzzle piece at 0°, 90°, 180°, and 270° rotations
    
*   **Optimal Matching**: Uses Mean Squared Error (MSE) for best fit determination
    
*   **Image Reconstruction**: Rebuilds the complete image using optimally positioned and rotated pieces
    

Project Structure
-----------------

text

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   project_4702/  │  ├── project_4702.m          # Main MATLAB script  ├── noisy_colorful_image.jpg # Input color image (to be provided)  ├── a1.jpg to a16.jpg       # Puzzle piece images (to be provided)  └── README.md               # This documentation file   `

Requirements
------------

*   **MATLAB** (R2018a or later recommended)
    
*   **Image Processing Toolbox**
    
*   Input image: noisy\_colorful\_image.jpg
    
*   16 puzzle piece images: a1.jpg to a16.jpg
    

Algorithm Details
-----------------

### Image Denoising Process

1.  **Noise Simulation**: Adds salt-and-pepper noise with 2% density
    
2.  **Channel Separation**: Extracts Red, Green, and Blue components
    
3.  **Filter Application**: Uses medfilt2() with 4×4 neighborhood
    
4.  **Channel Recombination**: Reconstructs denoised color image
    

### Puzzle Solving Algorithm

1.  **Image Division**: Splits main image into 16 equal blocks
    
2.  **Grayscale Conversion**: Converts all blocks and puzzle pieces to grayscale
    
3.  **Multi-scale Matching**: Resizes pieces to match block dimensions
    
4.  **Rotational Analysis**: Tests four rotational orientations (0°, 90°, 180°, 270°)
    
5.  **Error Minimization**: Uses MSE to find optimal piece placement
    
6.  **Reconstruction**: Assembles final image using best matches
    

Key Functions and Techniques
----------------------------

*   imnoise(): For adding salt-and-pepper noise
    
*   medfilt2(): Median filtering for noise removal
    
*   imrotate(): Image rotation for puzzle piece orientation
    
*   immse(): Mean Squared Error calculation for matching
    
*   imresize(): Image resizing for dimension matching
    
*   Block processing with dynamic boundary calculation
    
*   Cell arrays for efficient piece storage and management
    

Usage Instructions
------------------

1.  **Preparation**:
    
    *   Place your input image as noisy\_colorful\_image.jpg
        
    *   Ensure puzzle pieces are named a1.jpg to a16.jpg
        
    *   All images should be in the same directory as the script
        
2.  **Execution**:
    
    *   Run project\_4702.m in MATLAB
        
    *   The script will execute automatically
        
3.  **Output**:
    
    *   **Figure 1**: Comparison of noisy and denoised images
        
    *   **Figure 2**: Reconstructed grayscale puzzle image
        
    *   **Console Output**: Optimal rotations and positions matrices
        

Output Interpretation
---------------------

### Matrices Displayed:

*   **Optimal Rotations Matrix**: Shows rotation angles (0, 90, 180, 270 degrees) for each block position
    
*   **Optimal Positions Matrix**: Indicates which puzzle piece (1-16) belongs in each grid position
    

### Visual Results:

*   **Subplot 1**: Original image with simulated noise
    
*   **Subplot 2**: Denoised image after median filtering
    
*   **Final Figure**: Reconstructed grayscale image from puzzle pieces
    

Customization Options
---------------------

### For Different Image Sizes:

*   Modify blockHeight and blockWidth calculations
    
*   Adjust grid dimensions from 4×4 to other configurations
    

### For Enhanced Performance:

*   Change filter size in medfilt2() (currently \[4 4\])
    
*   Modify noise density in imnoise() (currently 0.02)
    
*   Adjust rotation increments (currently \[0, 90, 180, 270\])
    

### For Different Matching Criteria:

*   Replace immse() with other similarity measures:
    
    *   Structural Similarity Index (SSIM)
        
    *   Normalized Cross-Correlation
        
    *   Histogram comparison methods
        

Technical Notes
---------------

*   **Color Space**: Original processing in RGB, puzzle matching in grayscale
    
*   **Error Metric**: Mean Squared Error for matching quality assessment
    
*   **Rotation Handling**: Uses 'crop' option in imrotate() to maintain dimensions
    
*   **Block Processing**: Handles non-divisible image dimensions gracefully
    
*   **Memory Management**: Uses cell arrays for efficient storage of multiple images
    

Applications
------------

This project demonstrates techniques useful for:

*   Image restoration and noise reduction
    
*   Automated puzzle solving systems
    
*   Document reconstruction
    
*   Forensic image analysis
    
*   Computer vision pattern matching
    
*   Educational image processing demonstrations
    

Limitations and Future Enhancements
-----------------------------------

### Current Limitations:

*   Processing limited to grayscale for puzzle reconstruction
    
*   Fixed 4×4 grid size
    
*   Rotation limited to 90° increments
    
*   MSE may not always capture perceptual similarity
    

### Potential Enhancements:

*   Color-based puzzle piece matching
    
*   Dynamic grid size detection
    
*   Continuous rotation angles
    
*   Multi-resolution matching for efficiency
    
*   GPU acceleration for faster processing
    
*   Additional similarity metrics for improved matching
