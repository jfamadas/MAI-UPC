function [Y,M,S] = recode(X,F,T)
% 
%    PURPOSE:
%
%       Fuzzy recoding. Fuzzification.
%
%
%    DESCRIPTION:
%
%       Converts quantitative values into qualitative triples of the 
%       type (class, membership, side). The class value represents a 
%       coarse discretization of  the original real-valued  variable. 
%       The fuzzy  membership value  denotes the level of confidence 
%       expressed in the class value chosen to represent a particular 
%       quantitative value. Finally, the side value indicates whether 
%       the quantitative value is to the left or to the right of the 
%       peak value of the associated membership function.
% 
%
%    GLOBAL VARIABLES: 
%
%      memb_shape: A variable with the following meaning:
%
%                  memb_shape = 0:  The shape of the membership used to  
%                                   convert quantitative values into  
%                                   qualitative triples is gaussian or 
%                                   bell-shaped.
%
%                  memb_shape = 1:  The  membership is a triangular 
%                                   function.
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
%       data:  A bunch of measured data, stored in a raw data matrix. The
%              size of the matrix is not limited. 
% 
%       from:  The "from"-vector (or matrix). Landmarks of the fuzzy classes.
% 
%       to:  The "to"-vector. Name (number) of each class.
% 
%
%      OUTPUTS: 
% 
%       Class:  Class value matrix.
%
%       Memb:  Membership value matrix.
%
%       Side:  Side value matrix.
% 
%    EXAMPLE: 
%
%      [c,m,s] = RECODE(meas,[0,.1,.4,.75;.1,.4,.75,1],[0:3]) 
%
%      where "meas" is the matrix that contains the quantitative values 
%      measured from the system.
%
return


