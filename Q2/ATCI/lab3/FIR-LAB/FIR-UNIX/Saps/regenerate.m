function [Y] = regenerate(X,M,S,F,T)
% 
%    PURPOSE:
%
%       Fuzzy regeneration. Defuzzification.
%
%
%    DESCRIPTION:
%
%       Converts qualitative triples into quantitative values.Is the inverse 
%       process of fuzzy recoding.
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
%       from:  The "from"-vector. Name (number) of each class.
% 
%       to:  The "to"-vector (or matrix). Landmarks of the fuzzy classes.
% 
%
%      OUTPUTS: 
% 
%       data:  A matrix with quantitative data, obtained from the 
%             regeneration of the qualitative data matrix.
%
%
%    EXAMPLE: 
%
%      [data]=REGENERATE(Class,Memb,Side,from,to) 
%
%      notice that the parameters "from" and "to" correspond, respectively, 
%      to the "to" and "from" parameters of the FRECODE function.
%
%
return
