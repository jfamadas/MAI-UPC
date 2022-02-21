%PARZENDC Parzen density based classifier
% 
%  [W,H] = PARZENDC(A)
%  W     = PARZENDC(A,H)
% 
% INPUT
%  A   Dataset
%  H   Smoothing parameters (optional; default: estimated from A for each class)
%
% OUTPUT
%  W   Trained Parzen classifier
%  H   Smoothing parameters, estimated from the data
%
% DESCRIPTION
% For each of the classes in the dataset A, a Parzen density is estimated
% using PARZENML. For each class, a feature normalisation on variance is
% included in the procedure. As a result, the Parzen density estimate uses
% different smoothing parameters for each class and each feature.
%
% If a set of smoothing parameters H is specified, no learning is performed, 
% only the classifier W is produced. H should have the size of [C x K] if 
% A has C classes and K features. If the size of H is [1 x K] or [C x 1], 
% or [1 x 1], then identical values are assumed for all the classes and/or
% features.
%
% The densities for the points of a dataset B can be found by D = B*W.
% D is an [M x C] dataset, if B has M objects.
% 
% EXAMPLES
% See PREX_DENSITY.
%
% SEE ALSO
% DATASETS, MAPPINGS, PARZENC, PARZEN_MAP, PARZENML
 
% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% $Id: parzendc.m,v 1.7 2008/07/03 09:11:44 duin Exp $

function [W,h] = parzendc(a,h)

	prtrace(mfilename);
	
	if nargin < 2
		prwarning(5,'Smoothing parameters not specified, estimated from the data.');
		h = [];
	end

	% No input arguments: return an untrained mapping.
	if nargin == 0 | isempty(a)
		W = mapping(mfilename,h); 
		W = setname(W,'ParzenD');
		return; 
	end

	islabtype(a,'crisp','soft');
	isvaldfile(a,2,2); % at least 2 objects per class, 2 classes
	a = testdatasize(a);
	a = testdatasize(a,'objects');

	[m,k,c] = getsize(a);
	nlab = getnlab(a);

	if ~isempty(h)       % Take user settings for smoothing parameters.
		
		if size(h,1) == 1, h = repmat(h,c,1); end
		if size(h,2) == 1, h = repmat(h,1,k); end
		if any(size(h) ~= [c,k])
			error('Array with smoothing parameters has a wrong size.');
		end

	else   % Estimate smoothing parameters

		% Scale A such that its mean is shifted to the origin and 
		% the variances of all features are scaled to 1. 
		ws = scalem(a,'variance');
		b = a*ws;  

		% SCALE is basically [1/mean(A) 1/STD(A)] based on the properties of SCALEM.
		scale = ws.data.rot;				
		if (size(scale,1) ~= 1) % formally ws.data.rot stores a rotation matrix 
			scale = diag(scale)'; % extract the diagonal if it does,
		end                     % otherwise we already have it

		h = zeros(c,k);
		
		if islabtype(a,'crisp')
			s = sprintf('parzendc: smoothing per class ');
			prwaitbar(c,s);
			for j=1:c
				prwaitbar(c,j,[s int2str(j)]);
				bb = seldat(b,j); 				% BB consists of the j-th class only.
				h(j,:) = repmat(parzenml(bb),1,k)./scale;
			end
			prwaitbar(0);
		elseif islabtype(a,'soft')
			h = parzenml(a);
		end
	end

	W = mapping('parzen_map','trained',{a,h,getprior(a)},getlablist(a),k,c);
	W = setname(W,'ParzenD');
	W = setcost(W,a);

return;
