
function Data = MLE_LoadData (ParamGeneral,Param);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Output:
%
%  Data.NExamplesDevelopment --- integer
%  Data.InputsDevelopment    --- matrix
%  Data.LabelsDevelopment    --- vector
%  Data.NExamplesValid       --- integer (optionally)
%  Data.InputsValid          --- matrix  (optionally)
%  Data.LabelsValid          --- vector  (optionally)
%  Data.NExamplesTest        --- integer (optionally)
%  Data.InputsTest           --- matrix  (optionally)
%  Data.LabelsTest           --- vector  (optionally)
%  Data.OriginalSetOfLabels  --- vector  (only if classification)
%  Data.InternalSetOfLabels  --- vector  (only if classification)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Loading data');

if ParamGeneral.ClassificationProblem
  SetOfLabels = [];
end;

%%%=======================================================================

%%%------------------------------------
%%% Validation of mandatory parameters
%%%------------------------------------

MLE_ValidateMandatoryParameters (ParamGeneral,Param);

%%%-----------------------------
%%% Default optional parameters
%%%-----------------------------

if ~isfield(Param,'DataDirectory')
  Param.DataDirectory = '.';
end;

%%%=======================================================================

%%%------------------
%%% Development Data
%%%------------------

fprintf(' (%s/%s)...',Param.DataDirectory,Param.DevelopmentInputsFile);

filename = sprintf('%s/%s',Param.DataDirectory,Param.DevelopmentInputsFile);
Data.InputsDevelopment = load(filename);
LabelsDevelopmentExist = 0;
if isfield(Param,'DevelopmentLabelsFile') && ~isempty(Param.DevelopmentLabelsFile)
  LabelsDevelopmentExist = 1;
  filename = sprintf('%s/%s',Param.DataDirectory,Param.DevelopmentLabelsFile);
  LabelsDevelopment = load(filename);
  Data.LabelsDevelopment = LabelsDevelopment;
  if ParamGeneral.ClassificationProblem
    SetOfLabels = [SetOfLabels; LabelsDevelopment];
  end;
else
  Data.LabelsDevelopment = [];
end;
Data.NExamplesDevelopment = size(Data.InputsDevelopment,1);
NVariablesOrig = size(Data.InputsDevelopment,2);

%%%----------------------------
%%% Validation Data (optional)
%%%----------------------------

LabelsValidExist = 0;
if isfield(Param,'ValidInputsFile') && ~strcmp(Param.ValidInputsFile,'')
  fprintf(' (%s/%s)...',Param.DataDirectory,Param.ValidInputsFile);
  filename = sprintf('%s/%s',Param.DataDirectory,Param.ValidInputsFile);
  Data.InputsValid = load(filename);
  if isfield(Param,'ValidLabelsFile') && ~isempty(Param.ValidLabelsFile)
    LabelsValidExist = 1;
    filename = sprintf('%s/%s',Param.DataDirectory,Param.ValidLabelsFile);
    LabelsValid = load(filename);
    Data.LabelsValid = LabelsValid;
    if ParamGeneral.ClassificationProblem
      SetOfLabels = [SetOfLabels; LabelsValid];
    end;
  else
    Data.LabelsValid = [];
  end;
  Data.NExamplesValid = size(Data.InputsValid,1);
  if NVariablesOrig ~= size(Data.InputsValid,2)
    error('MLE_LoadData: NVariablesOrig ~= size(Data.InputsValid,2)');
  end;
else
  Data.LabelsValid = [];
end;

%%%----------------------
%%% Test Data (optional)
%%%----------------------

