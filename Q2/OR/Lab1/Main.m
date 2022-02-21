clear all; close all; clc;

im1 = rgb2gray(imread('manhattan.jpg'));
im2 = rgb2gray(imread('sunflower.jpg'));

im1_rotation = imrotate(im1,90);
im2_rotation = imrotate(im2,90);

im1_rotation2 = imrotate(im1,45);
im2_rotation2 = imrotate(im2,45);

im1_small = imresize(im1,0.5);
im2_small = imresize(im2,0.5);

im1_blurry = imgaussfilt(im1,4);
im2_blurry = imgaussfilt(im2,4);

im1_darker = uint8(im1*0.3);
im2_darker = uint8(im2*0.3);

im1_combined = imgaussfilt(imresize(imrotate(im1,90),0.5),2);
im2_combined = imgaussfilt(imresize(imrotate(im2,90),0.5),2);
ims1 = {im1, im1_rotation, im1_rotation2, im1_small, im1_blurry, im1_darker, im1_combined};
ims2 = {im2, im2_rotation, im2_rotation2, im2_small, im2_blurry, im2_darker, im2_combined};

legendv = {'Original', 'Rotation 90', 'Rotation 45', 'Resize', 'Gaussian Filter', 'Contrast', 'Combined'};

% Find the features and extract them
% SURF - skyline
points_surf1 = detectSURFFeatures(im1);
%[f_surf1,vpts_surf1] = extractFeatures(im1,points_surf1);

% SURF - sunflower
points_surf2 = detectSURFFeatures(im2);
%[f_surf2,vpts_surf2] = extractFeatures(im2,points_surf2);

% BRISK - skyline
points_brisk1 = detectBRISKFeatures(im1);
%[f_brisk1,vpts_brisk1] = extractFeatures(im1,points_brisk1);

% BRISK - sunflower
points_brisk2 = detectBRISKFeatures(im2);
%[f_brisk2,vpts_brisk2] = extractFeatures(im2,points_brisk2);


figure;
for i = 1:size(ims1,2)
    subplot(3,3,i);
    imshow(ims1{i});
    
end
figure;
for i = 1:size(ims2,2)
    subplot(3,3,i);
    imshow(ims2{i});
    
end

figure;
subplot(1,2,1)
imshow(im1)
hold on;
plot(selectStrongest(points_surf1,10))

subplot(1,2,2)
imshow(im1)
hold on;
plot(selectStrongest(points_brisk1,10))


figure;
subplot(1,2,1)
imshow(im2)
hold on;
plot(selectStrongest(points_surf2,10))

subplot(1,2,2)
imshow(im2)
hold on;
plot(selectStrongest(points_brisk2,10))




% IMAGE MODIFICATIONS

% Find the features and extract them
clear points_surf1 points_surf2 points_brisk1 points_brisk2; 
for i = 1:size(ims1,2)
    
    tic;
    %SURF - Blob image
    points_surf1{i} = detectSURFFeatures(ims1{i});
    [f_surf1{i},vpts_surf1{i}] = extractFeatures(ims1{i},points_surf1{i});
    points_im1(i,1) = size(vpts_surf1{i},1);
    
    %SURF - Edges image
    points_surf2{i} = detectSURFFeatures(ims2{i});
    [f_surf2{i},vpts_surf2{i}] = extractFeatures(ims2{i},points_surf2{i});
    surftime(i) = toc;
    points_im2(i,1) = size(vpts_surf2{i},1);
    tic;
    %BRISK - Blob image
    points_brisk1{i} = detectBRISKFeatures(ims1{i});
    [f_brisk1{i},vpts_brisk1{i}] = extractFeatures(ims1{i},points_brisk1{i});
    points_im1(i,2) = size(vpts_brisk1{i},1);
    %BRISK - Edges image
    points_brisk2{i} = detectBRISKFeatures(ims2{i});
    [f_brisk2{i},vpts_brisk2{i}] = extractFeatures(ims2{i},points_brisk2{i});
    points_im2(i,2) = size(vpts_brisk2{i},1);
    %[f_brisk2{i},vpts_brisk2{i}] = extractFeatures(ims2{i},selectStrongest(points_brisk2{i},100));
    brisktime(i) = toc;
    
    
end

% Compute the matches between the image and the original
for i = 1:size(ims1,2)
    
    %SURF - Blob image
    indexPairs = matchFeatures(f_surf1{1},f_surf1{i}) ;
    matchedPoints_im_ori_surf1{i} = vpts_surf1{1}(indexPairs(:,1));
    matchedPoints_im_mod_surf1{i} = vpts_surf1{i}(indexPairs(:,2));
    mpointsim1(i,1) = size(matchedPoints_im_mod_surf1{i},1);
    
    %SURF - Edges image
    indexPairs = matchFeatures(f_surf2{1},f_surf2{i}) ;
    matchedPoints_im_ori_surf2{i} = vpts_surf2{1}(indexPairs(:,1));
    matchedPoints_im_mod_surf2{i} = vpts_surf2{i}(indexPairs(:,2));
    mpointsim2(i,1) = size(matchedPoints_im_mod_surf2{i},1);
    
    %BRISK - Blob image
    indexPairs = matchFeatures(f_brisk1{1},f_brisk1{i}) ;
    matchedPoints_im_ori_brisk1{i} = vpts_brisk1{1}(indexPairs(:,1));
    matchedPoints_im_mod_brisk1{i} = vpts_brisk1{i}(indexPairs(:,2));
    mpointsim1(i,2) = size(matchedPoints_im_mod_brisk1{i},1);
    %BRISK - Edges image
    indexPairs = matchFeatures(f_brisk2{1},f_brisk2{i}) ;
    matchedPoints_im_ori_brisk2{i} = vpts_brisk2{1}(indexPairs(:,1));
    matchedPoints_im_mod_brisk2{i} = vpts_brisk2{i}(indexPairs(:,2));
    mpointsim2(i,2) = size(matchedPoints_im_mod_brisk2{i},1);
