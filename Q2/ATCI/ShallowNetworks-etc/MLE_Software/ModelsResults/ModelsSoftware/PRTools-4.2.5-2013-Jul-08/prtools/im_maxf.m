%IM_MAXF Maximum filter of images stored in a dataset (DIP_Image)
%
%	B = IM_MAXF(A,SIZE,SHAPE)
%	B = A*IM_MAXF([],SIZE,SHAPE)
%
% INPUT
%   A        Dataset with object images dataset (possibly multi-band)
%   SIZE     Filter width in pixels, default SIZE = 7
%   SHAPE    String with shape:'rectangular', 'elliptic', 'diamond'
%            Default: elliptic
%
% OUTPUT
%   B        Dataset with filtered images
%
% SEE ALSO
% DATASETS, DATAFILES, DIP_IMAGE, MINF

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands


function b = im_maxf(a,size,shape)

	prtrace(mfilename);
	
	if nargin < 3 | isempty(shape), shape = 'elliptic'; end
	if nargin < 2 | isempty(size), size = 7; end
	
  if nargin < 1 | isempty(a)
    b = mapping(mfilename,'fixed',{size,shape});
    b = setname(b,'Maximum filter');
	elseif isa(a,'dataset') % allows datafiles too
		isobjim(a);
    b = filtim(a,mfilename,{size,shape});
  elseif isa(a,'double') | isa(a,'dip_image') % here we have a single image
		a = 1.0*dip_image(a);
		b = maxf(a,size,shape);
	end
	
return
