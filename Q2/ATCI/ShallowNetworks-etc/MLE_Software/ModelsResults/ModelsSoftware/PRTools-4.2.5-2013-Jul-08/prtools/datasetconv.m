%DATASETCONV Convert to dataset if needed
%
%		A = DATASETCONV(A)
%
% If A is not a dataset it is converted to a dataset.
%
% SEE ALSO
% DATASETS, DATASET

function a = datasetconv(a)

% This is just programmed like this for speed, as
% a = dataset(a) will do the same but involves more checking

if ~isdataset(a)
	a = dataset(a);
end
