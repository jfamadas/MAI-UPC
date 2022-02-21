function crearFitxerDiscr(NomFitxer)

X1.Classes=3;
X2.Classes=3;
X3.Classes=3;
X4.Classes=2;
X5.Classes=2;
X6.Classes=2;
X7.Classes=2;
X8.Classes=2;
Y1.Classes=5;

X1.Algoritme='EQ_WIDTH';
X2.Algoritme='EQ_WIDTH';
X3.Algoritme='EQ_WIDTH';
X4.Algoritme='EQ_WIDTH';
X5.Algoritme='EQ_WIDTH';
X6.Algoritme='EQ_WIDTH';
X7.Algoritme='EQ_WIDTH';
X8.Algoritme='EQ_WIDTH';
Y1.Algoritme='EQ_WIDTH';

X1.Parametres=0;
X2.Parametres=0;
X3.Parametres=0;
X4.Parametres=0;
X5.Parametres=0;
X6.Parametres=0;
X7.Parametres=0;
X8.Parametres=0;
Y1.Parametres=0;

save (NomFitxer, 'X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'Y1');