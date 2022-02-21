%DIPBIN Run any binary DIPimage command with one input image (DIP_Image)
%
%	B = DIPBIN(A,COMMAND,PAR1,PAR2, ...)
%	B = A*DIPBIN([],COMMAND,PAR1,PAR2, ...)
%
% INPUT
%   A        Dataset or datafiles with binary (0/1) object images
%   COMMAND  String with name of a DIPimage command
%   PAR1     Additional parameters needed for COMMAND
%
% OUTPUT
%   B        Dataset or datafile with results
%
% DESCRIPTION
% This is a general routine to run DIPimage commands on the images stored
% in a dataset or datafile. It assumes that the images are binary (0/1) and
% is thereby appropriate for logical and morphological operations. For grey
% value operations DIPIM should be used. See DIPIMAGE for a list of all
% possible commands. A few suggections are:
%     bdilation            - Binary dilation
%     berosion             - Binary erosion
%     bopening             - Binary opening
%     bclosing             - Binary closing
%     hitmiss              - Hit-Miss operator
%     bskeleton            - Binary skeleton
%     bpropagation         - Binary propagation
%     brmedgeobjs          - Remove edge objects from binary image
%     fillholes            - Fill holes in a binary image
%     hull                 - Generates convex hull of a binary image
%     countneighbours      - Counts the number of neighbours each pixel has
%     bmajority            - Binary majority voting
%     getsinglepixel       - Get single-pixels from skeleton
%     getendpixel          - Get end-pixels from skeleton
%     getlinkpixel         - Get link-pixels from skeleton
%     getbranchpixel       - Get branch-pixels from skeleton
%     label                - Label objects in a binary image
%
% SEE ALSO
% DATASETS, DATAFILES, DIP_IMAGE, DIPIMAGE, DIPIM

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function b = dipbin(a,command,varargin)

	prtrace(mfilename);
	
	if nargin < 2
    error('No DIPimage command supplied')
  end
	
  if isempty(a)
    b = mapping(mfilename,'fixed',{command,varargin{:}});
    b = setname(b,[command '(DIPimage)']);
	elseif isa(a,'dataset') % allows datafiles too
		isobjim(a);
    b = filtim(a,mfilename,{command,varargin{:}});
  elseif isa(a,'double') % here we have a single image
		a = dip_image(a,'bin');
    b = runcommand(command,a,varargin{:});
  elseif isa(a,'dip_image') % here we have a single DIP image
    b = runcommand(command,a,varargin{:});
  else
    error('Illegal call')
	end
	
return

function b = runcommand(command,a,varargin)
    
  try
    b = feval(command,a,varargin{:});
  catch ME
    if strcmp(ME.message, 'Argument # 1: image data type not supported')
      error('Wrong routine for this DIPimage coomand. Try DIPIM.')
    end
    rethrow(ME);
  end
    
return