%SVMR SVM regression
%
%      W = SVMR(X,NU,KTYPE,KPAR,EP)
%
% INPUT
%   X      Regression dataset
%   NU     Fraction of objects outside the 'data tube'
%   KTYPE  Kernel type (default KTYPE='p', for polynomial)
%   KPAR   Extra parameter for the kernel
%   EP     Epsilon, with of the 'data tube'
%
% OUTPUT
%   W      Support vector regression
%
% DESCRIPTION
% Train an nu-Support Vector Regression on dataset X with parameter NU.
% The kernel is defined by kernel type KTYPE and kernel parameter KPAR.
% For the definitions of these kernels, have a look at proxm.m. 
%
% SEE ALSO
%  LINEARR, PROXM, GPR, SVC


% Copyright: D.M.J. Tax, D.M.J.Tax@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands
function y = svmr(x,nu,ktype,kpar,ep)
if nargin<5
	ep = 0.2;
end
if nargin<4
	kpar = 1;
end
if nargin<3
	ktype = 'p';
end
if nargin<2
	nu = 0.01;
end
if nargin<1 | isempty(x)
	y = mapping(mfilename,{nu,ktype,kpar,ep});
	y = setname(y,'SVM regression');
	return
end

if ~ismapping(nu) %training
	[n,d] = size(x);
	y = gettargets(x);
	% kernel mapping:
	wk = proxm(+x,ktype,kpar);
	K = +(x*wk);
	% setup optimization:
	tol = 1e-6;
	C = 1/(n*nu);
	H = [K -K; -K K];
	f = repmat(ep,2*n,1) - [y; -y];
	A = [];
	b = [];
	Aeq = [ones(1,n) -ones(1,n)];
	beq = 0;
	lb = zeros(2*n,1);
	ub = repmat(C,2*n,1);
	%do the optimization:
	if exist('qld')
		alf = qld(H,f,Aeq,beq,lb,ub,[],1);
	else
		alf = quadprog(H,f,A,b,Aeq,beq,lb,ub);
	end
	% find SV's
	w = alf(1:n)-alf((n+1):end);  % the real weights
	Isv = find(abs(w)>tol);
	Ibnd = find(abs(w(Isv))<C-tol);
	% for the 'real' sv's, we want the classifier output to compute the
	% offset:
	I = Isv(Ibnd);
	out1 = sum(repmat(w',length(Ibnd),1).*K(I,:),2);
	sw = sign(w);
	out = y(I) - out1 - sw(I).*ep;

	% store the useful parameters:
	W.b = mean(out);
	W.wk = proxm(+x(Isv,:),ktype,kpar);
	W.w = w(Isv);

	y = mapping(mfilename,'trained',W,1,d,1);
	y = setname(y,'Linear regression');
else
	% evaluation
	W = getdata(nu);
	[n,d] = size(x);
	Kz = +(x*W.wk);
	out = sum(repmat(W.w',n,1).*Kz,2) + repmat(W.b,n,1);
	y = setdat(x,out);
	
end
