% try different parameters for ransac
% try different point detectors (SIFT MANDATORY, OTHERS:SURF,...)
% play with parameters and understand how they work
% PUSH THE LIMIT OF THE ALGORITHM: blur the image, apply gaussian filter
% UP TO WICH LEVEL OF PROJECTION (OR ROTATION, OR SCALABILITY, ...) WE HAVE TO GO TO MAKE IT NOT ROBUST
% Which parameters are the best for certain situations?
% feel free to find a way to report in the way we want, explore a lot of
% parameters and do it!
% Focus on the idea, not the application
% Example of matlab
% HOG, LBP, SURF, SIFT to start

% Doubt explained in class
% Blob detector e.g snowball , corner detector e.g. corner of a door

clear all; close all; clc;

% Read the image and rotate/resize
im1 = imread('cameraman.tif');
im2 = imresize(im1,0.5);
im3 = imresize(im1,2);
im4 = imrotate(im1,45);
%im5 = imrotate(im1,90);
im5 = imgaussfilt(im1,2);
im6 = im1-100;

ims = {im1,im2,im3,im4,im5, im6};

%Plots
figure;
for i = 1:size(ims,2)
    subplot(2,3,i);
    imshow(ims{i});
    
end


% Find the features and extract them
points_surf = cell(size(ims));
f_surf = cell(size(ims));
vpts_surf = cell(size(ims));
for i = 1:size(ims,2)
    
    %SURF
    points_surf{i} = detectSURFFeatures(ims{i});
    [f_surf{i},vpts_surf{i}] = extractFeatures(ims{i},selectStrongest(points_surf{i},10));
    
    
    %HoG
    %points_hog{i} = 
    
end


% Compute the matches between the image and the original
matchedPoints_im_ori = cell(size(ims));
matchedPoints_im_mod = cell(size(ims));
for i = 1:size(ims,2)
    indexPairs = matchFeatures(f_surf{1},f_surf{i}) ;
    matchedPoints_im_ori{i} = vpts_surf{1}(indexPairs(:,1));
    matchedPoints_im_mod{i} = vpts_surf{i}(indexPairs(:,2));
end


% Show the matched features
figure;
for i = 1:size(ims,2)
    subplot(2,3,i);
    showMatchedFeatures(ims{1},ims{i},matchedPoints_im_ori{i},matchedPoints_im_mod{i},'montage');
    legend('matched points original','matched points modified');
    
end
