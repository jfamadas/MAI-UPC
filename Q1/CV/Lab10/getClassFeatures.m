function [ descriptors ] = getClassFeatures( directory, extension, color )

    files=dir(fullfile(directory,['*.', extension]));
    
    F = makeLMfilters(); % generate the filters 
    
    if color == false
        descriptors = zeros(size(files,1),size(F,3));
    elseif color == true
        descriptors = zeros(size(files,1),3*size(F,3));
    end
        
       
    
    for i = 1:size(files,1)
        
        im = imread(fullfile(directory, files(i).name));
        descriptors(i,:) = getFeatures(im, F, color);           
    
                
           
    end
    

end

