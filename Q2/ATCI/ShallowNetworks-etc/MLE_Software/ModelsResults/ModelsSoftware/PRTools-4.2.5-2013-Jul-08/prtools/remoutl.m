%REMOUTL Remove outliers from a dataset
%
%  B = REMOUTL(A,T,P)
%  B = A*REMOUTL([],T,P)
%
% INPUT
%  A  Dataset
%  T  Threshold for outlier detection (default 3)
%  P  Fraction of distances passing T (default 0.10)
%
% OUTPUT
%  B  Dataset
%
% DESCRIPTION
% Outliers in A are removed, other objects are copied to B. Class by class
% a distance matrix is constructed and objects are removed that have a fraction
% P of their distances larger than the average distance in the class + T times
% the standard deviation of the within-class distances. This routine works
% also on unlabeled datasets. In partially labeled datasets the unlabeled
% objects are neglected.

function a = remoutl(a,t,p);
if nargin < 3, t = []; end
if nargin < 2, p = []; end
if nargin < 1 | isempty(a)
	a = mapping(mfilename,'fixed',{t,p});
	a = setname(a,'rem_outliers');
	return
end

a = testdatasize(a);

c = getsize(a,3);
if c == 0
	d = sqrt(distm(+a));
	J = findoutd(d,t,p);
	a(J,:) = [];
else
	R = [];
	for j=1:c
		L = findnlab(a,j);
		d = sqrt(distm(seldat(a,j)));
		J = findoutd(d,t,p);
		R = [R;L(J)];
	end
	a(R,:) = [];
end

%FINDOUTD Detect outliers in distance matrix
%
% J = FINDOUTD(D,T,P)
%
% Find the indices of the objects in the dissimilarity representation D
% that have a fraction P (default P = 0.10) of their distances larger than
% mean(D(:)) + T * std(D), default T = 3.

function J = findoutd(d,t,p);

if nargin < 3 | isempty(p), p = 0.10; end
if nargin < 2 | isempty(t), t = 3; end
x = +d;
x = x(:);
L = find(x~=0);
x = x(L);
s = mean(x) + t * std(x);
J = find(sum(+d > s,2) > p*size(d,2));


