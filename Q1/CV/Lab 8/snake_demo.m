% SNAKE_DEMO Demo showing the usage of snake 
% CMP Vision Algorithms http://visionbook.felk.cvut.cz
% Examples
% 
% The first example shows how to use snakes to find the inner boundary of the
% heart cavity in a magnetic resonance image 
% The initial position of the snake
% is a small circle located inside the cavity. We will make the snake
% expand until it reaches the bright wall.

clear all
close all
clc

ImageDir='images/';%directory containing the images
addpath('..') ;
cmpviapath('..') ;

if (exist('output_images')~=7)
  mkdir('output_images');
end

img = imread( [ImageDir 'heart.pgm'] );
t = [0:0.5:2*pi]';
x = 70 + 3*cos(t);
y = 90 + 3*sin(t);

% To show the initial position, you can use the following code:

figure(1) ;
imagesc(img);  colormap(gray);  axis image;  axis off;  hold on;
plot( [x;x(1,1)], [y;y(1,1)], 'r', 'LineWidth',2 );  hold off;
exportfig(gcf,'output_images/snake_input1.eps') ;

% The external energy is a smoothed version of the image, normalized for
% convenience 


h = fspecial( 'gaussian', 20, 3 );
f = imfilter( double(img), h, 'symmetric' );
f = f-min(f(:));  f = f/max(f(:));

figure(2) ;
imagesc(f) ; colormap(jet) ; colorbar ;
axis image ; axis off ; 
exportfig(gcf,'output_images/snake_energy1.eps') ;


% The external force is a negative gradient of the energy. 
% We start the snake evolution with alpha=0.1, beta=0.01,
% kappa=0.2, lambda=0.05.
% Note that the normalization constant is incorporated into kappa.


% The final position of the snake is shown 
% We can see that the boundary is well
% recovered. It is instructive to run the snake evolution for different
% values of the parameters and note how the evolution speed and the final
% shape changes. Start with small changes first; big changes make the
% snake behave in unpredictable ways.

% DEFAULT PARAMETERS
alpha = 0.1; % Major alfa implica terme d'energia interna de la continuitat domina i per tant el cercle colapsa en un punt
               % Menor alfa fa que s'obri la serp
beta = 0.01; % Major beta implica menys flexiblitat en la corbatura, menor beta...
lambda = 0.05; %
maxstep = 0.4; % Augmentar no percebem efecte, disminuir fa que vaigi mes lent l'algoritme (semblant al learning rate)
kapp = 0.2; % Més kappa implica que la energia interna maxima es mes gran



[px,py] = gradient(-f);
kappa=1/max(abs( [px(:) ; py(:)])) ;
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep,1,img);

% Original
figure(3);
subplot(3,5,3);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Original')
hold off ;
exportfig(gcf,'output_images/snake_output1.eps') ;

% Big alpha
[x1,y1]=snake(x,y,alpha*2,beta,kapp*kappa,lambda,px,py,maxstep,1,img);
figure(3);
subplot(3,5,6);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big alpha = original*2')

% Small alpha
[x1,y1]=snake(x,y,alpha/4,beta,kapp*kappa,lambda,px,py,maxstep,1,img);
figure(3);
subplot(3,5,7);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small alpha = original/4')

% Big betta
[x1,y1]=snake(x,y,alpha,beta*50,kapp*kappa,lambda,px,py,maxstep,1,img);
figure(3);
subplot(3,5,8);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big betta = original*50')

% Small betta
[x1,y1]=snake(x,y,alpha,beta/500,kapp*kappa,lambda,px,py,maxstep,1,img);
figure(3);
subplot(3,5,9);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small betta = original/50')

% Big kappa
[x1,y1]=snake(x,y,alpha,beta,kapp*2*kappa,lambda,px,py,maxstep,1,img);
figure(3);
subplot(3,5,10);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big kappa = original*2')

% Small kappa
[x1,y1]=snake(x,y,alpha,beta,kapp/2*kappa,lambda,px,py,maxstep,1,img);
figure(3);
subplot(3,5,11);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small kappa = original/2')

% Big lambda
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda*2,px,py,maxstep,1,img);
figure(3);
subplot(3,5,12);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big lambda = original*2')

% Small lambda
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda/2,px,py,maxstep,1,img);
figure(3);
subplot(3,5,13);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small lambda = original/2')

