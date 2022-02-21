function [B,MB,SB] = behavior2(IO,MIO,SIO)
% 
%    PURPOSE:
%
%       This function calculates the fuzzy behavior of an I/O model.
%
%
%    DESCRIPTION:
%
%        The I/O model, composed of three matrices (Class, Membership 
%        and Side) is sorted numerically.
%        
%
%    ARGUMENTS:
%
%      INPUTS: 
%
%       io:  The class input/output matrix. The dimension of io is 
%            [(NDATA-NDEPTH),M-INPOUT], where: 
%
%
%            NDATA = size of the data used to obtain the model. Number 
%                    of rows of the raw data matrix.
%
%            NDEPTH = number of rows of the mask - 1.
%
%            M-INPOUT = number of mask variables included. Number of 
%                       non zero elements in the mask).
%
%
%       mio:  The membership input/output matrix. Same dimension than io.
%
%       sio:  The side input/output matrix. Same dimension than io.
%
%
%      OUTPUTS: 
%
%       B: Class behavior matrix. Same dimension than io.
%
%       MB: Membership behavior matrix. Same dimension than B.
%
%       SB: Side behavior matrix. Same dimension than B.
%
%
%    EXAMPLE: 
%
%
%      [B,MB,SB] = BEHAVIOR(io,mio,sio) 
%
%
return
