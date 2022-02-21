
function Data = MLE_PreprocessData (ParamGeneral,Param,Data);

fprintf('Preprocessing data...\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Data transformation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isfield(Param,'TypeTransform')
  Data = MLE_TransformDataType (Param,Data);
end;

%%%------

return;
