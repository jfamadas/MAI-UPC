%ISDATAFILE Test whether the argument is a datafile
%
% 	N = ISDATAFILE(A);
%
% INPUT
%		A	 Input argument
%
% OUTPUT
%		N  1/0 if A is/isn't a datafile
%
% DESCRIPTION
% The function ISDATAFILE test if A is a datafile object.
%
% SEE ALSO
% ISMAPPING, ISDATAIM, ISFEATIM 

function n = isdatafile(a)
	prtrace(mfilename);
		
	n = isa(a,'datafile');
	if (nargout == 0) & (n == 0)
		error([newline 'Datafile expected.'])
	end
return;