% Big max step
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep*50,1,img);
figure(3);
subplot(3,5,14);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big max step = original*50')

% Small max step
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep/50,1,img);
figure(3);
subplot(3,5,15);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small max step = original/50')




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%
% The second example deals with segmenting an object (a bird) in a color
% image 
% This time we set the
% initial snake position manually around the object using
% a function snakeinit and let the snake
% shrink until it hits the object.


% For convenience, the initial snake position can be saved and reloaded
% later as follows:

% To calculate the external energy 
% the image is first converted into grayscale
% using a particular linear combination of color channels that
% emphasizes the difference between the foreground and the
% background. The result is normalized and small values are suppressed
% using thresholding. Finally, the energy image is smoothed.

% We calculate the external force from the energy and start the minimization
% with parameters alpha=0.1, beta=0.1, kappa=0.3. Note the
% negative value of the balloon force coefficient lambda=-0.05 that
% makes the snake shrink instead of expand (this depends on the clockwise
% orientation of the snake points). 
% The final result is shown 
% Observe that the bird is well
% delineated, although the snake stops a few pixels away from the boundary. 
% This behavior is fairly typical for the simple external energy used. 
% It can be partly eliminated by using less smoothing at the expense of
% robustness. 
 
img=imread([ ImageDir 'bird.png']) ;


load birdxy

figure(4) ;
clf ; imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x;x(1)],[y;y(1)],'r','LineWidth',2) ; 
hold off ;
exportfig(gcf,'output_images/snake_input2.eps') ;

f=double(img) ; f=f(:,:,1)*0.5+f(:,:,2)*0.5-f(:,:,3)*1 ;
f=f-min(f(:)) ; f=f/max(f(:)) ;
f=(f>0.25).*f ;
h=fspecial('gaussian',20,3) ;
f=imfilter(double(f),h,'symmetric') ;

figure(5) ;
imagesc(f) ; colormap(jet) ; colorbar ;
axis image ; axis off ; 
exportfig(gcf,'output_images/snake_energy2.eps') ;

[px,py] = gradient(-f);
kappa=1/(max(max(px(:)),max(py(:)))) ;

alpha = 0.1; % Major alfa implica terme d'energia interna de la continuitat domina i per tant el cercle colapsa en un punt
               % Menor alfa fa que s'obri la serp
beta = 0.1; % Major beta implica menys flexiblitat en la corbatura, menor beta...
lambda = -0.05; % Força del ballon
maxstep = 0.4; % Augmentar no percebem efecte, disminuir fa que vaigi mes lent l'algoritme (semblant al learning rate)
kapp = 0.3; % Més kappa implica que la energia interna maxima es mes gran

[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep,1,f);

% Original
figure(6);
subplot(3,5,3);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Original')
hold off ;
exportfig(gcf,'output_images/snake_output2.eps') ;

% Big alpha
[x1,y1]=snake(x,y,alpha*2,beta,kapp*kappa,lambda,px,py,maxstep,1,f);
figure(6);
subplot(3,5,6);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big alpha = original*2')

% Small alpha
[x1,y1]=snake(x,y,alpha/2,beta,kapp*kappa,lambda,px,py,maxstep,1,f);
figure(6);
subplot(3,5,7);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small alpha = original/2')

% Big betta
[x1,y1]=snake(x,y,alpha,beta*2,kapp*kappa,lambda,px,py,maxstep,1,f);
figure(6);
subplot(3,5,8);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big betta = original*2')

% Small betta
[x1,y1]=snake(x,y,alpha,beta/2,kapp*kappa,lambda,px,py,maxstep,1,f);
figure(6);
subplot(3,5,9);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small betta = original/2')

% Big kappa
[x1,y1]=snake(x,y,alpha,beta,kapp*2*kappa,lambda,px,py,maxstep,1,f);
figure(6);
subplot(3,5,10);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big kappa = original*2')

% Small kappa
[x1,y1]=snake(x,y,alpha,beta,kapp/2*kappa,lambda,px,py,maxstep,1,f);
figure(6);
subplot(3,5,11);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small kappa = original/2')

% Big lambda
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda*2,px,py,maxstep,1,f);
figure(6);
subplot(3,5,12);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big lambda = original*2')

