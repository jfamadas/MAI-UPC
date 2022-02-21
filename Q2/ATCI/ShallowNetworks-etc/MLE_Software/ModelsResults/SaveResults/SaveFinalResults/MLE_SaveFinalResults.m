
function MLE_SaveFinalResults (Results,Param);

%%%=======================================================================

%%%---------------------------------
%%% Maybe there is nothing to do...
%%%---------------------------------

if ~isfield(Param,'SaveFinalResults') || Param.SaveFinalResults ~= 1
  return;
end;

%%%-----------------------------
%%% Default optional parameters
%%%-----------------------------

if isfield(Param,'DirSavedFinalResults')
  DirSavedFinalResults = Param.DirSavedFinalResults;
else
  DirSavedFinalResults = 'SavedFinalResults';
end;

if isfield(Param,'PrefixSavedFinalResults')
  PrefixSavedFinalResults = Param.PrefixSavedFinalResults;
else
  PrefixSavedFinalResults = 'results';
end;

%%%-------------------------
%%% Prepare to save results
%%%-------------------------

if size(dir(DirSavedFinalResults),1) == 0 mkdir('.',DirSavedFinalResults); end;

FileName = sprintf('%s/%s',DirSavedFinalResults,PrefixSavedFinalResults);

%%%--------------
%%% Save results
%%%--------------

SavedResults = Results;
save(FileName,'SavedResults');

%%%---

return;
