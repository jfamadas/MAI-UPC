
function DataSet_PRTools = MLE_CreataDataStructures_PRToolsClassification (DataSet);

prwarning off;  %%% PRTools warnings

%%% Create data structures for PRTools
DataSet_PRTools = dataset(DataSet.Inputs,DataSet.Labels);
DataSet_PRTools = setprior(DataSet_PRTools,getprior(DataSet_PRTools));

%prwarning(3);  %%% PRTools warnings
prprogress on; %%% Progress of some PRTools iterative routines

return;
