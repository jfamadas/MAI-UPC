function [imres] = myKMeans(im, k, space, colour)

% Reshapes the image to have a matrix with 3 columns (RGB)
im1d=double(reshape(im, size(im,1)*size(im,2),3));

if (space == true)
    
    % Adds the spatial information 
    Y1 = repmat(1:size(im,2),size(im,1),1);
    Y = Y1(:);
    X = repmat(1:size(im,1),1,size(im,2))';

    im1d = [double(im1d), X, Y];  
    
end

% Apply K-Means
mean_col = repmat(mean(im1d),size(im1d,1),1);
max_col = repmat(max(im1d),size(im1d,1),1);
im1d_norm = (im1d - mean_col)./max_col;

[idx, C] = kmeans(double(im1d_norm),k);

% Paint the clusters to its mean colour
color_mat = zeros([size(im1d,1),3]);
if (colour == true)
     for i = 1:k
        
         indx = idx == i;
         cluster = im1d(indx,1:3);
         mean_color = repmat(mean(cluster),size(cluster,1),1);
         color_mat(indx,:) = mean_color;
         
         
     end
     imres = reshape(color_mat, size(im,1),size(im,2),3);
     return
     
end

% Transform to an image
im2d=reshape(idx, size(im,1),size(im,2));





% Normalize the values of the pixels
im2d=((double(im2d)-min(min(im2d)))/(max(max(im2d))-min(min(im2d)))*255.0);

% Concatenates the image with the original
imres=cat(3,im2d,im2d,im2d);
end