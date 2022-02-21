%INVSIGM Inverse sigmoid map
% 
% 	W = W*INVSIGM
% 	B = INVSIGM(ARG)
%
% INPUT
%	ARG   Mapping/Dataset
%
% OUTPUT
%	W     Mapping transforming posterior probabilities into distances.
%
% DESCRIPTION
% The inverse sigmoidal transformation to transform a classifier to a
% mapping, transforming posterior probabilities into distances.
%
% SEE ALSO
% MAPPINGS, DATASETS, CLASSC, SIGM

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Sciences, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

% $Id: invsigm.m,v 1.3 2007/03/22 08:54:59 duin Exp $

function w = invsigm(arg)
		prtrace(mfilename);
if nargin == 0

	% Create an empty mapping:
	w = mapping('invsigm','combiner');
	w = setname(w,'Inverse Sigmoidal Mapping');
	
elseif isa(arg,'mapping')

	% If the mapping requested a SIGM transformation (out_conv=1), it
	% is now removed (out_conv=0):
	if arg.out_conv == 1
		w = set(arg,'out_conv',0);
		if arg.size_out == 2
			w.size_out = 1;
			w.labels = w.labels(1,:);
			data.rot = w.data.rot(:,1);
			data.offset = w.data.offset(1);
			data.lablist_in = w.data.lablist_in;
			w.data = data;
		end
	else
		w_s = setname(mapping('invsigm','fixed'),'Inverse Sigmoidal Mapping');
		w = arg*w_s;
	end
	
else
	% The data is really transformed:
	if isdatafile(arg)
		w = addpostproc(arg,invsigm);
	else  % datasets and doubles
		w = log(arg+realmin) - log(1-arg+realmin);
	end
end

return

