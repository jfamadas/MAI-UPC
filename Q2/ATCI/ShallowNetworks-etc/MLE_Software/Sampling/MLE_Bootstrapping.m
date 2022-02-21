
function Sampling = MLE_Bootstrapping (Param,Labels,NExamples,NBSamplings)

%%%=======================================================================

%%%--------------------------------------------
%%% Validation of the values of the parameters
%%%--------------------------------------------

MLE_ValidateMandatoryParametersValue (NBSamplings);

if Param.Stratified
  fprintf(' Warning: Stratified makes no sense with bootstrapping');
end;


%%%=======================================================================

%%%------------------------------------------
%%% Bootstrapping with NBSamplings samplings
%%%------------------------------------------

Index = 1:NExamples;
if Param.Randomize
  Index = randperm(NExamples);
end;

[Dummy BootstrapTrain] = bootstrp(NBSamplings,[],Index);

for NSmpl=1:NBSamplings
  Sampling.Train{NSmpl} = BootstrapTrain(:,NSmpl);
  [Dummy BootstrapTest] = setdiff(Index,Sampling.Train{NSmpl});
  Sampling.Test{NSmpl} = BootstrapTest;
  %%%size(Sampling.Train{NSmpl})
  %%%size(Sampling.Test{NSmpl})
end;

Sampling.NSamplings = NBSamplings;

return;

%%% Original function
%%% function [trn tst] = bootsample(total_datos,total_muestras)
%%%   indice_datos=1:total_datos;
%%%   [tem trn] = bootstrp(total_muestras,[],indice_datos);
%%%   for i=1:total_muestras
%%%     [tem tst{i}] = setdiff(indice_datos,trn(:,i));
%%%   end
%%% return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auxiliary Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MLE_ValidateMandatoryParametersValue (NBSamplings);

%%%-------------------------------------
%%% Validation of the percentage values
%%%-------------------------------------

if NBSamplings <= 0
  error('MLE_Bootstrapping: NBSamplings <= 0'); %'
end;

return;

%%%-------------------------------------------------
