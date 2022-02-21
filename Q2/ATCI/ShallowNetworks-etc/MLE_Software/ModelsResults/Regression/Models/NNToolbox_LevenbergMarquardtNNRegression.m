
function Output = NNToolbox_LevenbergMarquardtNNRegression (traintest,DataSet,Model,Param,TuningSet);

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

if ~strcmp(traintest,'train') && ~strcmp(traintest,'test')
  error('NNToolbox_LevenbergMarquardtNNRegression: String "traintest" invalid');
end;

%%%------------------
%%% Global variables
%%%------------------

NExamples = size(DataSet.Labels,1);
NOutputs = size(DataSet.Labels,2);

%%%----------------------
%%% Train/Test the model
%%%----------------------

v = version('-release');
versionMatlab = v(1:4);

if strcmp(traintest,'train')   %%% Construct the model

  if ~isfield(Param,'NUnits') error('NNToolbox_LevenbergMarquardtRegression: NUnits required'); end;
  NUnits = Param.NUnits;

  if ~isfield(Param,'NIters') error('NNToolbox_LevenbergMarquardtRegression: NIters required'); end;
  NIters = Param.NIters;

  if isfield(Param,'ActFunH')  ActFunH = Param.ActFunH;  else ActFunH = 'tansig'; end;
  if isfield(Param,'Mu')       Mu = Param.Mu;  else Mu = 1.0000e-03; end;
  if isfield(Param,'MuDec')    MuDec = Param.MuDec;  else MuDec = 0.1; end;
  if isfield(Param,'MuInc')    MuInc = Param.MuInc;  else MuInc = 10; end;
  if isfield(Param,'Goal')     Goal = Param.Goal;  else Goal = 0.0001; end;
  if isfield(Param,'Show')     Show = Param.Show;  else Show = 1; end;
  if isfield(Param,'MemReduc') MemReduc = Param.MemReduc;  else MemReduc = 1; end;

  if strcmp(versionMatlab,'2006') == 1
    MinMax = [min(DataSet.Inputs',[],2) max(DataSet.Inputs',[],2)];
    ActFun = {ActFunH 'purelin'};
    InitialNetwork = newff(MinMax,[NUnits NOutputs],ActFun,'trainlm','learngdm','mse');

    InitialNetwork.trainParam.epochs = NIters;
    InitialNetwork.trainParam.goal = Goal;
    InitialNetwork.trainParam.show = Show;
    InitialNetwork.trainParam.time: Inf;
    InitialNetwork.trainParam.max_fail = 10;  %%% Only if training with validation
    %%% Specific parameters for Levenberg-Marquardt
    InitialNetwork.trainParam.min_grad = 1.0000e-10;
    InitialNetwork.trainParam.mu = Mu;         %%% The pseudo-important parameter for learning
    InitialNetwork.trainParam.mu_dec = MuDec;  %%% Multiplicative decrement
    InitialNetwork.trainParam.mu_inc = MuInc;  %%% Multiplicative increment
    InitialNetwork.trainParam.mu_max = 1.0000e+10;
    %%% If mem_reduc is set to 1, then the full Jacobian is computed, no
    %%%    memory reduction is achieved. If mem_reduc is set to 2, then
    %%%    only half of the Jacobian is computed at one time.
    InitialNetwork.trainParam.mem_reduc = MemReduc;

    %%% Training with validation
    if ~isempty(TuningSet)
      ValidationSet.P = TuningSet.Inputs'; %'
      ValidationSet.T = TuningSet.Labels'; %'
    else
      ValidationSet = [];
    end;

    [FinalNetwork, TrainRecord, OutputValues, Errors, Pf, Af] = ...
      train(InitialNetwork,DataSet.Inputs',DataSet.Labels',[],[],ValidationSet,[]);

    Output = FinalNetwork;
  else
    InitialNetwork = feedforwardnet(NUnits,'trainlm');
    InitialNetwork.divideFcn = '';
    for i=1:InitialNetwork.numLayers-1
      InitialNetwork.layers{i}.transferFcn = ActFunH;
    end;
    InitialNetwork.layers{InitialNetwork.numLayers}.transferFcn = 'purelin';

    InitialNetwork.trainParam.epochs = NIters;
    InitialNetwork.trainParam.goal = Goal;
    InitialNetwork.trainParam.show = Show;
    InitialNetwork.trainParam.time: Inf;
    InitialNetwork.trainParam.max_fail = 10;  %%% Only if training with validation
    %%% Specific parameters for Levenberg-Marquardt
    InitialNetwork.trainParam.min_grad = 1.0000e-10;
    InitialNetwork.trainParam.mu = Mu;         %%% The pseudo-important parameter for learning
    InitialNetwork.trainParam.mu_dec = MuDec;  %%% Multiplicative decrement
    InitialNetwork.trainParam.mu_inc = MuInc;  %%% Multiplicative increment
    InitialNetwork.trainParam.mu_max = 1.0000e+10;
    %%% If mem_reduc is set to 1, then the full Jacobian is computed, no
    %%%    memory reduction is achieved. If mem_reduc is set to 2, then
    %%%    only half of the Jacobian is computed at one time.
    InitialNetwork.efficiency.memoryReduction = MemReduc;

    %%% No Training with validation (InitialNetwork.divideFcn = '')
    [FinalNetwork, TrainRecord] = ...
      train(InitialNetwork,DataSet.Inputs',DataSet.Labels');

    Output = FinalNetwork;
  end;

else                           %%% Test the model

  if strcmp(versionMatlab,'2006') == 1
    [OutputValues, Pf, Af, Errors, Mse] = sim(Model,DataSet.Inputs',[],[],DataSet.Labels');
  else
    [OutputValues] = sim(Model,DataSet.Inputs');
    Mse = sum( (OutputValues-DataSet.Labels') .* (OutputValues-DataSet.Labels') ) / numel(DataSet.Labels);
  end;

  Output = Mse;
  if isfield(Param,'ParamResults')
    MLE_SaveOutputs_NNToolbox (OutputValues,Param);
  end;

end;

return;
