function [MASK,Q,HR] = OptmaskGen(raw,Memb,mcan,PopSize,ProbCross,ProbMut,MaxGen,SelectedMethod,CrossOverMethod,ParamSelect)
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
%      PopSize: Grandaria de la poblacio
%
%      ProbCross: Probabilitat de Crossober
%
%      ProbMut: Probabilitat de mutacio
%
%      MaxGen: Generacio maxima
%
%      SelectedMethod: Metode de seleccio
%           1:
%           2:
%           3:
%
%      CrossOverMethod: Metode de Crossober
%
%      ParamSelect: Parametre de seleccio. (Nomes pel metode 2)
%
%    GLOBALS: 
%
%      repo :  A switch with the following meaning: 
%                REPO=1:  Print  out entropy and quality of each mask 
%                         considered 
%                REPO=0:  Omit this output (default) 
%
%      miss_data:  A variable with the following meaning: 
%                  MISS_DATA=0: The raw data matrix does not contain missing
%                               values.
%                  MISS_DATA=i: The raw data matrix does contain missing
%                               values, that are identified with the number i.
%
%    OUTPUTS: 
%
%      mask :  The optimal mask found by the optimization 
%
%      Q    :  Qualitat de la mascara
%
%      HR   :  Entropia de Shannos
%
%   Opcional
%
%      hm   :  Containing the Shannon entropies of the optimal mask 
%
%      hr   :  The corresponding incertainty reduction 
% 
return
