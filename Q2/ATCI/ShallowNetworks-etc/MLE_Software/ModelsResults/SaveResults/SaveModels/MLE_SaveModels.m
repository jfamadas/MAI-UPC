
function MLE_SaveModels (Model,n,Param);

%%%=======================================================================

%%%---------------------------------
%%% Maybe there is nothing to do...
%%%---------------------------------

if ~isfield(Param,'SaveModels') || Param.SaveModels ~= 1
  return;
end;

%%%-----------------------------
%%% Default optional parameters
%%%-----------------------------

if isfield(Param,'DirSavedModels')
  DirSavedModels = Param.DirSavedModels;
else
  DirSavedModels = 'SavedModels';
end;

if isfield(Param,'PrefixSavedModels')
  PrefixSavedModels = Param.PrefixSavedModels;
else
  PrefixSavedModels = 'model';
end;

%%%------------------------
%%% Prepare to save models
%%%------------------------

if size(dir(DirSavedModels),1) == 0 mkdir('.',DirSavedModels); end;

FileName = sprintf('%s/%s-',DirSavedModels,PrefixSavedModels);
if (n < 100) FileName = sprintf('%s0',FileName); end; %'
if (n < 10)  FileName = sprintf('%s0',FileName); end; %'
FileName = sprintf('%s%d',FileName,n);

%%%------------
%%% Save model
%%%------------

SavedModel = Model;
save(FileName,'SavedModel');

%%%---

return;
