%%
close all
clear all

Ia = imread('images/im2_ex1.jpg');
Ib = imread('images/im1_ex1.jpg');
Ia = single(rgb2gray(Ia));
Ib = single(rgb2gray(Ib)); 
figure
imshow([Ia Ib],[]) 


[fa, da] = vl_sift(Ia); 
[fb, db] = vl_sift(Ib);

[matches, scores] = vl_ubcmatch(da, db, 1.0);
[matches2, scores2] = vl_ubcmatch(da, db, 1.5);
[matches3, scores3] = vl_ubcmatch(da, db, 2.0);
[matches4, scores4] = vl_ubcmatch(da, db, 4.0);


figure
subplot(2,2,1)
show_matches(Ia, Ib, fa, fb, matches);
title('Th = 1.0')
subplot(2,2,2)
show_matches(Ia, Ib, fa, fb, matches2);
title('Th = 1.5 (Default)')
subplot(2,2,3)
show_matches(Ia, Ib, fa, fb, matches3);
title('Th = 2.0')
subplot(2,2,4)
show_matches(Ia, Ib, fa, fb, matches4);
title('Th = 4.0')


%% Linear Model

d1 = fb(1:2,matches2(2,:))-fa(1:2,matches2(1,:));
p1 = mean(d1,2);
show_matches_linear_model(Ia,Ib,fa,fb,p1)

%% Affine Model

d = fb(1:2,matches2(2,:))-fa(1:2,matches2(1,:)); 
i = size(d, 2); A = zeros(6,6); 
b = zeros(6,1); 
for j = 1:i
    x = fa(1:2,matches2(1,j)); 
    J = [x(1), x(2), 0, 0, 1, 0; 0, 0, x(1), x(2), 0, 1]; 
    A = A + J'*J; b = b + J'*d(1:2,j);
end 
p = inv(A)*b;
figure
show_matches_affine_model(Ia,Ib,fa,fb,p)

%% Linear Model (10 best)
N = 10;
[Y I] = sort(scores2);
matches_sorted = matches2(:,I);
show_matches(Ia,Ib,fa,fb,matches_sorted(:,1:N));

d = fb(1:2,matches_sorted(2,1:N))-fa(1:2,matches_sorted(1,1:N));
p = mean(d,2);
show_matches_linear_model(Ia,Ib,fa,fb,p);

%% Affine Model (10 best)
N = 10;
[Y I] = sort(scores2);
matches_sorted = matches2(:,I);
show_matches(Ia,Ib,fa,fb,matches_sorted(:,1:N));

d = fb(1:2,matches_sorted(2,1:N))-fa(1:2,matches_sorted(1,1:N));
i = size(d, 2);
A = zeros(6,6);
b = zeros(6,1);
for j = 1:i
x = fa(1:2,matches_sorted(1,j));
J = [x(1), x(2), 0, 0, 1, 0; 0, 0, x(1), x(2), 0, 1];
A = A + J'*J;
b = b + J'*d(1:2,j);
end
p = inv(A)*b;
figure
show_matches_affine_model(Ia,Ib,fa,fb,p);

%% Panorama Model

Ia = imread('images/im2_ex1.jpg');
Ib = imread('images/im1_ex1.jpg');
Ia = single(rgb2gray(Ia));
Ib = single(rgb2gray(Ib));
[fa,da] = vl_sift(Ia);
[fb,db] = vl_sift(Ib);
[matches, scores] = vl_ubcmatch(da,db);
numMatches = size(matches,2);
xa = fa(1:2,matches(1,:));
xb = fb(1:2,matches(2,:));


M = 1000;
n_max = 0;

for m = 1:M
   
   % Translation model computation with 10 matches
   subset = vl_colsubset(1:numMatches, 800); 
   d = xb(1:2,subset) - xa(1:2,subset);
   p = mean(d,2);
   
   % Translation model aplication
   xb_ = zeros(size(xb));
   for i=1:numMatches
       xb_(:,i) = xa(:,i) + p;
   end
   
   % Find the 'goodnes' of this model
   n = 0;
   for i=1:numMatches
       e = xb_(:,i) - xb(:,i);
       if (norm(e) < 5)
           n = n + 1; 
       end
   end
   
   % If the current model is better than the best found until now, this is
   % now the best one.
   if (n > n_max)
       n_max = n;
       p_best = p;
   end
   
   
    
end

p = p_best;

% Once the best model is found, lest merge the images

box2 = [1, size(Ia,2), size(Ia,2), 1; 1, 1, size(Ia,1), size(Ia,1)];
box2_ = zeros(2,4);
for i=1:4
box2_(:,i) = box2(:,i) + p;
end

min_x = min(1,min(box2_(1,:)));
min_y = min(1,min(box2_(2,:)));
max_x = max(size(Ib,2),max(box2_(1,:)));
max_y = max(size(Ib,1),max(box2_(2,:)));

ur = min_x:max_x;
vr = min_y:max_y;
[u,v] = meshgrid(ur,vr);
Ib_ = vl_imwbackward(im2double(Ib),u,v);
p_inverse = -p;
u_ = u + p_inverse(1);
v_ = v + p_inverse(2);
Ia_ = vl_imwbackward(im2double(Ia),u_,v_);
Ib_(isnan(Ib_)) = 0;
Ia_(isnan(Ia_)) = 0;
panoramic = max(Ib_, Ia_);

figure
imshow(panoramic,[]);




disp('final')



