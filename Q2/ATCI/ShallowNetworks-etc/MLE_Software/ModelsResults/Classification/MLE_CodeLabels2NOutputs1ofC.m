
function LabelsNOutputs = MLE_CodeLabels2NOutputs1ofC (Labels,MinValue);

%%%----------------------------------------------------------------
%%% Creates labels following the 1-of-C schema from numeric schema
%%% Minimum values are MinValue
%%% Example: If Labels = [1 2 3 2 1]' then %'
%%%          LabelsNOutputs =
%%%           [    1     MinValue MinValue
%%%             MinValue    1     MinValue
%%%             MinValue MinValue    1
%%%             MinValue    1     MinValue
%%%                1     MinValue MinValue ]
%%%----------------------------------------------------------------

NExamples = size(Labels,1);
NOutputs = size(sort(unique(Labels)),1);
%%% Minimum values are 0/-1
if     MinValue == -1
  LabelsNOutputs = -ones(NExamples,NOutputs);
elseif MinValue == 0
  LabelsNOutputs = zeros(NExamples,NOutputs);
else
  error('MLE_CreateLabelsNOutputs: MinValue not -1/0');
end;

for i=1:NExamples
  LabelsNOutputs(i,Labels(i)) = 1; %%% Assigns 1's
end;

return;

%%%-------------------------------------------------
