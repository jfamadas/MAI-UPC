function [ descriptors ] = getFeatures( im, F, color )

    
    if color == false
        im = rgb2gray(im);
        descriptors = zeros(1,size(F,3));
    elseif color == true
        descriptors = zeros(1,3*size(F,3));
    end
    
    for i = 1:size(F,3)
        
        filter = F(:,:,i);
        if color == false
            im_filtered = conv2(im,filter);
            descriptors(i) = mean(abs(im_filtered(:)));
        elseif color == true
            im_filtered_r = conv2(im(:,:,1),filter);
            im_filtered_g = conv2(im(:,:,2),filter);
            im_filtered_b = conv2(im(:,:,3),filter);
            descriptors(i) = mean(abs(im_filtered_r(:)));  
            descriptors(i+size(F,3)) = mean(abs(im_filtered_g(:)));  
            descriptors(i+2*size(F,3)) = mean(abs(im_filtered_b(:)));  
        end
        
    end
end

