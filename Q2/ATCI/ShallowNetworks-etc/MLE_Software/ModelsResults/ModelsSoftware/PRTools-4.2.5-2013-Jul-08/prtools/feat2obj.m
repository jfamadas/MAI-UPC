%FEAT2OBJ Transform feature images to object images in dataset
%
%   B = FEAT2OBJ(A)
%
% INPUT
%   A     Dataset with object images, possible with multiple bands
%
% OUTPUT
%   B     Dataset with features images
%
% SEE ALSO
% DATASETS, IM2OBJ, IM2FEAT, DATA2IM, OBJ2FEAT

function b = feat2obj(a)

	prtrace(mfilename);

  isdataset(a)
  isfeatim(a);
  im = data2im(a);
  b = im2feat(im);
    
  
