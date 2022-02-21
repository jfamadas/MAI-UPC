
function Sampling = MLE_HoldOut_TVT (Param,Labels,NExamples,PctValid,PctTest)

%%%=======================================================================

%%%--------------------------------------------
%%% Validation of the values of the parameters
%%%--------------------------------------------

MLE_ValidateMandatoryParametersValue (PctTest,PctValid);

%%%=======================================================================

%%%-------------------------------------------------
%%% Hold-out-TVT: Hold-out Training/Validation/Test
%%%-------------------------------------------------

NTest = 0;
if PctTest ~= 0
  NTest = round(NExamples * PctTest);
end;

NValid = 0;
if PctValid ~= 0
  NValid = round(NExamples * PctValid);
end;

if Param.Stratified

  %%% Stratified hold-out
  ULabels=sort(unique(Labels));
  K = size(ULabels,1);

  n = 0;
  SmplAux = cell(K,3);
  for cl=1:K
    Classids = find(Labels == ULabels(cl));
    NClassids = size(Classids,1);
    Index = 1:NClassids;
    if Param.Randomize
      Index = randperm(NClassids);
    end;
    Sizes(3) = round(NClassids * PctTest);
    Sizes(2) = round(NClassids * PctValid);
    Sizes(1) = NClassids - Sizes(3) - Sizes(2);
    for ncl = 1:NClassids
      n = n + 1; if (n > 3) n = 1; end;
      while Sizes(n) == prod(size(SmplAux{cl,n}))
        n = n + 1; if (n > 3) n = 1; end;
      end;
      SmplAux{cl,n} = [SmplAux{cl,n} Classids(Index(ncl))];
    end;
  end;

  SmplAuxAcum = cell(3,1);
  for cl=1:K
    if PctTest ~= 0  SmplAuxAcum{3} = [SmplAuxAcum{3} SmplAux{cl,3}]; end;
    if PctValid ~= 0 SmplAuxAcum{2} = [SmplAuxAcum{2} SmplAux{cl,2}]; end;
    SmplAuxAcum{1} = [SmplAuxAcum{1} SmplAux{cl,1}];
  end;
  
  if PctTest ~= 0  Sampling.Test{1} = SmplAuxAcum{3};  end;
  if PctValid ~= 0 Sampling.Valid{1} = SmplAuxAcum{2}; end;
  Sampling.Train{1} = SmplAuxAcum{1};

else

  %%% Non stratified hold-out
  Index = 1:NExamples;
  if Param.Randomize
    Index = randperm(NExamples);
  end;

  EndIndex=NExamples; %%% Test and Validation at the end

  if PctTest ~= 0
    Sampling.Test{1} = Index(EndIndex-NTest+1:EndIndex);
    EndIndex = EndIndex - NTest;
  end;

  if PctValid ~= 0
    Sampling.Valid{1} = Index(EndIndex-NValid+1:EndIndex);
    EndIndex = EndIndex - NValid;
  end;

  Sampling.Train{1} = Index(1:EndIndex);

end;

Sampling.NSamplings = 1;

return;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParametersValue (PctTest,PctValid);

%%%-------------------------------------
%%% Validation of the percentage values
%%%-------------------------------------

if PctTest < 0 || PctValid < 0
  error('MLE_HoldOut_TVT: PctTest || PctValid < 0'); %'
end;

if PctTest + PctValid >= 1
  error('MLE_HoldOut_TVT: PctTest + PctValid >= 1');
end;

return;

%%%-------------------------------------------------
