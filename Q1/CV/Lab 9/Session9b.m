clear all
close all
clc
inimage = dir('materialLab10\in\*.jpg');
outimage = dir('materialLab10\out\*.jpg');
boxes = [0:256];
for i = 1:length(inimage)
    in{i} = imresize(imread(['materialLab10\in\' inimage(i).name]),0.33);
end

for i = 1:length(outimage)
    out{i} = imresize(imread(['materialLab10\out\' outimage(i).name]),0.33);
end
%%
for i = 1:length(inimage)
    frame = in{i};
    rhistin(i,:) = histcounts(frame(:,:,1),boxes,'Normalization', 'Probability');
    ghistin(i,:) = histcounts(frame(:,:,2),boxes,'Normalization', 'Probability');
    bhistin(i,:) = histcounts(frame(:,:,3),boxes,'Normalization', 'Probability');
    rmeanin(i) = [0:255]*rhistin(i,:)';
    gmeanin(i) = [0:255]*ghistin(i,:)';
    bmeanin(i) = [0:255]*bhistin(i,:)';
end

for i = 1:length(outimage)
    frame = out{i};
    rhistout(i,:) = histcounts(frame(:,:,1),boxes,'Normalization', 'Probability');
    ghistout(i,:) = histcounts(frame(:,:,2),boxes,'Normalization', 'Probability');
    bhistout(i,:) = histcounts(frame(:,:,3),boxes,'Normalization', 'Probability');
    rmeanout(i) = [0:255]*rhistout(i,:)';
    gmeanout(i) = [0:255]*ghistout(i,:)';
    bmeanout(i) = [0:255]*bhistout(i,:)';
end

%% Compute the number of sky pixels
close all;
thr=[110,190];
thg=[110,190];
thb=[220,255];
for i = 1:length(inimage)
    frame = in{i};
    redsky = (frame(:,:,1) > thr(1)) .* (frame(:,:,1) < thr(2));
    greensky = (frame(:,:,2) > thg(1)) .* (frame(:,:,2) < thg(2)); 
    bluesky = frame(:,:,3) > thb(1);
    redgreen = abs(frame(:,:,1)-frame(:,:,2)) < 40;
    bluegreen = frame(:,:,2) < frame(:,:,3);
    skypixels = redsky.*greensky.*bluesky;%.*bluegreen.*redgreen;
    skypixelsnumin(i) = sum(skypixels(:));
end

for i = 1:length(outimage)
    frame = out{i};
    redsky = (frame(:,:,1) > thr(1)) .* (frame(:,:,1) < thr(2));
    greensky = (frame(:,:,2) > thg(1)) .* (frame(:,:,2) < thg(2)); 
    bluesky = frame(:,:,3) > thb(1);
    %redgreen = abs(frame(:,:,1)-frame(:,:,2)) < 40;
    %bluegreen = frame(:,:,2) < frame(:,:,3);
    skypixels = redsky.*greensky.*bluesky;%.*bluegreen.*redgreen;
    skypixelsnumout(i) = sum(skypixels(:));
end

plot(skypixelsnumin)
hold on
plot(skypixelsnumout,'r')
threshold = linspace(1000,10000,9000);
for i = 1:size(threshold,2)
accuracy(i) = (sum(skypixelsnumin<threshold(i)) + sum(skypixelsnumout>threshold(i)))/(size(skypixelsnumin,2)+size(skypixelsnumout,2));
end

figure(2)
plot(threshold, accuracy)