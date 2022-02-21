
I = vl_impattern('roofs1');
I = single(rgb2gray(I));
imshow(I)

[f,d] = vl_sift(I);

show_keypoints(I,random_selection(f,50));

% Cercle petit implica que el keypoint s'ha trobat quan la imatge no
% s'havia reduit o s'havia reduit poc (detalls)

%%
I = vl_impattern('roofs1');
I = single(rgb2gray(I));

[f,d] = vl_sift(I);

[f2,d2] = vl_sift(I,'PeakThresh', 0.01);
[f3,d4] = vl_sift(I,'PeakThresh', 0.05);
[f4,d3] = vl_sift(I,'PeakThresh', 0.1);

figure
subplot(2,2,1)
show_keypoints(I,f)
title('ORIGINAL')
subplot(2,2,2)
show_keypoints(I,f2)
title('Th = 0.01')
subplot(2,2,3)
show_keypoints(I,f3)
title('Th = 0.05')
subplot(2,2,4)
show_keypoints(I,f4)
title('Th = 0.1')

%%

I = vl_impattern('roofs1');
I = single(rgb2gray(I));



[f,d] = vl_sift(I,'PeakThresh', 0.04, 'EdgeThresh', 10);
[f2,d2] = vl_sift(I,'PeakThresh', 0.04, 'EdgeThresh', 5);
[f3,d3] = vl_sift(I,'PeakThresh', 0.04, 'EdgeThresh', 3);
[f4,d4] = vl_sift(I,'PeakThresh', 0.04, 'EdgeThresh', 2);

figure
subplot(2,2,1)
show_keypoints(I,f)
title('Edge Th = 10')
subplot(2,2,2)
show_keypoints(I,f2)
title('Edge Th = 5')
subplot(2,2,3)
show_keypoints(I,f3)
title('Edge Th = 3')
subplot(2,2,4)
show_keypoints(I,f4)
title('Edge Th = 2')
