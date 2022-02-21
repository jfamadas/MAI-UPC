close all
clear all
clc

img_color=double(imread('images/dishes/PB070009.jpg')) ;
img_color=imresize(img_color,0.25) ;
img = rgb2gray(uint8(img_color));

%% SNAKE

t = [0:0.5:2*pi]';
x = 75 + 50*cos(t);
y = 56 + 50*sin(t);

figure(1) ;
imagesc(img);  colormap(gray);  axis image;  axis off;  hold on;
plot( [x;x(1,1)], [y;y(1,1)], 'r', 'LineWidth',2 );  hold off;

h = fspecial( 'gaussian', 20, 3 );
f = imfilter( double(img), h, 'symmetric' );
f = f-min(f(:));  f = f/max(f(:));

figure(2) ;
imagesc(f) ; colormap(jet) ; colorbar ;
axis image ; axis off ; 



% DEFAULT PARAMETERS
alpha = 0.1; % Major alfa implica terme d'energia interna de la continuitat domina i per tant el cercle colapsa en un punt
               % Menor alfa fa que s'obri la serp
beta = 0.01; % Major beta implica menys flexiblitat en la corbatura, menor beta...
lambda = -0.08; %
maxstep = 0.4; % Augmentar no percebem efecte, disminuir fa que vaigi mes lent l'algoritme (semblant al learning rate)
kapp = -0.25; % Més kappa implica que la energia interna maxima es mes gran

[px,py] = gradient(-f);
kappa=1/max(abs( [px(:) ; py(:)])) ;
[x1,y1]=snake(x,y,alpha,beta,kapp*kappa,lambda,px,py,maxstep,1,img);

% Original
figure(3);
imagesc(uint8(img_color)); hold on ;
axis image ; axis off ;
plot([x1;x1(1)],[y1;y1(1)],'r','LineWidth',2) ;
hold off ;




%% LEVEL SET - CHAN VESE

[ny,nx]=size(img) ;
[x,y]=meshgrid(1:nx,1:ny) ;
f=sqrt((x-60).^2+(y-40).^2)-5 ;
g=ones(ny,nx) ;

figure(4) ; clf ;
imagesc(img) ; colormap(gray) ; axis equal ; axis tight ; hold on ; 
contour(f,[0 0],'r') ; hold off ; colorbar ;
print -depsc output_images/levelset_input2.eps
figure(5) ;imagesc(f) ; colorbar ;
hold on ; 
contour(f,[0 0],'k') ; hold off ; 
print -depsc output_images/levelset_lsetinput2.eps

img = double(img);

f1=levelset(f,img,500,0,100,200,0.5,0.5,0.05,g,1) ;
%g=ones(size(f)) ;
%f1=levelset(f,img,0,0,10,110,1,1,0.1,g) ;

figure(6) ;imagesc(uint8(img_color)) ; axis equal ; axis tight ; hold on ; 
contour(f1,[0 0],'r', 'LineWidth',2 ) ; hold off ;

print -depsc output_images/levelset_output2.eps
figure(7) ;imagesc(f1,[-100 100]) ; colorbar ;
hold on ; 
contour(f1,[0 0],'k') ; hold off ; 
print -depsc output_images/levelset_lsetoutput2.eps





