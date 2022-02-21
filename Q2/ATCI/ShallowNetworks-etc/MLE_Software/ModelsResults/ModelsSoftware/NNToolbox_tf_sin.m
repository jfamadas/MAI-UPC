function out1 = NNToolbox_tf_sin(in1,in2,in3,in4)
%NNTOOLBOX_TF_SIN Sine transfer function.
%	
%	Syntax
%
%	  A = NNToolbox_tf_sin(N,FP)
%	  dA_dN = NNToolbox_tf_sin('dn',N,A,FP)
%	  INFO = NNToolbox_tf_sin(CODE)
%
%	Description
%
%	  NNTOOLBOX_TF_SIN(N,FP) takes N and optional function parameters,
%	    N - SxQ matrix of net input (column) vectors.
%	    FP - Struct of function parameters (ignored).
%	  and returns A, the SxQ matrix of N's elements squashed into [0, 1].
%	
%   NNTOOLBOX_TF_SIN('dn',N,A,FP) returns SxQ derivative of A w-respect to N.
%   If A or FP are not supplied or are set to [], FP reverts to
%   the default parameters, and A is calculated from N.
%
%   NNTOOLBOX_TF_SIN('name') returns the name of this function.
%   NNTOOLBOX_TF_SIN('output',FP) returns the [min max] output range.
%   NNTOOLBOX_TF_SIN('active',FP) returns the [min max] active input range.
%   NNTOOLBOX_TF_SIN('fullderiv') returns 1 or 0, whether DA_DN is SxSxQ or SxQ.
%   NNTOOLBOX_TF_SIN('fpnames') returns the names of the function parameters.
%   NNTOOLBOX_TF_SIN('fpdefaults') returns the default function parameters.
%
%	Examples
%
%	  Here is code for creating a plot of the NNTOOLBOX_TF_SIN transfer function.
%	
%	    n = -5:0.1:5;
%	    a = NNToolbox_tf_sin(n);
%	    plot(n,a)
%
%	  Here we assign this transfer function to layer i of a network.
%
%     net.layers{i}.transferFcn = 'NNToolbox_tf_sin';
%
%	Algorithm
%
%	    NNToolbox_tf_sin(n) = sin(-n)
%
%	See also SIM, LOGSIG, TANSIG.

fn = mfilename;
boiler_transfer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Name
function n = name
n = 'Sine';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Output range
function r = output_range(fp)
r = [-1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Active input range
function r = active_input_range(fp)
r = [-inf inf];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameter Defaults
function fp = param_defaults(values)
fp = struct;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameter Names
function names = param_names
names = {};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameter Check
function err = param_check(fp)
err = '';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Apply Transfer Function
function a = apply_transfer(n,fp)
a = sin(n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Derivative of Y w/respect to X
function da_dn = derivative(n,a,fp)
da_dn = cos(n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
