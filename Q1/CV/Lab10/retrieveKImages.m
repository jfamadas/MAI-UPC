function [kidx] = retrieveKImages( k , im, descriptors, color)

    F = makeLMfilters(); % generate the filters
    
    descriptor = getFeatures(im,F, color);
    
    idx = knnsearch(descriptors,descriptor,'k',k+1);
    
    kidx = idx(2:end);
         
         
     
        
end

