function createFileConfiguration(NomFitxer, inputTrain, inputTest, numfold, nclasses, complexity)

Classes = '2';
Complexitat = '9';
FitxerCodif = 1;
FitxerEntradaEnt = inputTrain;
FitxerEntradaTest = inputTest;
GenerarModel = 0;
MasComp = 1;
NomFitxerCodif =  'Discretization.mat';
NomFitxerSor = ['Results_fold' num2str(numfold)];
NomModel = '';
Profunditat = '1';
ValMasComp = num2str(complexity);
VariablesEntrada = 'Alcohol,Chlo,CitAcid,Density,FixAcid,FreeSulfDio,pH,ResSug,Sulph,TotalSulfDio,VolAcid';
VariableSortida = 'Quality';
VGabs_weight = 1;
VGconfi = 0;
VGdef = 1;
VGdistance = 1;
VGenvol = 0;
VGmemb_shape = 0;
VGmiss_data = 0;
VGnorm_reg = 2;
VGnVeins = 5;
VGqualms = 1;
VGrepo = 0;

save (NomFitxer, 'Classes', 'Complexitat', 'FitxerCodif', 'FitxerEntradaEnt', ...
    'FitxerEntradaTest', 'GenerarModel', 'MasComp', 'NomFitxerCodif', 'NomFitxerSor', ...
    'NomModel', 'Profunditat', 'ValMasComp', 'VariablesEntrada', 'VariableSortida', ...
    'VGabs_weight', 'VGconfi', 'VGdef', 'VGdistance', 'VGenvol', 'VGmemb_shape', 'VGmiss_data', ...
    'VGnorm_reg', 'VGnVeins', 'VGqualms', 'VGrepo');