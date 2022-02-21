
function DataSet_PRTools = MLE_CreataDataStructures_PRToolsClassification (DataSet);

prwarning off;  %%% PRTools warnings

%%% Create data structures for PRTools
DataSet_PRTools = dataset(DataSet.Inputs);
DataSet_PRTools = setlabtype(DataSet_PRTools,'targets',DataSet.Labels);

%prwarning(3);  %%% PRTools warnings
prprogress on; %%% Progress of some PRTools iterative routines

return;
