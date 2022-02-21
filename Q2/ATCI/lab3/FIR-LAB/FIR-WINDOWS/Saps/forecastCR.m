function [F2,M2,S2,conf] = forecastCR(F1,M1,S1,B,MB,SB,mask,LM,RDis,NVeins)
%
%    PURPOSE:
%
%       Fuzzy Forecasting.
%
%    DESCRIPTION:
%
%       Forecasts fuzzy triples (class, membership, side) of the output 
%       variable from the Behavior Matrices and the Mask.      
%       
%    GLOBAL VARIABLES: 
%
%      repo:  A switch with the following meaning:
%
%             repo = 0:  Do not report the information related to each 
%                        mask computed. 
%
%             repo = 1:  Do report the configuration of the mask 
%                        concatenated with its associated entropy, quality 
%                        and complexity for all the mask evaluated.
%
%      confi:  A variable which computes the confidence associated to a specific 
%              prediction. It has the following meaning:
%
%              confi = 0: Do not compute the confidence measure.
%
%              confi = 1: Compute the confidence by means of the PROXIMITY measure.
%
%              confi = 2: Compute the confidence by means of the SIMILARITY measure.
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
%      def: This parameter can take values in the rank between 1 and 3. It 
%           decides the forecasting method (defuzzification in the classical 
%           fuzzy logic sense).
%
%           def = 1: k-Nearest Neighbor (In this implementation 5NN - five 
%                    nearest neighbor).
%
%           def = 2: Center of Area (COA). Note: "This option is not available yet"
%
%           def = 3: Mean of Maxima (MOM). Note: "This option is not available yet"
%
%      abs-weight: This parameter can take a value between 1 and 3. It 
%                  decides the absolute weight equation used in the 5NN 
%                  method. Therefore, it is needed when DEF=1.
%
%           abs_weight = 1: Equation described in Angela's Thesis (Eqn. 3.22).
%
%           abs_weight = 2: Equation described in [Cellier et al. 1996] 
%                           Budapest paper.
%
%           abs_weight = 3: Equation described in [Cellier et al. 1992] 
%                           Malaga paper.
%
%      The confidence measure is always computed for all of the 3 options.
% 
%      norm_reg: This parameter can take the value 1 or 2. It describes
%                the normalized regeneration function used to compute the 
%                distance in the 5NN method. Therefore, it is needed when 
%                DEF=1.
%
%                norm_reg = 1: Equat: Class_i + Side * (1.0 - Memb_i) 
%                              (see [Cellier et al., 1996] Budapest paper).
%                               Note: "This option is not available yet"
%
%                norm_reg = 2: Equat: p_i = Side_i * B * sqrt(log(Memb_i))+0.5
%                        with $B = (4 * log(0.5))^{-1/2} (see Angela's Thesis).
%
%
%      envol: This parameter computes a qualitative prediction interval from the five 
%             nearest neighbours. It is only used when DEF=1 and works when 
%             a single output is predicted. It is a switch with the following meaning:
%
%             envol = 0:  Do not compute the prediction interval.
%                         
%             envol = 1:  Compute the prediction interval. This feature is necessary 
%                         when it is intended to use SAPS as a fault detection tool.
%                        
%
%      distance: This parameter can take the value 1 or 2. It describes
%                the distance computation formula. Therefore, it is needed when 
%                DEF=1.
%
%                distance = 1: L2 norm (Euclidean distance). 
%
%                distance = 2: Semi-Euclidean distance. 
%                              Note: "This option is not available yet"
%
%
%    ARGUMENTS:
%
%      INPUTS: 
% 
%       f1:  The initial state concatenated from below with the stream of 
%            inputs required for the forecasting process. Values must be 
%            provided for all columns of the utilized mask which do not 
%            calculate outputs, but which do contain input variables. The 
%            output column must contain the initial states in the first 
%            NDEPTH rows concatenated from below with 0 elements. The 
%            dimension of f1 is [(NDEPTH+NSTEP),M], where: 
%
%            NDEPTH = number of rows of the mask - 1.
%            NSTEP  = number of steps to be predicted.
%            M      = number of system variables included. 
%
%       m1: The same structure than the previous matrix with its associated 
%           membership function. The output column may contain the initial 
%           states concatenated with 0.75 elements.
%
%       s1: The same structure than the previous matrix with its associated 
%           side function. The output column may contain the initial states 
%           concatenated with 1 elements.
%
%       B: The class behavior matrix (Class I/O Matrix ordered numerically). 
%          The dimension of B is [(NDATA-NDEPTH),M-INPOUT], where: 
%
%          NDATA = size of the data used to obtain the model. Number of rows
%                  of the raw data matrix.
%          NDEPTH = number of rows of the mask - 1.
%          M-INPOUT = number of mask variables included. Number of non zero 
%                     elements in the mask).
%
%       MB: The membership behavior matrix. Same size than B.
%
%       SB: The side behavior matrix. Same size than B.
%
%       mask: The mask used during the forecasting process.
%
%       CLASS: This parameter is only used when DEF is equal to 1. It contains 
%              the number of classes of each system variable. This parameter is 
%              a row vector that has the size of the number of system variables.
%
%       LM: This parameter is only used when DEF is equal to 2 and 3. It 
%           contains the landmarks. LM is a matrix of dimensions: [2, NCLASS], 
%           where:  
%
%           NCLASS = number of classes of the output variable.  
%
%       RDIS: The relevance of each m-input during the prediction process.
%       Is a matrix including the two RDis formulaes computation
%             RDis = Qvar i
%             RDis = 1 - Qvar i
%
%      OUTPUTS: 
% 
%       f2: Class matrix f1 enhanced from below by the forecast class values.
%           Matrix with the same size than the input parameter f1.
%
%       m2: Membership matrix m1 enhanced from below by the forecast 
%           membership values. Matrix with the same size than f2.
%
%       s2: Side matrix s1 enhanced from below by the forecast side values. 
%           Matrix with the same size than f2.
% 
%           Note: "If ENVOL=1 the previous matrices (f2, m2 and s2) will have two 
%                  more columns. The first one of these new columns contains the interval
%                  upper limit and the second column the lower limit."
%       
%
%       conf: A vector containing the confidence of each forecast. Only when
%             DEF=1 and CONFI=1 or CONFI=2. Column vector with the same number 
%             of rows than the number of data to be predicted.
%
%
%    EXAMPLE: 
%
%      For DEF=1, CONFI=0
%
%          [f2,m2,s2] = forecast(f1,m1,s1,B,MB,SB,mask,CLASS, RDis);
%
%      For DEF=1, CONFI=1 or CONFI=2
%
%          [f2,m2,s2,conf] = forecast(f1,m1,s1,B,MB,SB,mask,CLASS, RDis);
%
%      For DEF=2 or DEF=3
%
%          [f2,m2,s2] = forecast(f1,m1,s1,B,MB,SB,mask,LM, RDis);
%
return
