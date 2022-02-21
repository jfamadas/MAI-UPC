function [MASK,HM,HR,Q,MHIS] = mexfoptmask(X,MEMB,MCAN,MAXCOMP)
% 
%    This  function calculates the fuzzy optimal mask for a fuzzy raw
%    data model with a given set of input candidates and a given  set
%    of outputs. It also works with raw data that contains missing values. 
% 
%    INPUTS: 
%
%      raw  :  A fuzzy raw data model 
%
%      Memb :  Its fuzzy membership function
%
%      mcan :  A candidate mask.  This contains (-1) for all possible 
%              input candidates, and (+1) for all output variables 
%
%      maxcomp:Largest tolerated complexity of the optimal mask,  set
%              to 0 if no upper limit desired
%
%    GLOBALS: 
%
%      repo :  A switch with the following meaning: 
%                REPO=1:  Print  out entropy and quality of each mask 
%                         considered 
%                REPO=0:  Omit this output (default) 
%
%      qualms: A switch with the following meaning:
%                QUALMS=1:  Use frequencies for the quality measure as
%                           defined by Cellier (default)
%                QUALMS=0:  Use complexity for the quality measure as
%                           defined by Uyttenhove
%
%      miss_data:  A variable with the following meaning: 
%                  MISS_DATA=0: The raw data matrix does not contain missing
%                               values.
%                  MISS_DATA=i: The raw data matrix does contain missing
%                               values, that are identified with the number i.
%
%
%    OUTPUTS: 
%
%      mask :  The optimal mask found by the optimization 
%
%      hm   :  A vector containing the Shannon entropies of the  sub- 
%              optimal masks found for each complexity considered 
%
%      hr   :  The corresponding incertainty reduction vector 
%
%      mhis :  The corresponding masks.   These are concatenated from 
%              the right for increasing complexities 
% 
%    EXAMPLES: 
%
%      1.:  load <haunted 
%           mcan = [-1 -1 0;-1 -1 0;-1 -1 1] 
%           mask = FOPTMASKA(raw,Memb,mcan,5) 
%
%      2.:  repo = 1; 
%           [mask,hm,hr,mhis] = FOPTMASKA(raw,Memb,mcan,0); 
%
% 
return
