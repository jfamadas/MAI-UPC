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
%im5 = imrotate(im1,-45);
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
    [f_surf{i},vpts_surf{i}] = extractFeatures(ims{i},points_surf{i});
    
end

% figure;
% subplot(1,2,1);
% imshow(im1);
% subplot(1,2,2);
% imshow(im7);
% 
% % Find the surf featuers
% points1surf = detectSURFFeatures(im1);
% points2surf = detectSURFFeatures(im7);
% 
% % Extract them
% [f1surf,vpts1surf] = extractFeatures(im1,points1surf);
% [f2surf,vpts2surf] = extractFeatures(im7,points2surf);


% Compute the matches between the image and the original
for i = 1:size(ims,2)
    indexPairs = matchFeatures(f_surf{1},f_surf{i}) ;
    matchedPoints_im_ori = vpts_surf{1}(indexPairs(:,1));
    matchedPoints_im_mod = vpts_surf{i}(indexPairs(:,2));
end

indexPairs = matchFeatures(f1surf,f2surf) ;
matchedPoints1 = vpts1surf(indexPairs(:,1));
matchedPoints2 = vpts2surf(indexPairs(:,2));

figure; showMatchedFeatures(im1,im7,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');