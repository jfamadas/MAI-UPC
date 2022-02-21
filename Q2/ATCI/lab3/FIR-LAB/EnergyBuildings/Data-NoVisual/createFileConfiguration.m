function crearFitxerConf(NomFitxer)

Classes = '3';
Complexitat = '5';
FitxerCodif = 1;
FitxerEntradaEnt = 'Y1Train_CV1.mat';
FitxerEntradaTest = 'Y1Test_CV1.mat';
GenerarModel = 0;
MasComp = 0;
NomFitxerCodif =  'Discretization.mat';
NomFitxerSor = 'ResultsCV1';
NomModel = '';
Profunditat = '3';
ValMasComp = '3';
VariablesEntrada = 'X1,X2,X3,X4,X5,X6,X7,X8';
VariableSortida = 'Y1';
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