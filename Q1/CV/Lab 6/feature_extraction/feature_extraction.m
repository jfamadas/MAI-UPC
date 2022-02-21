function mat_features = feature_extraction(mode, images, vector_class)
% FEATURE_EXTRACTION: Returns the sample feature vectors after applying a
%method of dimensionality reduction (PCA or LDA). 
% Inputs:
% mode, indicates the dimensionality reduction method by means of a string ('PCA', 'PCA95' or 'LDA'). 
% images, matrix containing the sample vectors of size Sample x Variables.
% vector_class, class label vector.
% Outputs:
% mat_features matrix containing the new sample vectors of size Sample x
% Dim, where Dim is the new dimension of the feature vectors.

%% Normalize content of the images and extract the the first row 
mat_images_norm = normc(images);


%% Dimensionality reduction
if  strcmp('PCA', mode)
    %PCA for reducing to 5 dimensions
    dim=5;
    mat_features = apply_pca(mat_images_norm, dim);
elseif strcmp('PCA95', mode)
    %PCA for reducing to the number of dimensions necessary to preserve 95% of
    %the data variance.
    dim=0;
    mat_features = apply_pca(mat_images_norm, dim);      
elseif strcmp('LDA', mode)
    %LDA
    mat_features = lda(mat_images_norm, vector_class);
    % Outputs only two dimensions. First column are the constants a_0
    mat_features = [ones(size(images,1),1) images] * mat_features';
end

end
