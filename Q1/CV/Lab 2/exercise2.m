% - - - - - - 
% MAI CV
% Exercises Lab 2
% Author name: Jordi Riu - Josep Famadas 
% - - - - - - 


%%
%- - - - - - 
%Exercise 2:
%- - - - - - 
close all
clear all

% Load the video
vid = VideoReader('C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 2\images_video\Maldives.mp4');

% Prepares and opens a video writer
vid_write = VideoWriter('C:\Users\Josep Famadas\Desktop\Computer Vision\Lab 2\images_video\Maldives_edited_0.2_2.mp4');
open(vid_write)

frames = [];
for i = 1:1000
    % Load the 'i' frame from the vid
    frame = readFrame(vid);
    
    % Extract the inverse of the edges of the frame
    frame_edge = uint8(1 - edge(rgb2gray(frame),'Canny',0.2,2));
    
    % Combines the edges with the frames so the edges are supperposed in
    % black on the images 
    frame_comb = cat(3, frame(:,:,1).* frame_edge, frame(:,:,2).* frame_edge, frame(:,:,3).* frame_edge);
    
    if i == 1
        frame1 = frame_comb;
    end
    if i == 250
        frame2 = frame_comb;
    end
    if i == 500
        frame3 = frame_comb;
    end
    if i == 750
        frame4 = frame_comb;
    end
        
    writeVideo(vid_write, frame_comb);    
    
end
close(vid_write)

figure
imshow(frame1)
title('FRAME 1','fontsize',18)
figure
imshow(frame2)
title('FRAME 250','fontsize',18)
figure
imshow(frame3)
title('FRAME 500','fontsize',18)
figure
imshow(frame4)
title('FRAME 750','fontsize',18)