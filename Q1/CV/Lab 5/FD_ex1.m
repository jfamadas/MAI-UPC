% - - - - - - 
% MAI CV
% Exercises Lab 5
% Author name: 
% - - - - - - 
% >> OBJECTIVE: 
% 1) Analize the code
% 2) Understand the function of each part of the code
% 3) Code the missing parts
% 4) Execute the code and check the results
% 5) Comment the experiments and results in a report

% main function
function FD_ex1()

clc; close all; clear;

%% Initialization
% Define Viola & Jones parameters for the first two feature masks
% Following the figure 1 for details!!
L = 80;                            % mask size [px]
d1 = 10; d2 = 15; d3 = 15; d4 = 10; % distances from the border
w1 = 50; w2 = 20; w3 = 20;          % width of the rectangles
h1 = 10; h2 = 20;                   % height of the rectangles

%% Draw the 2 feature masks (just for visualization purpose)
m1 = zeros(L,L);
m2 = zeros(L,L);

% Feature 1
m1(d1+1:d1+h1,d2+1:d2+w1) = 1;
m1(d1+1+h1:d1+2*h1,d2+1:d2+w1) = 2;
figure(1);
imagesc(m1);
title('Rectangluar mask for feature 1');
axis square;
colormap([128 128 128; 0 0 0; 255 255 255]/255);

% Feature 2
m2(d3+1:d3+h2,d4+1:d4+w2) = 1;
m2(d3+1:d3+h2,d4+w2+1:d4+w2+w3) = 2;
m2(d3+1:d3+h2,d4+w2+w3+1:d4+2*w2+w3) = 1;
figure(2);
imagesc(m2);
title('Rectangluar mask for feature 2');
axis square;
colormap([128 128 128; 0 0 0; 255 255 255]/255);


%% Load image, compute Integral Image and visualize it

% Load image 'NASA1.jpg' and convert image from rgb to grayscale 
I = rgb2gray(imread('NASA1.bmp'));


% Compute the Integral Image
S = cumsum(cumsum(double(I),2));

%% Compute features for regions with faces

% (X,Y) coordinates of the top-left corner of windows with face
X = [193 340 444 573 717 834 979 1066 1224 195 445 717 964 1200];
Y = [118 151 112 177 114 177 121 184 127 270 298 279 285 295];
XY_FACE =  [X' Y'];    %[x1 y1; x2 y2 .....]

% Initialize the feature matrix for faces
FEAT_FACE = [];

for i = 1:size(XY_FACE,1)
    
    % current top-left corner coordinates
     x = XY_FACE(i,1); 
     y = XY_FACE(i,2);
    
    % compute area of regions A and B for the first feature
    % HERE WE USE INTEGRAL IMAGE!
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
   
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+h2,x+d4) - S(y+d3,x+d4+w2) + S(y+d3,x+d4);
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+h2,x+d4+w2) - S(y+d3,x+d4+w2+w3) + S(y+d3,x+d4+w2);
    area_E = S(y+d3+h2,x+d4+w2+w3+w2) - S(y+d3+h2,x+d4+w2+w3) - S(y+d3,x+d4+w2+w3+w2) + S(y+d3,x+d4+w2+w3);
    
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    
    % cumulate the computed values
    FEAT_FACE = [FEAT_FACE; [F1 F2]];
    
end

%% Compute features for regions with non-faces

% (X,Y) coordinates of the top-left corner of windows with non-face
X=[ 28 307 574 829 1093 203 350 523 580 800 931 1127 692 1265];
Y=[ 36    28    27    30    46   768   757   742   859   745   912   777   994   820];
XY_NON_FACE = [X' Y'];

% Initialize the feature matrix for non-faces
FEAT_NON_FACE = [];

for i = 1:size(XY_NON_FACE,1)
    
    % current top-left corner coordinates
    x = XY_NON_FACE(i,1); y = XY_NON_FACE(i,2);
    
    % compute area of regions A and B for the first feature
    % HERE WE USE INTEGRAL IMAGE!
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+h2,x+d4) - S(y+d3,x+d4+w2) + S(y+d3,x+d4);
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+h2,x+d4+w2) - S(y+d3,x+d4+w2+w3) + S(y+d3,x+d4+w2);
    area_E = S(y+d3+h2,x+d4+w2+w3+w2) - S(y+d3+h2,x+d4+w2+w3) - S(y+d3,x+d4+w2+w3+w2) + S(y+d3,x+d4+w2+w3);
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    
    % cumulate the computed values
    FEAT_NON_FACE = [FEAT_NON_FACE; [F1 F2]];
    
end

%% Visualize samples in the feature space
figure(3)
hold on
scatter(FEAT_FACE(:,1),FEAT_FACE(:,2),'g');
scatter(FEAT_NON_FACE(:,1),FEAT_NON_FACE(:,2),'r');
xlabel('Feature 1');
ylabel('Feature 2');
title('Feature space');