end

%Show the matched features figure;
figure
suptitle('Skyline SURF');
for i = 2:size(ims1,2)
    
    subplot(2,3,i-1);
    showMatchedFeatures(ims1{1},ims1{i},matchedPoints_im_ori_surf1{i},matchedPoints_im_mod_surf1{i});
    legend(legendv{1},legendv{i});
    
end

figure; 
suptitle('Skyline BRISK');
for i = 2:size(ims1,2)
    
    subplot(2,3,i-1);
    showMatchedFeatures(ims1{1},ims1{i},matchedPoints_im_ori_brisk1{i},matchedPoints_im_mod_brisk1{i});
    legend(legendv{1}, legendv{i});
    
end

figure; 
suptitle('Sunflower SURF')
for i = 2:size(ims1,2)
    
    subplot(2,3,i-1);
    showMatchedFeatures(ims2{1},ims2{i},matchedPoints_im_ori_surf2{i},matchedPoints_im_mod_surf2{i});
    legend(legendv{1}, legendv{i});
    
end

figure; 
suptitle('Sunflower BRISK');
for i = 2:size(ims1,2)
    
    subplot(2,3,i-1);
    showMatchedFeatures(ims2{1},ims2{i},matchedPoints_im_ori_brisk2{i},matchedPoints_im_mod_brisk2{i});
    legend(legendv{1},legendv{i});
    
end


%RANSAC
%%

for i = 1:size(ims1,2)
    outputView = imref2d(size(im1));
    a = matchedPoints_im_mod_surf1{i};
    a = a.Location;
    b = matchedPoints_im_ori_surf1{i};
    b = b.Location;
    [H, corrpoints] = findHomography(a',b');
    inliersim1(i,1) = size(corrpoints,2)/size(matchedPoints_im_mod_surf1{i},1);
      ir = imwarp(ims1{i},projective2d(H'),'OutputView',outputView);
      if (i==6)
          ir = ir*1/0.3;
      end
      for j=1:size(ir,1)
          for k =1:size(ir,2)
              aaa(j,k) = abs(double(ir(j,k))-double(im1(j,k)));
          end
      end
      errim1(i,1) = mean(mean(aaa));

    a = matchedPoints_im_mod_surf2{i};
    a = a.Location;
    b = matchedPoints_im_ori_surf2{i};
    b = b.Location;
    [H, corrpoints] = findHomography(a',b');
    outputView = imref2d(size(im2));
    inliersim2(i,1) = size(corrpoints,2)/size(matchedPoints_im_mod_surf2{i},1);
          ir = imwarp(ims2{i},projective2d(H'),'OutputView',outputView);
      if (i==6)
          ir = ir*1/0.3;
      end
      for j=1:size(ir,1)
          for k =1:size(ir,2)
              aaa(j,k) = abs(double(ir(j,k))-double(im2(j,k)));
          end
      end
      errim2(i,1) = mean(mean(aaa));
%     outputView = imref2d(size(im2));
%     ir = imwarp(ims2{i},projective2d(H'),'OutputView',outputView);
%     figure
%     imshow(ir-im2);
%     figure
%     imshow(ir);

    a = matchedPoints_im_mod_brisk1{i};
    a = a.Location;
    b = matchedPoints_im_ori_brisk1{i};
    b = b.Location;
    [H, corrpoints] = findHomography(a',b');
    outputView = imref2d(size(im1));
    inliersim1(i,2) = size(corrpoints,2)/size(matchedPoints_im_mod_brisk1{i},1);
          ir = imwarp(ims1{i},projective2d(H'),'OutputView',outputView);
      if (i==6)
          ir = ir*1/0.3;
      end
      for j=1:size(ir,1)
          for k =1:size(ir,2)
              aaa(j,k) = abs(double(ir(j,k))-double(im1(j,k)));
          end
      end
      errim1(i,2) = mean(mean(aaa));

    
    a = matchedPoints_im_mod_brisk2{i};
    a = a.Location;
    b = matchedPoints_im_ori_brisk2{i};
    b = b.Location;
    [H, corrpoints] = findHomography(a',b');
    inliersim2(i,2) = size(corrpoints,2)/size(matchedPoints_im_mod_brisk2{i},1);
    outputView = imref2d(size(im2));
              ir = imwarp(ims2{i},projective2d(H'),'OutputView',outputView);
      if (i==6)
          ir = ir*1/0.3;
      end
      for j=1:size(ir,1)
          for k =1:size(ir,2)
              aaa(j,k) = abs(double(ir(j,k))-double(im2(j,k)));
          end
      end
      errim2(i,2) = mean(mean(aaa));
end
figure
suptitle('% of Inliers')
subplot(1,2,1)
c = categorical(legendv);
bar(c, inliersim1);
subplot(1,2,2)
bar(c, inliersim2);

figure
suptitle('Number of matched points')
subplot(1,2,1)
bar(c,mpointsim1);
subplot(1,2,2)
bar(c,mpointsim2);

figure
suptitle('Error for pixel')
subplot(1,2,1)
bar(c,errim1);
subplot(1,2,2);
bar(c,errim2);

figure
suptitle('Number of Detected Feature Points')
subplot(1,2,1)
bar(c,points_im1);
subplot(1,2,2);
bar(c,points_im2);

