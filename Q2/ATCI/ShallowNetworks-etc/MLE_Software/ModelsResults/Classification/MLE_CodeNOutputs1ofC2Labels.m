
function Labels = MLE_CodeNOutputs1ofC2Labels (Outputs);

%%%----------------------------------------------------------
%%% Decodes Outputs in a 1-of-C schema to Labels (1,2,3,...)
%%% searching for the maximum values
%%%----------------------------------------------------------

[NExamples NOutputs] = size(Outputs);

MaxOutputs = max(Outputs,[],2);
Labels = zeros(NExamples,1);
for i=1:NExamples
  for j=1:NOutputs
    if Outputs(i,j) == MaxOutputs(i)
      jmax = j;
    end;
  end;
  Labels(i) = jmax; %%% Labels are 1,2,3...
end;
