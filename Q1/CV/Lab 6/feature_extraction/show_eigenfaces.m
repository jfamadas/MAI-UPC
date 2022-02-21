function show_eigenfaces(mat_features)
% SHOW_EIGENFACES compose an image with the first eigenfaces and show it.

% Set the image size
imSz=[36 33];
% Set the number of eigenfaces to show
s=30;

% Build a large image with s eigenfaces
row=[];
I=[];
for i=1:s
    im=reshape(mat_features(:,i),imSz); % reshape the eigenvector into an image
    im=(im-min(min(im)))/(max(max(im))-min(min(im))); % normalize
    row = [row im];    
    if(mod(i,6)==0)
        I=[I;row];
        row=[];
    end
end

% Show and save the large image
imshow(I);
imwrite(I, 'eigenfaces.bmp', 'bmp');

end
