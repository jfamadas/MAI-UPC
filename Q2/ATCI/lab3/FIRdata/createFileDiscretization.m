function createFileDiscretization(NomFitxer, nclasses)
Alcohol.Classes=nclasses;
Chlo.Classes=nclasses;
CitAcid.Classes=nclasses;
Density.Classes=nclasses;
FixAcid.Classes=nclasses;
FreeSulfDio.Classes=nclasses;
pH.Classes=nclasses;
ResSug.Classes=nclasses;
Sulph.Classes=nclasses;
TotalSulfDio.Classes=nclasses;
VolAcid.Classes=nclasses;

Quality.Classes=7;


Alcohol.Algoritme='EFP'; % EFP
Chlo.Algoritme='EFP';
CitAcid.Algoritme='EFP';
Density.Algoritme='EFP';
FixAcid.Algoritme='EFP';
FreeSulfDio.Algoritme='EFP';
pH.Algoritme='EFP';
ResSug.Algoritme='EFP';
Sulph.Algoritme='EFP';
TotalSulfDio.Algoritme='EFP';
VolAcid.Algoritme='EFP';

Quality.Algoritme='EFP';


Alcohol.Parametres=0;
Chlo.Parametres=0;
CitAcid.Parametres=0;
Density.Parametres=0;
FixAcid.Parametres=0;
FreeSulfDio.Parametres=0;
pH.Parametres=0;
ResSug.Parametres=0;
Sulph.Parametres=0;
TotalSulfDio.Parametres=0;
VolAcid.Parametres=0;

Quality.Parametres=0;


save (NomFitxer, 'Alcohol', 'Chlo', 'CitAcid', 'Density', 'FixAcid', 'FreeSulfDio', 'pH', 'ResSug', 'Sulph', 'TotalSulfDio', 'VolAcid', 'Quality');