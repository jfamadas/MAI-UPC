%IM_UNIF Uniform filter of images stored in a dataset/datafile
%
%	B = IM_UNIF(A,SX,SY,SHAPE)
%	B = A*IM_UNIF([],SX,SY,SHAPE)
%
% INPUT
%   A     Dataset with object images dataset (possibly multi-band)
%   SX    Desired horizontal width for filter, default SX = 3
%   SY    Desired vertical width for filter, default SY = SX
%   SHAPE Desired shape, 'same' (default) or 'full', see CONV2
%
% OUTPUT
%   B     Dataset/datafile with Gaussian filtered images
%
% SEE ALSO
% DATASETS, DATAFILES, IM_GAUSSF, FILTIM

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands


function b = im_gauss(a,sx,sy,shape)

	prtrace(mfilename);
		
  if nargin < 4 | isempty(shape), shape = 'same'; end
  if nargin < 3 | isempty(sy), sy = []; end
  if nargin < 3, sy = []; end
	if nargin < 2 | isempty(sx), sx = 3; end
  if isempty(sy), sy = sx; end
	
  if (sx<1 | sy<1)
    error('Filter width should be at least 1')
  end
  if nargin < 1 | isempty(a)
    b = mapping(mfilename,'fixed',{sx,sy});
    b = setname(b,'Uniform filter');
	elseif isa(a,'dataset') % allows datafiles too
		isobjim(a);
    b = filtim(a,mfilename,{sx,sy});
  elseif isa(a,'double')  % here we have a single image
    rx = round(sx);
    fx = ones(1,rx)/rx;
    ry = round(sy);
    fy = ones(1,ry)/ry;
    b = conv2(fy,fx,a,shape);
	end
	
return
