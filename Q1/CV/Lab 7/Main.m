close all
clear all
clc

im = imread('images/animals.jpg');
%im = imresize(im,0.25);
%im = imresize(im,4);
%im = imrotate(im,30);

%% K-Means
K = 4;

% Basic
imk = myKMeans(im,K,false,true);

% Taking into account the spatial information
disp('K-Means taking into account spatial information')
tic;
imk_space = myKMeans(im,K,true,true);
toc;


imres = cat(2,im,imk,imk_space);
figure;
imshow(uint8(imres))

%% Mean-Shift
for i = 1
    bandwidth  = i/10;
    [imms,num] = myMeanShift(im, bandwidth, false);
    disp('Mean-Shift taking into account spatial information')
    tic;
    [imms_space, num] = myMeanShift(im, bandwidth, true);
    toc;
    imres2 = cat(2,im,uint8(255*imms), uint8(255*imms_space));
    figure;
    imshow(uint8(imres2))
    title(['Bandwith =', num2str(bandwidth)])
    
end
% imres_final = cat(1,imres,imres2);
% 
% figure;
% imshow(uint8(imres_final))
