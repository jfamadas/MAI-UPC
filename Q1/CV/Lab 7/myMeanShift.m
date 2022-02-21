function [ imres, num ] = myMeanShift( im, bandwidth, space )



I = im2double(im);
im1d = reshape(I,size(I,1)*size(I,2),3);                                         % Color Features

if (space == true)
    
    % Adds the spatial information 
    Y1 = repmat(1:size(im,2),size(im,1),1);
    Y = Y1(:);
    Y = Y/max(Y(:));
    X = repmat(1:size(im,1),1,size(im,2))';
    X = X/max(X(:));

    im1d = [double(im1d), X, Y];  
    
    
end

% mean_col = repmat(mean(im1d),size(im1d,1),1);
% max_col = repmat(max(im1d),size(im1d,1),1);
% im1d_norm = (im1d - mean_col)./max_col;


[clustCent,point2cluster,clustMembsCell] = MeanShiftCluster(im1d',bandwidth);    % MeanShiftCluster
for i = 1:length(clustMembsCell)                                              % Replace Image Colors With Cluster Centers
im1d(clustMembsCell{i},:) = repmat(clustCent(:,i)',size(clustMembsCell{i},2),1); 
end
imres = reshape(im1d(:,1:3),size(I,1),size(I,2),3);                                         % Segmented Image
num = length(clustMembsCell);

end

