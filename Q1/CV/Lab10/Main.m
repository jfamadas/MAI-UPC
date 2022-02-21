%% FILTERS VISUALISATION

close all
clear all
clc

F = makeLMfilters(); % generate the filters 

figure % visualize the filters
for k = 1:size(F,3)
 subplot(8,6,k);
 imagesc(F(:,:,k)); colorbar;
end

%% GET FEATURES FROM A SINGLE IMAGE

close all
clear all
clc

F = makeLMfilters(); % generate the filters 

im = imread('texturesimages\forest\forest_1.jpg');

descriptors = getFeatures(im,F,false);

%% COMPUTE THE DESCRIPTORS OF A DIRECTORY OF IMAGES

close all
clc


dir_buildings = 'texturesimages\buildings\';
dir_forest = 'texturesimages\forest\';
dir_sunset = 'texturesimages\sunset\';

descriptors_buildings = getClassFeatures(dir_buildings,'jpg',false);
descriptors_forest = getClassFeatures(dir_forest,'jpg',false);
descriptors_sunset = getClassFeatures(dir_sunset,'jpg',false);

descriptors_buildings_color = getClassFeatures(dir_buildings,'jpg',true);
descriptors_forest_color = getClassFeatures(dir_forest,'jpg',true);
descriptors_sunset_color = getClassFeatures(dir_sunset,'jpg',true);

%% PLOT 2D AND 3D FEATURES
close all
visualizeFeatures2D(41,25,descriptors_buildings,descriptors_forest,descriptors_sunset);
visualizeFeatures3D(41,25,38,descriptors_buildings,descriptors_forest,descriptors_sunset);

%%
files1=dir(fullfile('texturesimages\buildings\','*.jpg'));
files2=dir(fullfile('texturesimages\forest\','*.jpg'));
files3=dir(fullfile('texturesimages\sunset\','*.jpg'));

files = cat(1,files1,files2,files3);


descriptors_nocolor = cat(1,descriptors_buildings,descriptors_forest,descriptors_sunset);
descriptors_color = cat(1,descriptors_buildings_color,descriptors_forest_color,descriptors_sunset_color);
im = imread('texturesimages\sunset\sunset_13.jpg');

%idx = retrieveKImages(9,im,descriptors,false);
idx = retrieveKImages(9,im,descriptors_color,true);

figure;
subplot(2,5,1)
imshow(im)
title('Image query')

for i = 1:size(idx,2)
    
    im_sim = imread(fullfile(files(idx(i)).folder, files(idx(i)).name));
    subplot(2,5,i+1)
    imshow(im_sim)
    title('Retrived image ordered by similarity')
    
end






