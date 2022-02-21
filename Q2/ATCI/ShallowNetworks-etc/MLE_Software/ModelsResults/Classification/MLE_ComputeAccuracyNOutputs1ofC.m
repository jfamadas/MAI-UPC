
function Accuracy = MLE_ComputeAccuracyNOutputs1ofC (Outputs,Labels);

%%%--------------------------------------------------------------------------
%%% Computes the accuracy of Outputs (compared to Labels) in a 1-of-C schema
%%%
%%% Searches for the maximum values and compares its position with the label
%%%--------------------------------------------------------------------------

NExamples = size(Outputs,1);

OutputTestLabels = MLE_CodeNOutputs1ofC2Labels (Outputs);
Errors = find(OutputTestLabels-Labels ~= 0); %%% Labels are 1,2,3...
Accuracy = (NExamples - size(Errors,1)) / NExamples;

%
%%% Previous version without decoding (MLE_CodeNOutputs1ofC2Labels)
%
%[NExamples NOutputs] = size(Outputs);
%
%MaxOutputs = max(Outputs,[],2);
%NOk = 0;
%for i=1:NExamples
%  for j=1:NOutputs
%    if Outputs(i,j) == MaxOutputs(i)
%      jmax = j;
%    end;
%  end;
%  if jmax == Labels(i) %%% Labels are 1,2,3...
%    NOk = NOk+1;
%  end;
%end;
%Accuracy = NOk / NExamples;