LabelsTestExist = 0;
if isfield(Param,'TestInputsFile') && ~strcmp(Param.TestInputsFile,'')
  fprintf(' (%s/%s)...',Param.DataDirectory,Param.TestInputsFile);
  filename = sprintf('%s/%s',Param.DataDirectory,Param.TestInputsFile);
  Data.InputsTest = load(filename);
  if isfield(Param,'TestLabelsFile') && ~isempty(Param.TestLabelsFile)
    LabelsTestExist = 1;
    filename = sprintf('%s/%s',Param.DataDirectory,Param.TestLabelsFile);
    LabelsTest = load(filename);
    Data.LabelsTest = LabelsTest;
    if ParamGeneral.ClassificationProblem
      SetOfLabels = [SetOfLabels; LabelsTest];
    end;
  else
    Data.LabelsTest = [];
  end;
  Data.NExamplesTest = size(Data.InputsTest,1);
  if NVariablesOrig ~= size(Data.InputsTest,2)
    error('MLE_LoadData: NVariablesOrig ~= size(Data.InputsTest,2)');
  end;
else
  Data.LabelsTest = [];
end;

%%%----------------------------
%%% Features Subset (optional)
%%%----------------------------

if isfield(Param,'Features') && ~isempty(Param.Features)
  Features = sort(Param.Features);
  Data.InputsDevelopment = Data.InputsDevelopment(:,Features);
  NVariablesOrig = size(Data.InputsDevelopment,2);
  if isfield(Data,'NExamplesValid')
    Data.InputsValid = Data.InputsValid(:,Features);
  end;
  if isfield(Data,'NExamplesTest')
    Data.InputsTest = Data.InputsTest(:,Features);
  end;
end;

%%%--------------------------
%%% New labels are 1,2,3,...
%%%--------------------------

if ParamGeneral.ClassificationProblem
  SetOfLabels = sort(unique(SetOfLabels));
  Data.OriginalSetOfLabels = sort(unique(SetOfLabels));
  Data.InternalSetOfLabels = [1:size(SetOfLabels,1)]'; %'
  %
  PctLabels = zeros(1,length(Data.OriginalSetOfLabels));
  for i=1:length(SetOfLabels)  %%% size(SetOfLabels,2) == 1
    if LabelsDevelopmentExist == 1
      FoundLabels = find(LabelsDevelopment==SetOfLabels(i));
      Data.LabelsDevelopment(FoundLabels) = i;
      PctLabels(i) = PctLabels(i) + length(FoundLabels);
    end;
    if LabelsValidExist == 1
      FoundLabels = find(LabelsValid==SetOfLabels(i));
      Data.LabelsValid(FoundLabels) = i;
      PctLabels(i) = PctLabels(i) + length(FoundLabels);
    end;
    if LabelsTestExist == 1
      FoundLabels = find(LabelsTest==SetOfLabels(i));
      Data.LabelsTest(FoundLabels) = i;
      PctLabels(i) = PctLabels(i) + length(FoundLabels);
    end;
  end;
  PctLabels = PctLabels / sum(PctLabels);
end;

%%%------

fprintf(' done\n');

fprintf(' Number of variables: %d\n',NVariablesOrig);
if ParamGeneral.ClassificationProblem
  fprintf(' Number of labels: %d\n',length(Data.OriginalSetOfLabels));
  fprintf(' Percentage of examples with every label:');
  for i=1:length(PctLabels), fprintf('  %.2f',100*PctLabels(i)); end; fprintf('\n');
end;
fprintf(' Number of examples in the development file: %d\n',Data.NExamplesDevelopment);
if isfield(Param,'ValidInputsFile') && ~isempty(Param.ValidInputsFile)
  fprintf(' Number of examples in the validation file: %d\n',Data.NExamplesValid);
end;
if isfield(Param,'TestInputsFile') && ~isempty(Param.TestInputsFile)
  fprintf(' Number of examples in the test file: %d\n',Data.NExamplesTest);
end;

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParameters (ParamGeneral,Param);

if ~isfield(Param,'DevelopmentInputsFile')
  error('MLE_LoadData: No development data file');
end;

if ParamGeneral.ClassificationProblem || ParamGeneral.RegressionProblem
  if ~isfield(Param,'DevelopmentLabelsFile')
    error('MLE_LoadData: No development labels file');
  end;
end;

return;

%%%-------------------------------------------------