%% Visualize image with used regions
figure(4);
imshow(I);

% patches with faces
for i = 1:size(XY_FACE,1)
    PATCH = [XY_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'g');
    hold off;
end

% patches without faces
for i = 1:size(XY_NON_FACE,1)
    PATCH = [XY_NON_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'r');
    hold off;
end



%% Part 2:

%% Define the new regions of the test image 

% Load image 'NASA2.bmp' and convert image from rgb to grayscale 
I = rgb2gray(imread('NASA2.bmp'));

% Select regions with FACES and NON-FACES
%figure(), imshow(I);
%[x1, y1] = ginput();

% You could use ginput only once and then copy the coordinates

x1_f = [113;293;465;601;733;896;1056;1192;65;239;418;541;679;802;948;1078;1267;136;361;582;784;1039;1278];
y1_f = [171;175;129;142;148;145;147;145;282;256;223;279;268;238;262;232;211;394;388;391;366;358;372];


x1_nf = [116;272;564;29;730;1101;1312;1033;570;583;284;660;976;1210;1326;110;235;772;886;97;1354];
y1_nf = [28;21;28;81;25;28;51;543;619;471;777;835;778;784;505;501;345;613;339;499;45];

x1 = round([x1_f;x1_nf]);
y1 = round([y1_f;y1_nf]);

% (X,Y) coordinates of the top-left corner of windows with face
XY_TEST = [x1 y1];

  
%% Compute features for these new regions
% Compute the Integral Image
S = cumsum(cumsum(double(I),2));

% Initialize the feature matrix for faces
FEAT_TEST = [];

for i = 1:size(XY_TEST,1)
    
    % current top-left corner coordinates
    x = XY_TEST(i,1);
    y = XY_TEST(i,2);
    
    % compute area of regions A and B for the first feature
    % HERE WE USE INTEGRAL IMAGE!
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+h2,x+d4) - S(y+d3,x+d4+w2) + S(y+d3,x+d4);
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+h2,x+d4+w2) - S(y+d3,x+d4+w2+w3) + S(y+d3,x+d4+w2);
    area_E = S(y+d3+h2,x+d4+w2+w3+w2) - S(y+d3+h2,x+d4+w2+w3) - S(y+d3,x+d4+w2+w3+w2) + S(y+d3,x+d4+w2+w3);
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);

    % cumulate the computed values
    FEAT_TEST = [FEAT_TEST; [F1 F2]];
    
end


%% Train a k-nn classifier and test the new windows
features_train = [FEAT_FACE; FEAT_NON_FACE];
Group = [repmat(1, length(FEAT_FACE), 1); repmat(2, length(FEAT_NON_FACE), 1)];
% Call the function knnclassify
% Train the model
model = fitcknn(features_train, Group);

% Predict test labels
labels = predict(model,FEAT_TEST);

% Separate face, no face
FEAT_TEST_FACE = FEAT_TEST(labels == 1,:);
FEAT_TEST_NON_FACE = FEAT_TEST(labels == 2,:);

XY_TEST_FACE = XY_TEST(labels == 1,:);
XY_TEST_NON_FACE = XY_TEST(labels == 2,:);



%% Visualize samples in the feature space
% First, visualize the training samples:
figure();
hold on
scatter(FEAT_FACE(:,1),FEAT_FACE(:,2),'g');
scatter(FEAT_NON_FACE(:,1),FEAT_NON_FACE(:,2),'r');
xlabel('Feature 1');
ylabel('Feature 2');
title('Feature space');
hold off

% Second, visualize the test samples in two different colors

figure();
hold on
scatter(FEAT_TEST_FACE(:,1),FEAT_TEST_FACE(:,2),'g');
scatter(FEAT_TEST_NON_FACE(:,1),FEAT_TEST_NON_FACE(:,2),'r');
xlabel('Feature 1');
ylabel('Feature 2');
title('Feature space');
hold off

%% Visualize classification results in the test image

% Visualize image 'NASA2.bmp' with used regions
% >> code here <<
figure;
imshow(I);

% patches with faces
for i = 1:size(XY_TEST_FACE,1)
    PATCH = [XY_TEST_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'g');
    hold off;
end

% patches without faces
for i = 1:size(XY_TEST_NON_FACE,1)
    PATCH = [XY_TEST_NON_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'r');
    hold off;
end

%% Visualize ALL samples in the feature space
figure();
hold on
scatter(FEAT_FACE(:,1),FEAT_FACE(:,2),'go');
scatter(FEAT_NON_FACE(:,1),FEAT_NON_FACE(:,2),'ro');
scatter(FEAT_TEST_FACE(:,1),FEAT_TEST_FACE(:,2),'g+');
scatter(FEAT_TEST_NON_FACE(:,1),FEAT_TEST_NON_FACE(:,2),'r+');
xlabel('Feature 1');
ylabel('Feature 2');
title('Feature space');
hold off

end