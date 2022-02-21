
function MSError = MLE_ComputeMeanSquaredError (Outputs,Labels);

%%%-----------------------------------------------------
%%% Computes the mean squared error of Outputs - Labels
%%%-----------------------------------------------------

[NExamples NOutputs] = size(Outputs);
MSError = sum(sum((Outputs - Labels).^2)) / (NExamples*NOutputs);
