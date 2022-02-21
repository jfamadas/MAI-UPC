clear all
clc
video = VideoReader('materialLab10\Barcelona.mp4');
firstframe = readFrame(video);
boxes = [0:256];
rhist = histcounts(firstframe(:,:,1),boxes,'Normalization', 'Probability');
ghist = histcounts(firstframe(:,:,2),boxes,'Normalization', 'Probability');
bhist = histcounts(firstframe(:,:,2),boxes,'Normalization', 'Probability');
i=1;
difference = [];
shotinit = [1];
shot = firstframe;
backgroundshot = [];
k = 1;

while (hasFrame(video) && i<1000)
    i = i+1;
    frame = readFrame(video);
    rhistNew = histcounts(frame(:,:,1),boxes,'Normalization', 'Probability');
    ghistNew = histcounts(frame(:,:,2),boxes,'Normalization', 'Probability');
    bhistNew = histcounts(frame(:,:,3),boxes,'Normalization', 'Probability');
    difference(i) = norm(rhist-rhistNew) + norm(ghist-ghistNew) + norm(bhist-bhistNew);
    
    figure(1)
    subplot(2,2,1)
    imshow(frame)
    title('Current Frame')
    subplot(2,2,2)
    bar([0:255],rhist)
    title('Previous Red Channel Histogram')
    subplot(2,2,3)
    bar([0:255],rhistNew)
    title('Current Red Channel Histogram')
    subplot(2,2,4)
    plot([1:size(difference,2)],difference)
    title('Features difference by time')
    rhist = rhistNew;
    bhist = bhistNew;
    ghist = ghistNew;
    pause(0.0001)
    
    if (difference(i) > 0.25)
        k = k+1;
        %backgroundshot = cat(4,backgroundshot,mode(shot,4));
        %backgroundshot = cat(4,backgroundshot,mean(shot,4));
        backgroundshot = cat(4,backgroundshot,median(shot,4));
%         figure(2)
%         imshow(uint8(backgroundshot(:,:,:,k-1)));
%         pause
        shot = frame;
        shotinit(k) = i;
    else
        shot = cat(4,shot,frame);
    end
end
clear video
video = VideoReader('materialLab10\Barcelona.mp4');
i = 0;
currentshot = 1;
threshold = 80;
disp('ready');
pause
while (hasFrame(video) && i<1000)
    i = i+1;
    frame = readFrame(video);
    %seleccio del shot
    if (i == shotinit(currentshot+1) && currentshot < size(shotinit,2)-1)
        currentshot = currentshot +1;
    elseif (i == shotinit(currentshot+1) && currentshot == size(shotinit,2)-1)
        break;
    end   
    background = backgroundshot(:,:,:,currentshot);
    foregroundmask = (sum(frame,3) - sum(background,3)) > threshold;
    foreground = repmat(uint8(foregroundmask),1,1,3).*frame;
    figure(3)
    
    subplot(1,3,1)
    imshow(uint8(background));
    subplot(1,3,2)
    imshow(frame);
    subplot(1,3,3)
    imshow(uint8(foreground));
    pause(0.01)
   
end