% Small lambda
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda/2,px,py,maxstep,1,f);
figure(6);
subplot(3,5,13);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small lambda = original/2')

% Big max step
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep*2,1,f);
figure(6);
subplot(3,5,14);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Big max step = original*2')

% Small max step
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep/2,1,f);
figure(6);
subplot(3,5,15);
imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title('Small max step = original/50')



%% NOISE

img=imread([ ImageDir 'bird.png']) ;

% Add noise to the image
im = double(img)/255;

r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);
var1 = [var(r(:)) var(g(:)) var(b(:))];
v = mean(var1)/30;

img_gaus = imnoise(img, 'gaussian', 0, v);

density = 0.05;
img_sp = imnoise(img, 'salt & pepper', density);




load birdxy

figure(7) ;
clf ; imagesc(img) ; colormap(gray) ; hold on ;
axis image ; axis off ;
plot([x;x(1)],[y;y(1)],'r','LineWidth',2) ; 
hold off ;
exportfig(gcf,'output_images/snake_input2.eps') ;

% GAUSSIAN NOISE

f=double(img_gaus) ; f=f(:,:,1)*0.5+f(:,:,2)*0.5-f(:,:,3)*1 ;
f=f-min(f(:)) ; f=f/max(f(:)) ;
f=(f>0.25).*f ;
h=fspecial('gaussian',20,3) ;
f=imfilter(double(f),h,'symmetric') ;

figure(8) ;
imagesc(f) ; colormap(jet) ; colorbar ;
axis image ; axis off ; 
exportfig(gcf,'output_images/snake_energy2.eps') ;

[px,py] = gradient(-f);
kappa=1/(max(max(px(:)),max(py(:)))) ;

alpha = 0.2; % Major alfa implica terme d'energia interna de la continuitat domina i per tant el cercle colapsa en un punt
               % Menor alfa fa que s'obri la serp
beta = 0.1; % Major beta implica menys flexiblitat en la corbatura, menor beta...
lambda = -0.03; % Força del ballon
maxstep = 0.4; % Augmentar no percebem efecte, disminuir fa que vaigi mes lent l'algoritme (semblant al learning rate)
kapp = 0.26; % Més kappa implica que la energia interna maxima es mes gran

[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep,1,f);

% Original
figure(9);
imagesc(img) ; hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
title(['Gaussian noise | Variance = ' num2str(v)])
hold off ;
exportfig(gcf,'output_images/snake_output2.eps') ;


% % SALT AND PEPPER NOISE
% 
% 
% f=double(img_sp) ; f=f(:,:,1)*0.5+f(:,:,2)*0.5-f(:,:,3)*1 ;
% f=f-min(f(:)) ; f=f/max(f(:)) ;
% f=(f>0.25).*f ;
% h=fspecial('gaussian',20,3) ;
% f=imfilter(double(f),h,'symmetric') ;
% 
% 
% figure(8) ;
% imagesc(f) ; colormap(jet) ; colorbar ;
% axis image ; axis off ; 
% exportfig(gcf,'output_images/snake_energy2.eps') ;
% 
% [px,py] = gradient(-f);
% kappa=1/(max(max(px(:)),max(py(:)))) ;
% 
% alpha = 0.1; % Major alfa implica terme d'energia interna de la continuitat domina i per tant el cercle colapsa en un punt
%                % Menor alfa fa que s'obri la serp
% beta = 0.1; % Major beta implica menys flexiblitat en la corbatura, menor beta...
% lambda = -0.026; % Força del ballon
% maxstep = 0.4; % Augmentar no percebem efecte, disminuir fa que vaigi mes lent l'algoritme (semblant al learning rate)
% kapp = 0.32; % Més kappa implica que la energia interna maxima es mes gran
% 
% [x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep,1,f);
% 
% % Original
% figure(9);
% imagesc(img) ; hold on ;
% axis image ; axis off ;
% plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
% title(['Salt and Pepper Noise | density = ', num2str(density)])
% hold off ;
% exportfig(gcf,'output_images/snake_output2.eps') ;
%%

%
% Usage: [x,y] = snakeinit()
%
%  Function snakeinit provides a simple interface to initialize
% the snake position. Display the image to be segmented, e.g., by
% imagesc(img), call snakeinit and use the left mouse button
% to choose the snake points in a clockwise direction.  The
% right mouse button picks the last point.

