function PCAImagesDim = apply_pca(images, dim)
% APPLY_PCA 
% PCAImagesDim It returns the matrix with reduced attributes.
% Each column is an image
% 

%% PCA
% Use princomp.m to compute:
% 4. To complete:
[PCACoefficients, PCAImages, PCAValues] = pca(images);

%% Show the 30 first eigenfaces
% 5. To complete:
show_eigenfaces(PCACoefficients);

%% Plot the explained variance using 100 dimensions
% 6. To complete:
exp_var = sum(PCAValues(1:100))/sum(PCAValues);
%disp(['Explained variance using 100 dimensions = ', num2str(exp_var)]);

%% Keep the first 'dim' dimensions where dim is given or computed as the
% dimensions necessary to preserve 90% of the data variance.
if dim>0
    PCAImagesDim = PCAImages(:,1:dim);
else
    % Compute the number of dimensions necessary to preserve 90% of the data variance.
    % 7. To complete:
    exp = 0;
    while(exp < 0.95)
        dim = dim+1;
        exp = sum(PCAValues(1:dim))/sum(PCAValues); 
    end
    
    PCAImagesDim = PCAImages(:,1:dim);
    
end
end