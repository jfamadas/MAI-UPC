function Auto(Nconfi)

global qualms repo confi miss_data memb_shape ...
def abs_weight norm_reg distance envol nVeins ...
meth_search valida_dat CausalRelevancy


dades = load(Nconfi);
Comptador = 0;

if isfield(dades,'Classes')
	% load the configuration if exists
	
    qualms = dades.VGqualms;
	repo = dades.VGrepo; 
	confi = dades.VGconfi;
	miss_data = dades.VGmiss_data;
	def = dades.VGdef;
	abs_weight = dades.VGabs_weight;
	norm_reg = dades.VGnorm_reg;
	distance = dades.VGdistance;
	envol = dades.VGenvol;
	memb_shape = dades.VGmemb_shape;
	if any(strcmp('VGnVeins',fieldnames(dades)))
		nVeins = dades.VGnVeins;
	else
		nVeins = 5;
    end
    meth_search = 1;
    valida_dat = 0;
    CausalRelevancy = 1;

 
    % read the training data
    if exist(dades.FitxerEntradaEnt,'file')
	vars = who('-file',dades.FitxerEntradaEnt);
	dadE = load(dades.FitxerEntradaEnt);
	j = size(vars,1);
		for i = 1:j
			fil = size(dadE.(char(vars(i))),1);
			if (fil == 1)
				DadesE.(char(vars(i))) = dadE.(char(vars(i)));
            else
				DadesE.(char(vars(i))) = dadE.(char(vars(i)))';
            end
        end
        Comptador = Comptador + 1;
    end

    % read the test data
    if exist(dades.FitxerEntradaTest,'file')
	dadT = load(dades.FitxerEntradaTest);
	for i = 1:j
		fil = size(dadT.(char(vars(i))),1);
			if (fil == 1)
				DadesTest.(char(vars(i))) = dadT.(char(vars(i)));
            else
				DadesTest.(char(vars(i))) = dadT.(char(vars(i)))';
            end
        end
        Comptador = Comptador + 1;
    end

    % read the codification file 
    if (dades.FitxerCodif == 1)
        if exist(dades.NomFitxerCodif,'file')
            Codi.valors = load(dades.NomFitxerCodif);
        end
    end
	
	VFrom = [];
	VClass = [];
	
	% recode the training data 
    nvar = size(vars,1);
    Algoritme = 'EFP'; % discretization algorithm by default
	Parametres = 0;
	Clusters = str2num(dades.Classes);
	to = 1:Clusters;
	for i=1:nvar
		var = char(vars(i));
		dat = DadesE.(var);
		% dealing with missing values if needed
		if (miss_data ~= 0)
			dadesX = dat((find(dat(:)~=miss_data)));
        else
			dadesX = dat;
        end
        Algoritme = Codi.valors.(var).Algoritme;
		Clusters = Codi.valors.(var).Classes;
		Parametres = Codi.valors.(var).Parametres;
        
		% perform the fuzzification process
        [from,to] = codif(dadesX', Clusters, Algoritme, Parametres);
		minim = min(dadesX);
		if (minim < from(1,1))
			from(1,1) = minim;
        end
		maxim = max(dadesX);
		if (maxim > from(size(from,1),size(from,2)))
			from(size(from,1),size(from,2)) = maxim;
        end
		[c, m, s]=recode(dat',from,to);
		From.(var) = from;
		To.(var) = to;
		DadesE.c(:,i) = c;
		DadesE.m(:,i) = m;
		DadesE.s(:,i) = s;
		VFrom = [VFrom, from];
		VClass = [VClass, Clusters];
	end

	% save the recoded data to the file: 'FDadesCodifi.mat'

	% Modeling process  

	% difine the candidate mask
	Profunditat = str2num(dades.Profunditat);
	mCan = ones(Profunditat,nvar)*-1;
	mCan(Profunditat,nvar) = 1;
	Complexitat = str2num(dades.Complexitat);

	% perform the optimal mask process
	[mask,hm,hr,qm,mhis]=mexfoptmask(DadesE.c,DadesE.m,mCan,Complexitat);
	[q, pos] = max(qm);
	h = hr(pos);

	% pattern rules obtaintion
	nMasc = Complexitat - 1;
	if (dades.MasComp == 1)
		MasComp = str2num(dades.ValMasComp);
		if (MasComp <= Complexitat)
			MasComp = MasComp - 1;
			mask = mhis(:,(MasComp-1)*NVar+1:MasComp*NVar);
			q = qm(MasComp);
			h = hr(MasComp);
			nMasc = MasComp;
		end
	end
        
    [io, mio, sio] = iomodel(DadesE.c,DadesE.m,DadesE.s,mask);
	[ba,mba,sba] = behavior(io,mio,sio);
        
    ConIni.c = DadesE.c(1:Profunditat,:);
	ConIni.m = DadesE.m(1:Profunditat,:);
	ConIni.s = DadesE.s(1:Profunditat,:);
	
	% Save the model data to the file: 'FDadesModel.mat'

    % DadesModel.VFrom = VFrom;
	% DadesModel.VClass = VClass;
	% DadesModel.Camps = handles.NomVar;
	% DadesModel.models = 1;
	% DadesModel.nMasc = 1;
	% DadesModel.model(1).mask = mask;
	% DadesModel.model(1).hr = h;
	% DadesModel.model(1).qm = q;
	% DadesModel.model(1).mCan = mCan;
	% DadesModel.model(1).Complexitat = Complexitat;
	% DadesModel.model(1).Profunditat = Profunditat;
	% DadesModel.model(1).Algoritme = 2;
	% DadesModel.model(1).PopSize = [];
	% DadesModel.model(1).ProbCross = [];
	% DadesModel.model(1).ProbMut = [];
	% DadesModel.model(1).MaxGen = [];
	% DadesModel.model(1).SelectedMethod = [];
	% DadesModel.model(1).CrossoverMethod = [];
	% DadesModel.model(1).ParamSelect = [];
	% DadesModel.mCan = mCan;
	% DadesModel.mask = mask;
	% DadesModel.qm = q;
	% DadesModel.hr = h;
	% DadesModel.ba = ba;
	% DadesModel.mba = mba;
	% DadesModel.sba = sba;
	% DadesModel.ConIni = ConIni;      
	
	% save('FDadesModel.mat','DadesModel');	
	
    
	if (dades.GenerarModel)
		Nom = dades.NomModel;
		if (Nom ~= 0)
			save(Nom, 'mask','ba','mba','sba','VClass','VFrom','ConIni');
			for i=1:NVar
				from = From.(char(vars(i)));
				save([Nom,'_',char(vars(i))],'from');
			end
		else
			msgbox('Falta el nom del fitxer');
		end
    end	


	% Prediction process

	% recode the test data
	j = 1;
	for i=1:nvar
		var = char(vars(i));
		from = From.(var);
		to = To.(var);
		Dat = DadesTest.(var);
		minim = min(Dat(find(Dat~=miss_data)));
		[filFrom, colFrom] = size(from);
		if (minim < from(1,1))
			from(1,1) = minim;
        end
		maxim = max(Dat(find(Dat~=miss_data)));
		if (maxim > from(filFrom, colFrom))
			from(filFrom, colFrom) = maxim;
        end
		[cT(:,i),mT(:,i),sT(:,i)]=recode(Dat',from,to);
    end        

	% save the test data to the file: 'FDadesEntPred.mat

    % Perform the prediction
	cT(size(mask,1):size(Dat,2),nvar) = 0;
	mT(size(mask,1):size(Dat,2),nvar) = 0.75;
	sT(size(mask,1):size(Dat,2),nvar) = 1;

	ErrorInput = [1,0];
	if confi == 0
		[cP,mP,sP] = forecast(cT,mT,sT,ba,mba,sba,mask,VClass,nVeins);
		conf = 0;
    else
		[cP,mP,sP,conf] = forecast(cT,mT,sT,ba,mba,sba,mask,VClass,nVeins);
    end

	if (ErrorInput(1) > 1)
		fid = fopen('ERRORF.DAT');
		F = fread(fid,1000);
		str = char(F');
		uiwait(msgbox(str,'Forecast Error','modal'));
		fclose(fid);
		delete 'ERRORF.DAT'
	end

	if (ErrorInput(2) > 0)
        % there are missing values
		uiwait(msgbox('Missing values','Forecast warning','modal'));
    end	
	
	% save the prediction results to the file: 'FDadesPrediccio.mat'

	if (envol == 1)
		k = nvar:nvar+2;
    else
		k = nvar;
    end

	clas = cP(:,k);
	memb = mP(:,k);
	side = sP(:,k);
	conf = 0;
	
    % save ('FDadesPrediccio.mat', 'clas', 'memb', 'side', 'to', 'from','conf');

    % perform regeneration

	if envol == 1
		if (miss_data ~= 0)
			ValorsMis = find(clas(:,1) == miss_data);
			clas(ValorsMis,2) = miss_data;
			clas(ValorsMis,3) = miss_data;
        end
		for i=1:3
			pred(:,i) = regenerate(clas(:,i),memb(:,i),side(:,i),to,from);
        end
	else
		pred = regenerate(clas(:,1),memb(:,1),side(:,1),to,from);
    end

	real = DadesTest.(var)';
	error = mse2(real,pred(:,1));
	NomFitxer = dades.NomFitxerSor;
	save(NomFitxer, 'mask', 'q', 'error', 'real','pred');

	% save the regeneration to the file: 'FDadesSortida.mat'

	% save('FDadesSortida.mat','pred');
end



%***********************************************************************
%%%%%   Functions
%***********************************************************************

%**************************************************************
function [from,to]= codif(Y,Clusters,Metode,Params)
%**************************************************************
% Retorna la matriu 'from' i 'to' per al mètode del FIR.
% Y : Vector on hi tenim un conjunt de dades a partir del qual es realitzarà la codificació
%		de la variable en tantes classes com s'indiqui.
% Clusters: Indica el nº de clusters en que es vol dividir les dades
% Metode: Indica el mètode a aplicar:
%				'SL':	Single Linkage
%				'CL': Complete Linkage
%				'SA': Simple Average Linkage
%				'AV': Average Linkage
%				'CE': Centroid Linkage
%				'ME': Median Linkage
%				'WA': Ward Linkage
%				'FM': Flexive Method
%				'EFP': Equal Frequency Intervals
%				'EQ_WIDTH': Equal Width Intervals
%				'K_MEANS': K_Means algorithm
%				'HCM': Hard C_Means
%				'FCM': Fuzzy C_Means
%               'EEFP': Algoritme 'EEFP'
%               'MAN': Manual
%% Params: Vector amb els possibles paràmetres que puguin tenir alguns dels mètodes
switch Metode
    case 'SL' % Algoritme 'SL'
        c = clusters_linkage(Y,Clusters,Metode,0);
        from = TrobarFrom(Y,c,Clusters);
    case 'CL' % Algoritme 'CL'
        c = clusters_linkage(Y,Clusters,Metode,0);
        from = TrobarFrom(Y,c,Clusters);
    case 'SA' % Algoritme 'SA'
        c = clusters_linkage(Y,Clusters,Metode,0);
        from = TrobarFrom(Y,c,Clusters);
    case 'AV' % Algoritme 'AV'
        c = clusters_linkage(Y,Clusters,Metode,0);
        from = TrobarFrom(Y,c,Clusters);
    case 'CE' % Algoritme 'CE'
        c = clusters_linkage(Y,Clusters,Metode,0);
        from = TrobarFrom(Y,c,Clusters);
    case 'ME' % Algoritme 'ME'
        c = clusters_linkage(Y,Clusters,Metode,0);
        from = TrobarFrom(Y,c,Clusters);
    case 'WA' % Algoritme 'WA'
        c = clusters_linkage(Y,Clusters,Metode,0);
        from = TrobarFrom(Y,c,Clusters);
    case 'FM' % Algoritme 'FM'
        c = clusters_linkage(Y,Clusters,Metode,Params(1));
        from = TrobarFrom(Y,c,Clusters);
    case 'EFP' % Algoritme 'EFP'
        [c,from] = eq_freq(Y,Clusters);
    case 'EQ_WIDTH' % Algoritme 'EQ_WIDTH'
        [c,from] = eq_width(Y,Clusters);
    case 'K_MEANS' % Algoritme 'K_MEANS'
        c = kmeans(Y,Clusters,Params(1));
        from = TrobarFrom(Y,c,Clusters);
    case 'HCM' % Algoritme 'HCM'
        c = hard_cmeans(Y,Clusters,Params(1),Params(2));
        from = TrobarFrom(Y,c,Clusters);
    case 'FCM' % Algoritme 'FCM'
        c = fuzzy_cmeans(Y,Clusters,Params);
        from = TrobarFrom(Y,c,Clusters);
    %case 'CHI' % Algoritme 'CHI'
    %case 'AK_MEANS' % Algoritme 'AK_MEANS'
    case 'EEFP' % Algoritme 'EEFP'
        [c,from] = EEFP(Y, Params(1), Params(2), Clusters);
    case 'MAN' % Manual
        c = Clusters;
        from = Params;
end 
to = 1:Clusters;


%*********************************************************************************
% Funció:  clusters_linkage (d: Matriu [1..n][1..m],clusters, opcio)					% 
% Retorn:  v: 		Vector amb els indexos de les classes per cada element			%
% Entrada: d:			Matriu que representa n objectes de dimensió m					%
%          clusters: Nº de conjunts a què es vol dividir les dades					%
%			  Opció: 	Indica quin algorisme es vol executar. 							%
%*********************************************************************************
function v = clusters_linkage(d, clusters, opcio,beta)
%**************************************************************
op = DecidirOpcio(opcio);
a = jerarquic_c(d,op,beta);
a(:,4) = 0;
n = size(a,1);
i = n;
while  i > n-clusters+1
   a(i,3) = -1;
   i = i-1;   
end
i = n-clusters+1;
c = 1;
while i >= 1
   if not(a(i,3) == -1)
      a = Fulles(a,i,c);
      c = c+1;
   end
   i = i-1;
end
v = a(1:size(d,1),4);

%***********************************************************************************%
%* Funció: Fulles																							%
%***********************************************************************************%
function aa = Fulles(a, node, c)
%**************************************************************
global aux;
aux = a;
if aux(node,1) == 0 
   % Es tracta d'una fulla
   aux(node,4) = c;
else
   aux = Fulles(aux,aux(node,1),c);
   aux = Fulles(aux,aux(node,2),c);
end
aux(node,3) = -1;
aa = aux;


%**************************************************************
function s = DecidirOpcio(a)
%**************************************************************
switch a
case 'SL'		% Single
   s = 1;
case 'CL'		% Complete
   s = 2;
case 'SA'		% Simple Average
   s = 3;
case 'AV'		% Average
   s = 4;
case 'CE'		% Centroid
   s = 5;
case 'ME'		% Median
   s = 6;
case 'WA'		% Ward
   s = 7;
case 'FM'		% Flexible Method
   s = 8;
end

%**************************************************************
function f = TrobarFrom(v,vc,Clusters)
%**************************************************************
for i=1:Clusters
   index = find(vc == i);				% Obtenim els índexos dels elements de la classe i
   if index
       elems = v(index);					% Obtenim els valors de la classe i
       minim(i) = min(elems);				% Obtenim el mínim valor de la classe
       maxim(i) = max(elems);				% Obtenim el màxim valor de la classe
   end
end
minim = sort(minim);						% Ordenem els mínims
maxim = sort(maxim);						% Ordenem els màxims
from = zeros(2,Clusters);
from(1,1) = minim(1);
for i=1:(Clusters-1)
   from(2,i) = (maxim(i) + minim(i+1))/2;
   from(1,i+1) = from(2,i);
end
from(2,Clusters) = maxim(Clusters);
f = from;
