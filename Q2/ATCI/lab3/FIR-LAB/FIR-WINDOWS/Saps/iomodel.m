function [IO,MIO,SIO] = iomodel(X,MEMB,SIDE,MASK)
% 
%    PURPOSE:
%
%        This  function  calculates the fuzzy input/output model from 
%        the qualitative data model, composed by the Class, Membership 
%        and Side value matrices.
%
%
%    DESCRIPTION:
%
%       The mask is applied to the qualitative data matrices converting 
%       the dynamic episodical behavior into a static episodical behavior.
%       This process is repited for the three matrices that compose the
%       qualitative data model.
%        
%
%    GLOBAL VARIABLES: 
%
%
%      miss_data:  A variable with the following meaning: 
%
%                  miss_data = 0:  The raw data matrix does not contain
%                                  missing values.
%
%                  miss_data = i:  The raw data matrix does contain 
%                                  missing values, that are identified 
%                                  with the number i.
%
%
%    ARGUMENTS:
%
%      INPUTS: 
% 
%       Class:  Class value matrix.
%
%       Memb:  Membership value matrix.
%
%       Side:  Side value matrix.
% 
%       Mask: The mask chosen for the prediction process.
%
%
%      OUTPUTS: 
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
%    EXAMPLE: 
%
%      [io,mio,sio] = IOMODEL(Class,Memb,Side,Mask)
%
% 
return
