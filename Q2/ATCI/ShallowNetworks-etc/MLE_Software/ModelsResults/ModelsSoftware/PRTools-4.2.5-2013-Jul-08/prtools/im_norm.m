%IM_NORM Mapping for normalizing images: mean, variance
%
%  B = IM_NORM(A)
%  B = A*IM_NORM
%
% INPUT
%  A       Dataset or datafile
%
% OUTPUT
%  B       Dataset or datafile
%
% DESCRIPTION
% The objects stored as images in the dataset or datafile A are normalised
% w.r.t. their mean (0) and variance (1).

%% SEE ALSO
% MAPPINGS, DATASETS, DATAFILES, IM2OBJ, DATA2IM 

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function b = im_norm(a)

if nargin < 1
	a = [];
end

if isempty(a)
	b = mapping(mfilename,'fixed');
	b = setname(b,'image normalisation');
elseif isa(a,'dataset') % allows datafiles too
	isobjim(a);
	b = filtim(a,mfilename);
elseif isa(a,'double') | isa(a,'dip_image') % here we have a single image
	b = double(a);
	u = mean(b(:));
	v = var(b(:));
	b = (b-u)./sqrt(v);
else
	error('Datatype not supported')
end


