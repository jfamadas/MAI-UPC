%ISDATASET Test whether the argument is a dataset
%
% 	N = ISDATASET(A);
%
% INPUT
%		A	 Input argument
%
% OUTPUT
%		N  1/0 if A is/isn't a dataset
%
% DESCRIPTION
% The function ISDATASET test if A is a dataset object.
%
% SEE ALSO
% ISMAPPING, ISDATAIM, ISFEATIM 

% $Id: isdataset.m,v 1.3 2007/03/22 08:54:59 duin Exp $

function n = isdataset(a)
	prtrace(mfilename);
		
	n = isa(a,'dataset') & ~isa(a,'datafile');
	if (nargout == 0) & (n == 0)
		error([newline 'Dataset expected.'])
	end
return;
