
function varargout = RuleExtractionProcess(varargin)
% RULEEXTRACTIONPROCESS M-file for RuleExtractionProcess.fig
%      RULEEXTRACTIONPROCESS, by itself, creates a new RULEEXTRACTIONPROCESS or raises the existing
%      singleton*.
%
%      H = RULEEXTRACTIONPROCESS returns the handle to a new RULEEXTRACTIONPROCESS or the handle to
%      the existing singleton*.
%
%      RULEEXTRACTIONPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RULEEXTRACTIONPROCESS.M with the given input arguments.
%
%      RULEEXTRACTIONPROCESS('Property','Value',...) creates a new RULEEXTRACTIONPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RuleExtractionProcess_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RuleExtractionProcess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RuleExtractionProcess

% Last Modified by GUIDE v2.5 29-Oct-2007 19:56:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RuleExtractionProcess_OpeningFcn, ...
                   'gui_OutputFcn',  @RuleExtractionProcess_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before RuleExtractionProcess is made visible.
function RuleExtractionProcess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RuleExtractionProcess (see VARARGIN)

InicializarLRFIR(hObject, eventdata, handles); %%% Se llama la funcion que inicializa LR-FIR

%%%%%%%% FIN FELIX AGOSTO 2007


% --- Outputs from this function are returned to the command line.
function varargout = RuleExtractionProcess_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BasicCompactation.
function BasicCompactation_Callback(hObject, eventdata, handles)
% hObject    handle to BasicCompactation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR

%%%%% SE EJECUTAN LOS PASOS PARA OBTENER LAS REGLAS CON EL ALGORITMO DE
%%%%% COMPACTACION BASICO
global archivo Earchivo FileRP;

ConflictMethodTemp = ConflictMethod;%% Para mantener el valor real de la variable sin que se inicialize al cargar el archivo

%%% Se cargan los archivos que contienen las reglas tanto crisp como difusas %%%%%
load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 

ConflictMethod = ConflictMethodTemp;%% Para mantener el valor real de la variable sin que se inicialize al cargar el archivo

%eval (['load ' FileRP]);

%%%%% EJECUTAR ALGORITMO DE COMPACTACION BASICO %%%%%%%%%%%%%%%%%%%%%%
%RPCompactedBasic = CompactBasico(OriginalRP, OrigRP, NumClass,%Complejidad);%% Cuando solo se aplicaba a opcion Soft
RPCompactedBasic = CompactBasico(OriginalRP, OrigRP, NumClass, Complejidad, ConflictMethod);%% Para implementar los 2 versiones de busqueda (Strict y Soft)


RPCompactedBasicAnt = RPCompactedBasic;
RPCompactedBasicAnt

%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
save FDadesRulesTemp.mat;

%%%% Mostrar las reglas actuales en el list box adecuado
StrRules = num2str(RPCompactedBasicAnt);
set(handles.ActualRules,'string',StrRules);

%%% MOSTRAR LAS REGLAS ORIGINALES EN EL LIST BOX ADECUADO
%StrRules1 = num2str(OrigRP);
%set(handles.OriginalRules,'string',StrRules1);

%StrRules2 = num2str(OrigRPOutliers);
%set(handles.OrigRules,'string',StrRules2);


%if(exist(RPCompactedBasicAnt))
    set(handles.BasicCompactation,'Enable','off');
    set(handles.ImprovedCompactation1,'Enable','on');
    set(handles.ImprovedCompactation2,'Enable','on');
    set(handles.RemoveDuplicates,'Enable','off');
    set(handles.UnificationRules,'Enable','off');
    set(handles.FilteringRules,'Enable','off');
    set(handles.SecondUnification,'Enable','off');    
    set(handles.RulesVisualization,'Enable','off');
    set(handles.ManualOutliers,'Enable','off');
    
    LRFIRStep = 2;
    
%end;

%%%%% FIN FELIX AGOSTO 2007


% --- Executes on button press in ImprovedCompactation1.
function ImprovedCompactation1_Callback(hObject, eventdata, handles)
% hObject    handle to ImprovedCompactation1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR

ClassInfluenceTemp = ClassInfluence; %% Para mantener el valor real de la variable sin que se inicialize al cargar el archivo
ConflictMethodTemp = ConflictMethod;

load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 

ClassInfluence = ClassInfluenceTemp;%% Para mantener el valor real de la variable sin que se inicialize al cargar el archivo
ConflictMethod = ConflictMethodTemp;

%%%%% EJECUTAR ALGORITMO DE COMPACTACION DE NOSOTROS (INFLUENCIA CLASES) %%%%%%%%%%%%%%%%%%%%%%
%%% PUEDE SER DIFERENTE PARA CADA VARIABLE?
Influencia = 0.75; %%% Se asigna el valor de la influencia de las variables
%Influencia = 0.66; %%% Se asigna el valor de la influencia de las variables

%%%% Se asigna una columna mas para marcar las reglas ya evaluadas y
%%%% compactadas
Temp1C = RPCompactedBasic(:,1); 
RPCompactedBasic(:,1)=0;          
RPCompactedBasic = [RPCompactedBasic(:,1) Temp1C RPCompactedBasic(:,2:end)];


%RPCompactedInfClases = CompactInfClases(RPCompactedBasic, OrigRP,NumClass, Complejidad, ClassInfluence);% No toma en cuenta el metodo de busqueda (Strict y Soft)
RPCompactedInfClases = CompactInfClases(RPCompactedBasic, OrigRP, NumClass, Complejidad, ClassInfluence, ConflictMethod); %% Se manda el metodo de Busqueda seleccionado (Strict o Soft)

RPCompactedInfClases
EnhancedCompRP = RPCompactedInfClases;

%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
save FDadesRulesTemp.mat;

%%%% Mostrar las reglas actuales en el list box adecuado
StrRules = num2str(RPCompactedInfClases);
set(handles.ActualRules,'string',StrRules);

set(handles.BasicCompactation,'Enable','off');
set(handles.ImprovedCompactation1,'Enable','off');
set(handles.ImprovedCompactation2,'Enable','off');
set(handles.RemoveDuplicates,'Enable','on');
set(handles.UnificationRules,'Enable','off');
set(handles.FilteringRules,'Enable','off');
set(handles.SecondUnification,'Enable','off'); 
set(handles.RulesVisualization,'Enable','off');
set(handles.ManualOutliers,'Enable','off');

LRFIRStep = 5;

%%%% FIN COMPACTACION EXTENDIDA NUESTRA

% --- Executes on button press in ImprovedCompactation2.
function ImprovedCompactation2_Callback(hObject, eventdata, handles)
% hObject    handle to ImprovedCompactation2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR

load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 

%%%%% ENHANCED COMPACTATION ALGORITHM %%%%%
%%%%% CON QUE MATRIZ SE EVALUA?, EL RESULTADO DEL BASICO O NUESTRO?
EnhancedCompRP = EnhancedCompactation(RPCompactedBasicAnt, OrigRP);
EnhancedCompRP
RPCompactedInfClases = EnhancedCompRP;

%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
save FDadesRulesTemp.mat;

%%%% Mostrar las reglas actuales en el list box adecuado
StrRules = num2str(EnhancedCompRP);
set(handles.ActualRules,'string',StrRules);

set(handles.BasicCompactation,'Enable','off');
set(handles.ImprovedCompactation1,'Enable','off');
set(handles.ImprovedCompactation2,'Enable','off');
set(handles.RemoveDuplicates,'Enable','on');
set(handles.UnificationRules,'Enable','off');
set(handles.FilteringRules,'Enable','off');
set(handles.SecondUnification,'Enable','off'); 
set(handles.RulesVisualization,'Enable','off');
set(handles.ManualOutliers,'Enable','off');

LRFIRStep = 5;

%%%% FIN COMPACTACION EXTENDIDA de CELLIER

% --- Executes on button press in RemoveDuplicates.
function RemoveDuplicates_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveDuplicates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep ManualOutliers UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR

StepProcess = 1; %% Significa que ha ejecutado la Eliminacion de reglas duplicadas y en conflicto

ConflictMethodTemp = ConflictMethod;
load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 
ConflictMethod = ConflictMethodTemp;

%%% SE EJECUTA LA FUNCION PARA ELIMINAR RP DUPLICADAS 
%CompactedRP = EliminarRPDuplicadas(EnhancedCompRP);
CompactedRP = EliminarRPDuplicadas(RPCompactedInfClases);

%%% SE EJECUTA LA FUNCION PARA ELIMINAR CONFLICTOS (EXISTA AMBIGUEDAD) EN LAS RP
%%% SE ENVIA COMO PARAMETRO LAS REGLAS SIN DUPLICADOS Y EL NUMERO DE CLASES
%%% DE LA VARIABLE DE SALIDA

%%%% SE CARGAN LOS DATOS PARA OBTENER LAS METRICAS DE SPECIFICITY Y
%%%% SENSITIVITY QUE PERMITIRAN ELIMINAR LAS REGLAS EN CONFLICTO DE MENOR CALIDAD 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Funcionaba cuando se evaluaban las reglas con los datos reales
%RealDataMask = ObtainRealDataMask(nraw,mask);

%[RenMask ColMask] = find(mask~=0);
%RealDataMask = nraw(:,ColMask); %%% Se obtienen unicamente los datos de las variables en la mascara
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% PARA CUANDO SE EVALUAN LAS REGLAS CON LAS REGLAS PATRON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CARGAR LOS DATOS DE TRAINING SIN OUTLIERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(length(ManualOutliers)~=0)
    OutliersSystem = OrigRPOutliers(ManualOutliers,:);
    IgualReglaActual = all(ismember(io,OutliersSystem(:,1:Complejidad),'rows'),2);
    [rOutliers cOutliers] = find(IgualReglaActual == 1);
    TotalRP = 1:size(io,1);
    NotOutliersTot = setdiff(TotalRP,rOutliers);
    RealDataMask = DATOS(NotOutliersTot,2:Complejidad+1); %% Obtener las reglas patron
else
    RealDataMask = DATOS(:,2:Complejidad+1); %% Obtener las reglas patron
end;
    
%RealDataMask = DATOS(:,2:Complejidad+1); %% Obtener las reglas patron

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Aciertos = [];
ContAciertos = 0;
MetricasUnif = [];
MetricasNOUnif = [];
MetricasBasico = [];
MetricasExtendido = [];

if (ConflictMethod==1)
    CompactedRPNOConf = EliminarRPConflictosStrict(CompactedRP, NumClasOutput, RealDataMask, nlm, lmOut); %% Strict Conflict Analysis
else
    CompactedRPNOConf = EliminarRPConflictosSoft(CompactedRP, NumClasOutput, RealDataMask, nlm, lmOut); %% Soft Conflict Analysis
end;

%CompactedRP
%CompactedRPNOConf = EliminarRPConflictosOption2(CompactedRP, NumClasOutput, RealDataMask, nlm, lmOut);
%CompactedRPNOConf1 = EliminarRPConflictos(CompactedRP, NumClasOutput, RealDataMask, nlm, lmOut);
%CompactedRPNOConf
%CompactedRPNOConf1
%CompactedRPNOConf = CompactedRP;

%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
save FDadesRulesTemp.mat;

%%%% Mostrar las reglas actuales en el list box adecuado
StrRules = num2str(CompactedRPNOConf);
set(handles.ActualRules,'string',StrRules);

set(handles.BasicCompactation,'Enable','off');
set(handles.ImprovedCompactation1,'Enable','off');
set(handles.ImprovedCompactation2,'Enable','off');
set(handles.RemoveDuplicates,'Enable','off');
set(handles.UnificationRules,'Enable','on');
set(handles.FilteringRules,'Enable','on');
set(handles.SecondUnification,'Enable','off'); 
set(handles.RulesVisualization,'Enable','off');
set(handles.ManualOutliers,'Enable','off');

LRFIRStep = 3;

%%%% FIN ELIMINAR REGLAS DUPLICADAS


% --- Executes on button press in UnificationRules.
function UnificationRules_Callback(hObject, eventdata, handles)
% hObject    handle to UnificationRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep ManualOutliers UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR
%% Para mantener el valor de la variable que contiene el tipo de unificacion y el de conflicto a realizar
UnifTypeTemp = UnifType;
ConflictMethodTemp2 = ConflictMethod;

if(StepProcess==1) %% Significa que el paso anterior fue la Eliminacion de reglas duplicadas y en conflicto
    load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 
    %StepProcess = 2;
else
    load FDadesRulesTempVis.mat;
    delete FDadesRulesTempVis.mat;
    StepProcess = 1;
end;

%if(exist('FDadesRulesTempVis.mat'))
%    load FDadesRulesTempVis.mat;
%    delete FDadesRulesTempVis.mat;
%else
%    load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 
%end;

%%% Restaurar los valores de las variables globales del tipo de unificacion y de conflicto a realizar
UnifType = UnifTypeTemp;
clear UnifTypeTemp;
ConflictMethod = ConflictMethodTemp2;

%%% SE EJECUTA LA FUNCION PARA UNIFICAR REGLAS BASANDOSE EN LOS RANGOS DE CADA UNA DE ELLAS
NumClass = NumClass(2:end);

%%% Evaluar el tipo de Unificacion seleccionado
if(UnifType==1) %% Metodo de Unificacion Wise permitiendo que una regla se unifique mas de 1 vez
    if(ConflictMethod == 1) %% Busqueda de reglas Strict
        [UnifiedRP, ResultNU] = UnificarRPCompactedRepeatStrict(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, 1);
    else%% Busqueda de reglas Soft
        [UnifiedRP, ResultNU] = UnificarRPCompactedRepeatSoft(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, 1);
    end;
elseif(UnifType==2) %% Metodo de Unificacion Blind permitiendo que una regla se unifique mas de 1 vez
    if(ConflictMethod == 1) %% Busqueda de reglas Strict
        [UnifiedRP, ResultNU] = UnificarRPCompactedRepeatStrict(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, 2);
    else %% Busqueda de reglas Soft
        [UnifiedRP, ResultNU] = UnificarRPCompactedRepeatSoft(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, 2);
    end;    
elseif(UnifType==3) %% Metodo de Unificacion Wise no permitiendo que una regla se unifique mas de 1 vez
    if(ConflictMethod == 1) %% Busqueda de reglas Strict
        [UnifiedRP, ResultNU] = UnificarRPCompactedNotRepeatStrict(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, 1);
    else%% Busqueda de reglas Soft
        [UnifiedRP, ResultNU] = UnificarRPCompactedNotRepeatSoft(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, 1);
    end;    
elseif(UnifType==4) %% Metodo de Unificacion Blind permitiendo que una regla se unifique mas de 1 vez
    if(ConflictMethod == 1) %% Busqueda de reglas Strict
        [UnifiedRP, ResultNU] = UnificarRPCompactedNotRepeatStrict(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, 2);
    else%% Busqueda de reglas Soft
        [UnifiedRP, ResultNU] = UnificarRPCompactedNotRepeatSoft(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, 2);
    end;    
end;

%%% Se ejecuta la funcion para unificar en primera etapa tomando en cuenta
%%% las reglas unificadas con otras reglas para posteriores unificaciones

%[UnifiedRP, ResultNU] = UnificarRPCompactedRepeat(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, UnifType);

%%% Necesario enviarle los otros parametros para ordenar las reglas
%%% basandos en su sensitividad, y unificar en primera etapa sin tomar en
%%% cuenta las ya unificadas con otras reglas para posteriores unificaciones

%[UnifiedRPNR, ResultNUNR] = UnificarRPCompactedNotRepeat(CompactedRPNOConf, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, UnifType);

re = any(UnifiedRP,2);
[rec cec] = find(re~=0); %% Se encuentra la regla con puros ceros
%UnifiedRP = UnifiedRP(rec,2:end);
UnifiedRP = UnifiedRP(rec,:);
%runif = 1:size(UnifiedRP,1);
%buenas = setdiff(runif,re);
%UnifiedRP = UnifiedRP(buenas,:);
%prueba = sortrows(CompactedRPNOConf,4);


%%%% Unificar manualmente una regla para el paper de WBE07
%UnifiedRP1 = [2 1 3 -1 -999 1 2 3 -999 4 1 2];
%UnifiedRP = UnifiedRP1;

%ResultNU = ResultNU([1:3 5:end],:);


%UnifiedRP = UnifiedRP(:,2:end); %% Eliminar la columna de guia
%ResultNU = ResultNU(:,2:end-1); %% Eliminar la columna de guia
ResultNU = ResultNU(:,2:end); %% Eliminar la columna de guia

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% OBTENER LAS METRICAS SOBRE LAS REGLAS UNIFICADAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% EVALUAR LAS REGLAS (LOGICAS) CON LOS DATOS DE TRAIN %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% EVALUAR LAS REGLAS UNIFICADAS
if (~isempty(UnifiedRP))
    MetricasUnif = EvaluarReglasUnif1(UnifiedRP, RealDataMask, nlm, lmOut);
    %MetricasUnif = EvaluarReglasUnif(UnifiedRP, RealDataMask, nlm, lmOut);
end;

if (~isempty(ResultNU))
    MetricasNOUnif = EvaluarReglasNOUnif(ResultNU, RealDataMask, nlm, lmOut);
end;

%%% Eliminar la columna de las instancias a las RP obtenidas con los
%%% algoritmos de compactacion basico y extendido
%%%OJO!!!!! NO ELIMINAR LA COLUMNA CUANDO SEA EL ALGORITMO DE INFLUENCIA DE
%%%CLASES, i.e. EL ALG. DE COMPACTACION MEJORADO 1
RPCompactedBasicAnt = RPCompactedBasicAnt(:,1:end-1);
EnhancedCompRP = EnhancedCompRP(:,1:end-1);

%%%%%%%%% EVALUAR CON LAS REGLAS GENERADAS POR EL ALGORITMO DE COMPACTACION
%%%%%%%%% BASICO Y EXTENDIDO RESPECTIVAMENTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MetricasBasico = EvaluarReglasNOUnif(RPCompactedBasicAnt, RealDataMask, nlm, lmOut);

MetricasMejCel = EvaluarReglasNOUnif(EnhancedCompRP, RealDataMask, nlm, lmOut);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Crear una variable Temporal con la matriz de de Reglas sin conflictos y borrar CompactedRPNOConf 
%%% para efectos de evaluarla al filtrar antes del paso de unificacion
CompactedRPNOConfTemp = CompactedRPNOConf;
clear CompactedRPNOConf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
save FDadesRulesTemp.mat;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Mostrar las reglas actuales en el list box adecuado
StrUnif        = sprintf('Unified Rules: ');
StrNOUnif      = sprintf('Not Unified Rules: ');

StrUnifRules = StrUnif; 
%StrUnifRules = '';
%StrUnifRulesTemp = '';
%for(i=1:size(UnifiedRP,1))
%   StrUnifRulesTemp   = sprintf('%s \n',int2str(UnifiedRP(i,:)));
   %StrUnifRules   = sprintf('%s \n',mat2str(UnifiedRP(i,:)));
%   StrUnifRules = [StrUnifRules StrUnifRulesTemp];
%end;
StrUnifRules   = strvcat(StrUnifRules, int2str(UnifiedRP));
%StrUnifRules   = int2str(UnifiedRP);

StrNOUnifRules = StrNOUnif;
%StrNOUnifRulesTemp = '';
%for(i=1:size(ResultNU,1))
 %  StrNOUnifRulesTemp   = sprintf('%s \n',int2str(ResultNU(i,:)));
%   StrNOUnifRules = [StrNOUnifRules StrNOUnifRulesTemp sprintf('\n')];
%end;

%StrNOUnifRules = mat2str(ResultNU);

StrNOUnifRules   = strvcat(StrNOUnifRules, int2str(ResultNU));

StrRules = strvcat(StrUnifRules, StrNOUnifRules);

set(handles.ActualRules,'string',StrRules);
%set(handles.ActualRules,'string',sprintf('%s ',StrUnifRules));

%%%% FIN Mostrar las reglas actuales en el list box adecuado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.BasicCompactation,'Enable','off');
set(handles.ImprovedCompactation1,'Enable','off');
set(handles.ImprovedCompactation2,'Enable','off');
set(handles.RemoveDuplicates,'Enable','off');
set(handles.UnificationRules,'Enable','off');
set(handles.FilteringRules,'Enable','on');
set(handles.SecondUnification,'Enable','on'); 
set(handles.RulesVisualization,'Enable','on');
set(handles.ManualOutliers,'Enable','off');

LRFIRStep = 3;

%%%% FIN UNIFICAR REGLAS

% --- Executes on button press in FilteringRules.
function FilteringRules_Callback(hObject, eventdata, handles)
% hObject    handle to FilteringRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR

%StepProcess = 2; %% Marcar que ya se ha ejecutado el paso de filtracion de reglas de mala calidad

FilteringMetricsTemp = FilteringMetrics;

load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 

StepProcess = 2; %% Marcar que ya se ha ejecutado el paso de filtracion de reglas de mala calidad

FilteringMetrics = FilteringMetricsTemp;
clear FilteringMetricsTemp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% ELIMINAR LAS REGLAS DE CALIDAD MALA, ES DECIR, CON SPECIFICITY MENOR
%%%%%% DE 0.9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% LLAMAR A LA FUNCION PARA EJECUTAR LA SEGUNDA ETAPA DE UNIFICACION
%[UnifiedRP, ResultNU] = UnificarReglas2aEtapa(UnifiedRP,ResultNU, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, UnifType)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% Reglas Uificadas
%if (~isempty(UnifiedRP))
if(exist('UnifiedRP'))
    if (~isempty(UnifiedRP))    
        [reu ceu] = find(MetricasUnif(:,5)>FilteringMetrics & MetricasUnif(:,6)>FilteringMetrics);
        %[reu ceu] = find(MetricasUnif(:,5)>0.45 & MetricasUnif(:,6)>0.45);
        UnifiedRP = UnifiedRP(reu,:);
        MetricasUnif = MetricasUnif(reu,:);
    end;
end;
%%%%% Reglas no unificadas
%if (~isempty(ResultNU))
if(exist('ResultNU'))
    if (~isempty(ResultNU))
        [renu cenu] = find(MetricasNOUnif(:,5)>FilteringMetrics & MetricasNOUnif(:,6)>FilteringMetrics);
        %[renu cenu] = find(MetricasNOUnif(:,5)>0.45 & MetricasNOUnif(:,6)>0.45);
        ResultNU = ResultNU(renu,:);
        MetricasNOUnif = MetricasNOUnif(renu,:);
    end;
end;

%%%% Entrara cuando aun no se haya efectuado el paso de unificacion
if(exist('CompactedRPNOConf'))    
    MetricasNOUnifTemp = EvaluarReglasNOUnif(CompactedRPNOConf(:,1:Complejidad), RealDataMask, nlm, lmOut);    
    [renu cenu] = find(MetricasNOUnifTemp(:,5)>FilteringMetrics & MetricasNOUnifTemp(:,6)>FilteringMetrics);
    %[renu cenu] = find(MetricasNOUnif(:,5)>0.45 & MetricasNOUnif(:,6)>0.45);
    CompactedRPNOConf = CompactedRPNOConf(renu,:);
    %MetricasNOUnif = MetricasNOUnif(renu,:);   
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
%save FDadesRulesTemp.mat;
save FDadesRulesTempVis.mat;

%%%% Mostrar las reglas actuales en el list box adecuado

%set(handles.ActualRules,'string','Prueba');
if(exist('UnifiedRP')) StrUnif        = sprintf('Unified Rules: '); end;
if(exist('ResultNU')) StrNOUnif      = sprintf('Not Unified Rules: '); end;

if(exist('UnifiedRP')) StrUnifRules = StrUnif; end;
%StrUnifRulesTemp = '';
%for(i=1:size(UnifiedRP,1))
%   StrUnifRulesTemp   = sprintf('%s \n',mat2str(UnifiedRP(i,:)));
%   StrUnifRules = [StrUnifRules StrUnifRulesTemp];
%end;
if(exist('UnifiedRP'))
    StrUnifRules   = strvcat(StrUnifRules,int2str(UnifiedRP));
else
    StrUnifRules   = '';
end;

if(exist('ResultNU')) StrNOUnifRules = StrNOUnif; end;
%StrNOUnifRulesTemp = '';
%for(i=1:size(ResultNU,1))
%   StrNOUnifRulesTemp   = sprintf('%s \n',mat2str(ResultNU(i,:)));
%   StrNOUnifRules = [StrNOUnifRules StrNOUnifRulesTemp sprintf('\n')];
%end;

if(exist('ResultNU'))
    StrNOUnifRules   = strvcat(StrNOUnifRules,int2str(ResultNU));
else
    StrNOUnifRules   = '';
end;

%StrNOUnifRules = mat2str(ResultNU);
if(exist('ResultNU') | exist('UnifiedRP'))
    StrRules = strvcat(StrUnifRules, StrNOUnifRules);
else
    StrRules = num2str(CompactedRPNOConf);
end;
set(handles.ActualRules,'string',StrRules);

set(handles.BasicCompactation,'Enable','off');
set(handles.ImprovedCompactation1,'Enable','off');
set(handles.ImprovedCompactation2,'Enable','off');
set(handles.RemoveDuplicates,'Enable','off');
set(handles.UnificationRules,'Enable','on');
set(handles.FilteringRules,'Enable','on');
set(handles.SecondUnification,'Enable','on'); 
set(handles.RulesVisualization,'Enable','on');
set(handles.ManualOutliers,'Enable','off');

LRFIRStep = 3;

%%%% FIN FILTRAR REGLAS


% --- Executes on button press in RulesVisualization.
function RulesVisualization_Callback(hObject, eventdata, handles)
% hObject    handle to RulesVisualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR

%%%% EVALUAR LAS REGLAS CON LOS DATOS DE TEST Y VISUALIZAR LAS REGLAS
%%%% OBTENIDAS
%load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 

if(StepProcess==1) %% 
    load FDadesRulesTemp.mat; %%% 
    StepProcess = 2;
else
    load FDadesRulesTempVis.mat;
    delete FDadesRulesTempVis.mat;
end;

%if(exist('FDadesRulesTempVis.mat'))
%    load FDadesRulesTempVis.mat;
%else
%    load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 
%end;
%load FDadesRulesTempVis.mat; %%% Cargar las variables temporales de las reglas 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% EVALUAR LAS REGLAS (LOGICAS) CON LOS DATOS DE TEST %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (exist('FDadesEntPred.mat'))
    load FDadesEntPred; %%% Se cargan los datos de prueba capturados desde el ambiente VisualFIR
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for nv=1:length(Dades.NomsVariables) %% Para obtener todas las variables
    rawTest(:,nv) = Dades.Var.(char(Dades.NomsVariables(nv)))';
end;

%cd datos; %%% Cambiar al directorio de los datos

%load MarçDryTestSM; %%% Marzo
%load Enero06SMO3; %%% Enero

%Matriz con los datos de prueba
%rawTest= [HD, RH, TMP, WD, WS, O3];
[nr,nc] = size(rawTest);%
%Normalización de rawTest para generar el modelo
%nrawTest = NormalizaMatriz(rawTest);
RealDataMaskTestNorm = ObtainRealDataMask(rawTest,mask);%%% AGRUPAR LOS DATOS DE TEST
%RealDataMaskTestNorm = ObtainRealDataMask(nrawTest,mask);%%% AGRUPAR LOS DATOS DE TEST


%%%% CODIFICAR LOS DATOS DE TEST PARA EVALUARLOS EN TERMINOS DE CLASES
for v=1:length(numclas)
    for t=1:numclas(v)
        fromTest = lm1{v};
        toTest = 1:numclas(v);
        %fromTest = [lmAct(1:numclas(v),1),lmAct(2:numclas(v)+1,1)]';
        %fromTest = 
        [cTest,mTest,sTest] = recode(RealDataMaskTestNorm(:,v),fromTest,toTest);
        ClassTest(:,v) = cTest;
        MembTest(:,v) = mTest;
        SideTest(:,v) = sTest;
    end;
end;

[cTest,mTest,sTest] = recode(RealDataMaskTestNorm(:,length(MVars)),lmOut,1:NumClasOutput);
ClassTest(:,length(MVars)) = cTest;
MembTest(:,length(MVars)) = mTest;
SideTest(:,length(MVars)) = sTest;

%%%% FIN CODIFICAR DATOS DE TEST

%%%% EVALUAR LAS REGLAS UNIFICADAS
if (~isempty(UnifiedRP))
    %MetricasUnifTest = EvaluarReglasUnif1(UnifiedRP, RealDataMaskTestNorm, nlm, lmOut);
    MetricasUnifTest = EvaluarReglasUnif1(UnifiedRP, ClassTest, nlm, lmOut);
    
    %% Se calculan las metricas de nuevo (Datos de Train) para que funcione para la segunda
    %% unificacion
    MetricasUnif = EvaluarReglasUnif1(UnifiedRP, RealDataMask, nlm, lmOut);    
end;

%%%%% EVALUAR LAS REGLAS NO UNIFICADAS
if (~isempty(ResultNU))
    %MetricasNOUnifTest = EvaluarReglasNOUnif(ResultNU, RealDataMaskTestNorm, nlm, lmOut);
    MetricasNOUnifTest = EvaluarReglasNOUnif(ResultNU, ClassTest, nlm, lmOut);
    
    %% Se calculan las metricas de nuevo (Datos de Train) para que funcione para la segunda
    %% unificacion
    MetricasNOUnif = EvaluarReglasNOUnif(ResultNU, RealDataMask, nlm, lmOut);
end;

%%%%%%%%% EVALUAR CON LAS RP GENERADAS POR EL ALGORITMO DE COMPACTACION
%%%%%%%%% BASICO Y EXTENDIDO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%MetricasBasicoTest = EvaluarReglasNOUnif(RPCompactedBasicAnt, RealDataMaskTestNorm, nlm, lmOut);

MetricasBasicoTest = EvaluarReglasNOUnif(RPCompactedBasicAnt, ClassTest, nlm, lmOut);


%MetricasMejCelTest = EvaluarReglasNOUnif(EnhancedCompRP, RealDataMaskTestNorm, nlm, lmOut);
MetricasMejCelTest = EvaluarReglasNOUnif(EnhancedCompRP, ClassTest, nlm, lmOut);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% GENERAR LAS REGLAS LOGICAS EN FORMATO TEXTUAL Y PRESENTARLAS AL USUARIO %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% DESCRIPCION DE LAS VARIABLES (ORDENADAS EN EL ORDEN QUE APARECEN EN LA
%% MASCARA) DEL SISTEMA ANALIZADO
%AntDescrip = {'HD' 'WS' 'RH' 'O3-2' 'O3'}; %% Agosto 

%AntDescrip = {'HD' 'O3-2' 'WD' 'WS'  'O3'}; %% Marzo
%AntDescrip = {'HD' 'O3-2' 'WD' 'WS'  'O3'}; %% Enero
%AntDescrip = {'COEV' 'IC' 'ER' 'MARK'}; 
%AntDescrip = char(AntDescrip);

AntDescrip = char(MVars);

%%% Comentario de bloque: para evaluar que funcione en todos los casos
if(0)
    temp = [2 1 3 -1 -999 1 2 3 -999 3 1 2 2];
    UnifiedRP(1,10) = 0;
    UnifiedRP(1,11) = 0;
    UnifiedRP(1,12) = 0;
    UnifiedRP(1,13) = 0;
    temp1 = [temp; UnifiedRP];
    UnifiedRP = temp1;
end;
%%%Fin comentario de bloque


%%%% PARA DECLARAR MATRICES VACIAS EN EL CASO DE QUE NO EXISTAN ALGUNOS
%%%% TIPOS DE REGLAS, COMO LAS UNIFICADAS 
%%%% PARA LOS DATOS DE TRAINING
if (~exist('UnifiedRP'))
    UnifiedRP=[];
end;
if (~exist('ResultNU'))
    ResultNU=[];
end;
if (~exist('MetricasUnif'))
    MetricasUnif=[];
end;
if (~exist('MetricasNOUnif'))
    MetricasNOUnif=[];
end;

%%%% PARA LOS DATOS DE TEST
if (~exist('MetricasUnifTest'))
    MetricasUnifTest=[];
end;
if (~exist('MetricasNOUnifTest'))
    MetricasNOUnifTest=[];
end;

%%% Imprimir las reglas para los datos de train
%lmdment = lmd(1:3);
%lmdms = lmd(5);
%lmdms = lmdms{:};
%[ReglasUSTrain, MetricasUSTrain] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, nlm, lmOut, AntDescrip, MetricasUnif, MetricasNOUnif, MetricasBasico);
%[ReglasUSTrain, MetricasUSTrain] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, lmdment, lmdms, AntDescrip, MetricasUnif, MetricasNOUnif, MetricasBasico);

%[ReglasUSTrain, MetricasUSTrain] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, lmd, lmOut, AntDescrip, MetricasUnif, MetricasNOUnif, MetricasBasico);
%[ReglasUSTrain, MetricasUSTrain, WholeRule] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, lmd, lmOut, AntDescrip, MetricasUnif, MetricasNOUnif, MetricasBasico);

%%%% Para obtener las reglas incluyendolas con la clase no solo con el rango
%%% LAS GENERA BASANDOSE EN EL ORDEN EN EL QUE SE UNIFICARON
%[ReglasUSTrain, MetricasUSTrain, WholeRule, WholeRuleClase] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, lmd, lmOut, AntDescrip, MetricasUnif, MetricasNOUnif, MetricasBasico);
%%% LAS GENERA BASANDOSE EN EL ORDEN REAL DE LAS VARIABLES

%%% VALIDAR QUE NO ESTEN VACIAS LAS MATRICES CON LAS REGLAS
%if(~isempty(UnifiedRP) & ~isempty(ResultNU))
    [ReglasUSTrain, MetricasUSTrain, WholeRule, WholeRuleClase] = GenerarReglasOrdenadas(UnifiedRP, ResultNU, EnhancedCompRP, lmd, lmOut, AntDescrip, MetricasUnif, MetricasNOUnif, MetricasBasico);
%end;

%%% Imprimir las reglas para los datos de test
%[ReglasUSTest, MetricasUSTest] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, nlm, lmOut, AntDescrip, MetricasUnifTest, MetricasNOUnifTest, MetricasBasicoTest);
%[ReglasUSTest, MetricasUSTest] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, lmdment, lmdms, AntDescrip, MetricasUnifTest, MetricasNOUnifTest, MetricasBasicoTest);

%[ReglasUSTest, MetricasUSTest] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, lmd, lmOut, AntDescrip, MetricasUnifTest, MetricasNOUnifTest, MetricasBasicoTest);
%[ReglasUSTest, MetricasUSTest, WholeRuleTest] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, lmd, lmOut, AntDescrip, MetricasUnifTest, MetricasNOUnifTest, MetricasBasicoTest);

%%%% Para obtener las reglas incluyendolas con la clase no solo con el rango
%%% LAS GENERA BASANDOSE EN EL ORDEN EN EL QUE SE UNIFICARON
%[ReglasUSTest, MetricasUSTest, WholeRuleTest, WholeRuleTestClase] = GenerarReglas(UnifiedRP, ResultNU, EnhancedCompRP, lmd, lmOut, AntDescrip, MetricasUnifTest, MetricasNOUnifTest, MetricasBasicoTest);
%%% LAS GENERA BASANDOSE EN EL ORDEN REAL DE LAS VARIABLES
%if(~isempty(UnifiedRP) & ~isempty(ResultNU))
    [ReglasUSTest, MetricasUSTest, WholeRuleTest, WholeRuleTestClase] = GenerarReglasOrdenadas(UnifiedRP, ResultNU, EnhancedCompRP, lmd, lmOut, AntDescrip, MetricasUnifTest, MetricasNOUnifTest, MetricasBasicoTest);
%end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Implementar la evaluacion de metricas para todo el conjunto de reglas

%%%% TRAIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TempMet = zeros(1,4);
if (isempty(MetricasUnif)) MetricasUnif = TempMet; end;
if (isempty(MetricasNOUnif)) MetricasNOUnif = TempMet; end;

[SensUSTR, SpecUSTR, PPVUSTR, AccuracyUSTR] = CalculateRulesMetrics(MetricasUnif,MetricasNOUnif);

[SensBas, SpecBas, PPVBas, AccuracyBas] = CalculateRulesMetrics(MetricasBasico);

[SensMEJC, SpecMEJC, PPVMEJC, AccuracyMEJC] = CalculateRulesMetrics(MetricasMejCel);

%%%% FIN MODIFICADO JULIO 2007

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% TEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (isempty(MetricasUnifTest)) MetricasUnifTest = TempMet; end;

if (isempty(MetricasNOUnifTest)) MetricasNOUnifTest = TempMet; end;

%%% Nuestras reglas
[SensUSTest, SpecUSTest, PPVUSTest, AccuracyUSTest] = CalculateRulesMetrics(MetricasUnifTest,MetricasNOUnifTest);

%%% Compactacion Basica
[SensBasTest, SpecBasTest, PPVBasTest, AccuracyBasTest] = CalculateRulesMetrics(MetricasBasicoTest);

%%% Compactacion Mejorada Cellier
[SensMEJCTest, SpecMEJCTest, PPVMEJCTest, AccuracyMEJCTest] = CalculateRulesMetrics(MetricasMejCelTest);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Imprimir las metricas para todo el sistema de reglas obtenidas %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% FIN MOSTRAR REGLAS

%%%% EVALUAR EL PORCENTAJE DE DATOS QUE CUBRE CADA REGLA

UnifiedRP
ResultNU
%%%% FIN EVALUAR EL PORCENTAJE DE DATOS QUE CUBRE CADA REGLA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Mostrar las reglas actuales en el list box adecuado
if(exist('WholeRule'))
    DirectRules = strvcat(WholeRule,'----------------------------------------------------------------', WholeRuleClase);
    set(handles.ActualRules,'string',DirectRules);
    WholeRuleClase
end;
%%%% FIN Mostrar las reglas actuales en el list box adecuado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Activar de nuevo los pasos del algoritmo
set(handles.BasicCompactation,'Enable','off');
set(handles.ImprovedCompactation1,'Enable','off');
set(handles.ImprovedCompactation2,'Enable','off');
set(handles.RemoveDuplicates,'Enable','off');
set(handles.UnificationRules,'Enable','off');
set(handles.FilteringRules,'Enable','off');
set(handles.SecondUnification,'Enable','off'); 
set(handles.RulesVisualization,'Enable','off');
set(handles.ManualOutliers,'Enable','off');

LRFIRStep = 3;

%%% Fin Activar de nuevo pasos del algoritmo

%%% PLOTEAR LOS RESULTADOS DE LAS REGLAS
%PlotearResultReglas(UnifiedRP, ResultNU, RealDataMask, nlm, lmOut, DATOS, mask, NumClass);



% --- Executes on button press in WholeRE.
function WholeRE_Callback(hObject, eventdata, handles)
% hObject    handle to WholeRE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PENDIENTE CHECAR QUE FUNCIONE CORRECTAMENTE!!!!!!!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global archivo Earchivo;

%%%% LLAMAR A LAS FUNCIONES DE EJECUCION DE LRFIR PASO A PASO PARA
%%%% COMPLETAR TODO EL PROCESO DE MANERA DIRECTA

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep ImpCompMethod UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR

%%%% Llamar a la funcion para ejecutar la compactacion basica
BasicCompactation_Callback(hObject, eventdata, handles);

LRFIRStep = 4;

if(ImpCompMethod ==1)
    %%%% Llamar a la funcion para ejecutar la compactacion mejorada nuestra (Minimal Ratio)
    ImprovedCompactation1_Callback(hObject, eventdata, handles);
else
    %%%% Llamar a la funcion para ejecutar la compactacion mejorada de Cellier
    ImprovedCompactation2_Callback(hObject, eventdata, handles);
end;
%%%% Llamar a la funcion para eliminar reglas duplicadas y en conflicto
RemoveDuplicates_Callback(hObject, eventdata, handles);
%%%% Llamar a la funcion para la unificacion de reglas
UnificationRules_Callback(hObject, eventdata, handles);
%%%% Llamar a la funcion para eliminar reglas de mala calidad (basadas en la Specificity y Sensitivity)
FilteringRules_Callback(hObject, eventdata, handles);
%%%% Llamar a la funcion para Visualizar las reglas en el List box adecuado
RulesVisualization_Callback(hObject, eventdata, handles);

%RulesExtraction(archivo,Earchivo);
%%%%%%%%%%%%%%%%FIN FUNCION DE OBTENCION DE REGLAS COMPLETAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over BasicCompactation.
function BasicCompactation_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to BasicCompactation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nom = ['Basic Compactation: An iterative process that evaluates, one at a time, all the rules in a pattern rule base.';...
       '                    The pattern rule base, R, is compacted on the basis of the knowledge obtained by FIR.    '];
set(handles.Help,'string',nom);
set(handles.Help,'Visible','on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ImprovedCompactation1.
function ImprovedCompactation1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ImprovedCompactation1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 

nom = ['Improved Compactation 1: The improved compactation step extends the knowledge base R to cases that have not been previously';...
       '                         used to build the model. This step contains undisputed knowledge and uncontested belief. This     ';...
       'option is an extension of the basic compactation, where a consistent and reasonable minimal ratio, MR, of the legal values ';...
       'LVa should be present in the candidate subset Rc, in order to compact it in the form of a single rule rc. This option seems';...
       'sensible because, although a reasonable ratio was used to compact Rc in a single rule rc, the assumed beliefs are minimal  ';...
       'and do not compromise the model previously identified by FIR.                                                              '];  
set(handles.Help,'string',nom);
set(handles.Help,'Visible','on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ImprovedCompactation2.
function ImprovedCompactation2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ImprovedCompactation2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nom = ['Improved Compactation 2: The improved compactation step extends the knowledge base R to cases that have not been previously';...
       '                         used to build the model. This step contains undisputed knowledge and uncontested belief. using the';...
       'compacted rule base R  obtained in step 1, all input features P (premises) are visited once more in all the rules r that   ';...
       'have nonnegative vales (not compacted), and their values are replaced by -1. An expansion to all possible full sets of     ';...
       'rules Xr and their comparison with the original rules R are carried out. If no conflicts Cf are found, the compacted rule, ';...
       'rc, is accepted, and otherwise, rejected.                                                                                  '];  
set(handles.Help,'string',nom);
set(handles.Help,'Visible','on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over RemoveDuplicates.
function RemoveDuplicates_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to RemoveDuplicates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nom = ['Remove Duplicates and Conflicting Rules: The execution of the before steps could generate duplicates and conflicting rules,';...
       'therefore in this step they are removed in order to maintain rules to be consistent eith the identified model              '];
set(handles.Help,'string',nom);
set(handles.Help,'Visible','on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over UnificationRules.
function UnificationRules_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to UnificationRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nom = ['Unification of Similar Rules: In this step are unificated those rules sharing contiguous input spaces. In this step candidate';...
       'rules are unified when sharing contiguous input spaces in a same variable but same value in all other variables.             '];
set(handles.Help,'string',nom); 
set(handles.Help,'Visible','on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over FilteringRules.
function FilteringRules_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to FilteringRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nom = ['Filtering of Bad Quality Rules: The obtained rules are evaluated using standard evaluation metrics, based on a confusion matrix.';...
       'The obtained metrics are Specificity and Sensitivity, and those rules with low values of both metrics are filtered in order to  ';...
       'maintain only high quality rules.                                                                                               '];
set(handles.Help,'string',nom);
set(handles.Help,'Visible','on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Second Unification Step.
function SecondUnification_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to UnificationRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nom = ['Second Unification of Similar Rules: In this step are those rules unified in the first step are evaluated with those not unified ';...
       'in order to obtain news unifications and reduce the final set of rules obtained. It is important to remark that in this stage    ';...
       'the candidate rules to unify should share contiguous input spaces in a same variable but same value in all other. In this step   ';...
       'Unifications apply only in input variables therefore not apply to output variable.                                               '];
set(handles.Help,'string',nom); 
set(handles.Help,'Visible','on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over RulesVisualization.
function RulesVisualization_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to RulesVisualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nom = ['Visualization of Obtained Rules: In this step the obtained rules are showed to an analysis performed by the domain experts.'];
set(handles.Help,'string',nom);
set(handles.Help,'Visible','on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over WholeRE.
function WholeRE_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to WholeRE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nom = ['Complete Rule Extraction Method: In this option a summarized process of rule extraction are performed executing all steps continually.'];
set(handles.Help,'string',nom);
set(handles.Help,'Visible','on');


% --- Executes during object creation, after setting all properties.
function ActualRules_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ActualRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in ActualRules.
function ActualRules_Callback(hObject, eventdata, handles)
% hObject    handle to ActualRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ActualRules contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ActualRules


% --- Executes during object creation, after setting all properties.
function OriginalRules_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OriginalRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in OriginalRules.
function OriginalRules_Callback(hObject, eventdata, handles)
% hObject    handle to OriginalRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns OriginalRules contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OriginalRules


% --- Executes during object creation, after setting all properties.
function OrigRules_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OrigRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in OrigRules.
function OrigRules_Callback(hObject, eventdata, handles)
% hObject    handle to OrigRules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns OrigRules contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OrigRules


% --- Executes on button press in LRFIRParameters.
function LRFIRParameters_Callback(hObject, eventdata, handles)
% hObject    handle to LRFIRParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LRFIRParameters(1);%% Se manda llamar los parametros para proceso paso a paso (Habilitados segun el paso)


% --- Executes on button press in LRFIRQuit.
function LRFIRQuit_Callback(hObject, eventdata, handles)
% hObject    handle to LRFIRQuit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%varargout{1} = handles.output;
closereq;

%clear all;


% --- Executes on button press in DirectLRFIRParametres.
function DirectLRFIRParametres_Callback(hObject, eventdata, handles)
% hObject    handle to DirectLRFIRParametres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LRFIRParameters(2); %% Se manda llamar los parametros para proceso directo (Habilitados todos)


% --- Executes on button press in ManualOutliers.
function ManualOutliers_Callback(hObject, eventdata, handles)
% hObject    handle to ManualOutliers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ManualOutliers UnifType StepProcess OrigRPOutliers OriginalRP OrigRP ord Complejidad OutlierPercentage OutlierInstances OriginalRPNOOutliers OrigRPNOOutliers OrdNOOutliers FileRP IndNotOutliers;

OutlierPercentageTemp = OutlierPercentage;
OutlierInstancesTemp = OutlierInstances;
%%% Cargar los datos del archivo que contiene las reglas patron
%load (FileRP);

load FDadesRulesTemp.mat; %%% Cargar las variables temporales de las reglas 

OutlierPercentage = OutlierPercentageTemp;
OutlierInstances = OutlierInstancesTemp;

if(OutlierPercentage ~= 0)    
    %%%Calcular el porcentaje de datos de la clase que tiene cada regla patron,
    %%%NoInstanciasRegla/TotalDatosClase; si esta es menor o igual al 10% (0.10), se eliminara.
    for i=1:size(OrigRPOutliers,1)
        PorcInfRegla(i,1) = ord(i,Complejidad+4)/ord(i,Complejidad+5);
    end;
    %[rt ct] = find(PorcInfRegla > 0.07);
    [rt ct] = find(PorcInfRegla > OutlierPercentage);

    %%% Eliminar las reglas con pocas instancias
    OriginalRPNOOutliers = OriginalRP(rt,:);
    OrigRPNOOutliers = OrigRP(rt,:);
    OrdNOOutliers = ord(rt,:);
    IndNotOutliers = rt;

    OriginalRP = OriginalRPNOOutliers;
    OrigRP = OrigRPNOOutliers;
    ord = OrdNOOutliers;
    
    StrRules2 = num2str(OrigRPNOOutliers);
    set(handles.OriginalRules,'string',StrRules2);
    
elseif(OutlierInstances ~= 0)
    [rt ct] = find(OrigRPOutliers(:,Complejidad+1)>OutlierInstances);
    
    ManualOutliers = setdiff(1:size(OrigRP,1)',rt);

    %%% Eliminar las reglas con pocas instancias
    OriginalRPNOOutliers = OriginalRP(rt,:);
    OrigRPNOOutliers = OrigRP(rt,:);
    OrdNOOutliers = ord(rt,:);
    IndNotOutliers = rt;

    OriginalRP = OriginalRPNOOutliers;
    OrigRP = OrigRPNOOutliers;
    ord = OrdNOOutliers;
    
    StrRules2 = num2str(OrigRPNOOutliers);
    set(handles.OriginalRules,'string',StrRules2);
    
else
    ManualOutliers = get(handles.OrigRules,'value');
    
    AllRP = 1:size(OrigRPOutliers,1);
    NotOutliers = setdiff(AllRP,ManualOutliers);
    
    %%% Eliminar las reglas con pocas instancias
    OriginalRPNOOutliers = OriginalRP(NotOutliers,:);
    OrigRPNOOutliers = OrigRP(NotOutliers,:);
    OrdNOOutliers = ord(NotOutliers,:);
    IndNotOutliers = NotOutliers;

    OriginalRP = OriginalRPNOOutliers;
    OrigRP = OrigRPNOOutliers;
    ord = OrdNOOutliers;

    StrRules2 = num2str(OriginalRP(:,2:end));
    set(handles.OriginalRules,'string',StrRules2);
end;

set(handles.ManualOutliers,'Enable','off');

%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
delete FDadesRulesTemp.mat;
save FDadesRulesTemp.mat;

% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

InicializarLRFIR(hObject, eventdata, handles); %%% Se llama la funcion que inicializa LR-FIR



%%%%%%%%%%%%%% FUNCION PARA INICIALIZAR LOS DATOS Y PARAMETROS DE LR-FIR
function InicializarLRFIR(hObject, eventdata, handles)
%%%% Eliminar el archivo temporal que contiene las variables de las reglas 
if(exist('FDadesRulesTemp.mat'))
    delete FDadesRulesTemp.mat;
end;

%%%ELIMINAR REGLAS CON POCAS INSTANCIAS SEPT 2007
global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep ImpCompMethod UnifType StepProcess%% Definir las variables globales LR-FIR

global OrigRPOutliers OriginalRP OrigRP ord Complejidad OriginalRPNOOutliers OrigRPNOOutliers OrdNOOutliers FileRP IndNotOutliers;

%%%% Inicializacion de variables globales (parametros de LR-FIR)
OutlierPercentage = 0;
OutlierInstances = 0;
ClassInfluence = 0.75;
FilteringMetrics = 0.45;
LRFIRStep = 1;
ImpCompMethod = 1;
ConflictMethod = 1;
UnifType = 1;
StepProcess = 1;
%%%% FIN Inicializacion de variables globales (parametros de LR-FIR)

% Choose default command line output for RuleExtractionProcess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RuleExtractionProcess wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%%%%%%% FELIX AGOSTO 2007
%%%%%% SE PREPARAN LOS DATOS PARA ENVIAR A LOS PASOS DEL PROCESO DE
%%%%%% EXTRACCION DE REGLAS

%%%% Cargar los archivos que contienen la informacion del modelo FIR
load FDadesCodifi.mat;
load FDadesModel.mat;

mask=Dades.mask; %%% Se obtiene la mascara
maskQ=Dades.qm; %%% Se obtiene la calidad de la mascara

NumVar = size(mask,1)*size(mask,2); %% Necesaria para cuando la mascara sea de mayor a profundidad 1

ContLndm = 1;
for nc=1:size(Dades.VClass,2) %% PAra obtener los landmarks de todas las variables
    LndmTots{nc} = Dades.VFrom(:,ContLndm:Dades.VClass(nc)+(ContLndm-1));
    Camp = char(Dades.Camps(nc));
    raw(:,nc)      = Dat.(Camp).dat';
    ContLndm = ContLndm + Dades.VClass(nc);
end;

ContVar = 1;
for rment=1:size(mask,1) %%% Recorrer los renglones de la mascara
    for cment=1:size(mask,2) %%% Recorrer las columnas de la mascara
        if(mask(rment,cment)~=0)
            numclasTot(ContVar) = Dades.VClass(cment); %% Se asigna el numero de clases de las m-entradas
            Landmarks{ContVar}  = LndmTots{cment}; %%% Se asignan los landmarks de las m-entradas
            MVars{ContVar} = char(Dades.Camps(cment)); %%% Se obtienen las variables de la mascara
            ContVar             = ContVar + 1; %%% Contador del numero de variables
        end;
    end;
end;

lm1           = Landmarks(1:length(Landmarks)-1);
lmOut         = Landmarks{length(Landmarks)};
numclas       = numclasTot(1:length(numclasTot)-1);
NumClasOutput = numclasTot(length(numclasTot));
Complejidad   = length(find(mask~=0));
io  = Dades.ba; %%% Para obtener las clases de cada m-variable
mio = Dades.mba; %%% PAra obtener las pertenencias de cada m-variable
sio = Dades.sba; %%% Para obtener los lados de cada m-variable
lmd = lm1;
nraw = raw;

global archivo Earchivo;
archivo = 'novi';
save(archivo,'lm1','numclas','NumClasOutput','mask','maskQ','nraw','io','mio','sio','lmOut','raw', 'lmd','MVars');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EJECUTAR LA FUNCION INITCARFIR PARA OBTENER LAS REGLAS PATRON 
[Earchivo] = INITCARFIR (lm1,numclas,mask,maskQ,nraw,io,mio,sio,archivo);

ArchivoIO = archivo;
ArchivoRP = ['E' archivo];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FIN PREPARAR DATOS PARA LA EXTRACCION DE REGLAS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% OBTENER LAS REGLAS PATRON SIN REPETICIONES INCLUYENDO EL NUMERO DE INSTANCIAS
%%%% DE CADA UNA Y MOSTRARLAS EN EL LIST BOX ADECUADO
%%%%% FELIX AGOSTO 2007

%%% Se cargan los archivos que contienen las reglas tanto crisp como difusas %%%%%

eval (['load ' archivo]);
eval (['load ' Earchivo]);
[NumPR NoColDatos] = size(DATOS); %%% Tamaño de la matriz DATOS generada por la funcion INITCARFIR

%%% Se almacenan en una matriz la m-entrada en la primera columna, las clases de las m-entradas en la segunda columna, 
%%% el valor minimo y el maximo en la tercera y cuarta columna, respectivamente.  
TotData = length(DATOS);

%%%% Para hacer un conteo de las veces que se repite cada regla patron diferente
Prueba_count = count_elements(DATOS(:,1)); %%% Prueba_count es una estructura
RulePat = Prueba_count.keys; %%% Se obtienen las reglas patron existentes (diferentes)
ContTemp = Prueba_count.value;
[i,j,s] = find(ContTemp); %%% Para obtener el contador de reglas patron
ContRulePat = s;

RulePatMEnt = fix(RulePat/10);
%ContRulePattern = [RulePat RulePatMEnt ContRulePat];

 Temp = RulePatMEnt * 10;
 Output = RulePat - Temp;

 RulePatStr = num2str(RulePat);
 RulePatSeparate = num2cell(RulePatStr);
 
 for i=1:size(RulePatSeparate,2)
     r(:,i) = str2num(cell2mat(RulePatSeparate(:,i)));
 end;
 
 ContRulePattern = [RulePat r RulePatMEnt Output ContRulePat];
 %ord  = sortrows(ContRulePattern,6); %%% Se ordenan por las clases de entrada
 ord  = sortrows(ContRulePattern,Complejidad+3); %%% Se ordenan por las clases de entrada
 
 for c=1:NumClasOutput
     ContClase = 0;
     %[ren col] = find(ord(:,7) == c);
     [ren col] = find(ord(:,Complejidad+3) == c);
     %ContClase = sum(ord(ren,8));
     ContClase = sum(ord(ren,Complejidad+4));
     %ord(ren,9) = ContClase;
     ord(ren,Complejidad+5) = ContClase;
 end;
 
 %%% Cambiar a la Sens o Specifity en lugar del numero de instancias
 InstanciasRP = ord(:,size(ord,2)-1); %%% Se obtienen las instancias de las RP en las RP originales
 %InstanciasRP = ord(:,size(ord,2)); %%% Se obtienen las instancias de las RP en las RP originales
 OriginalRP = [ord(:,2:Complejidad+1) InstanciasRP];%%% Se agregan las instancias
           
OrigRP = OriginalRP;           
Temp1C = OriginalRP(:,1); 
OriginalRP(:,1)=0;          
OriginalRP = [OriginalRP(:,1) Temp1C OriginalRP(:,2:end)];
[TotRP TotVarRP] = size(OriginalRP);

OriginalRPNOOutliers = OriginalRP;
OrigRPNOOutliers = OrigRP;
OrdNOOutliers = ord;

%%% Para mantener las reglas originales

OriginalRPOutliers = OriginalRP;
OrigRPOutliers = OrigRP;
OrdOutliers = ord;

%NumClass = [0 2 3 2 2]; %%% Para el experimento del Tech Report
%NumClasOutput = 2;      %%% Para el experimento del Tech Report

NumClass = [0 numclas NumClasOutput]; %%% Para los datos de DGB2

%NumClass = [0 2 2 2 2 2]; %%Segundo Experimento
%NumClass = [0 3 2 3 3 2 4]; %%Tercer Experimento
%Complejidad = 5; %%% Para el tercer experimento

%%%%% PRUEBA PARA ELIMINAR CONFLICTOS AL INICIO DEL PROCESO DE LR-FIR
%%%%%%% PARA CUANDO SE EVALUAN LAS REGLAS CON LAS REGLAS PATRON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%RealDataMask = DATOS(:,2:Complejidad+1); %% Obtener las reglas patron
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%RPNOConf = EliminarRPConflictos(OrigRP, NumClasOutput, RealDataMask, nlm, lmOut);
%RPNOConf
%%%%%FIN PRUEBA PARA ELIMINAR CONFLICTOS AL INICIO DEL PROCESO DE LR-FIR


%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
if(exist('FDadesRulesTemp.mat'))
    delete FDadesRulesTemp.mat;
end;
save FDadesRulesTemp.mat;

%%%% FIN OBTENER LAS RP SIN REPETICIONES Y CON EL NUMERO DE INSTANCIAS DE
%%%% CADA UNA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% MOSTRAR LAS REGLAS ORIGINALES EN EL LIST BOX ADECUADO
StrRules2 = num2str(OrigRPOutliers);
set(handles.OrigRules,'string',StrRules2);

set(handles.OriginalRules,'string',' ');
set(handles.ActualRules,'string',' ');

if(OutlierPercentage~=0 | OutlierInstances~=0)
    set(handles.BasicCompactation,'Enable','off');
else
    set(handles.BasicCompactation,'Enable','on');
end;
set(handles.ImprovedCompactation1,'Enable','off');
set(handles.ImprovedCompactation2,'Enable','off');
set(handles.RemoveDuplicates,'Enable','off');
set(handles.UnificationRules,'Enable','off');
set(handles.FilteringRules,'Enable','off');
set(handles.SecondUnification,'Enable','off'); 
set(handles.RulesVisualization,'Enable','off');
set(handles.ManualOutliers,'Enable','on');
set(handles.Reset,'Enable','off');

%%%%%%%%%%%%%% FIN FUNCION PARA INICIALIZAR LOS DATOS Y PARAMETROS DE LR-FIR


%%% Se manda llamar la funcion que implementa la segunda etapa de
%%% unificacion
% --- Executes on button press in SecondUnification.
function SecondUnification_Callback(hObject, eventdata, handles)
% hObject    handle to SecondUnification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OutlierPercentage OutlierInstances ClassInfluence FilteringMetrics ConflictMethod LRFIRStep UnifType StepProcess IndNotOutliers%% Definir las variables globales LR-FIR

if(StepProcess==1) %% 
    load FDadesRulesTemp.mat; %%% 
    StepProcess = 2;
else
    load FDadesRulesTempVis.mat;
    delete FDadesRulesTempVis.mat;
end;
if (exist('FDadesEntPred.mat'))
    load FDadesEntPred; %%% Se cargan los datos de prueba capturados desde el ambiente VisualFIR
end;

if (~exist('ResultNU'))
    ResultNU=[];
end;

if(exist('UnifiedRP') & ~isempty(UnifiedRP) & exist('ResultNU') & ~isempty(ResultNU))
    [UnifiedRP, ResultNU] = UnificarReglas2aEtapa(UnifiedRP,ResultNU, NumClasOutput, Complejidad, NumClass, RealDataMask, nlm, lmOut, UnifType);
end;

%%%% GUARDAR EN UN ARCHIVO EL ENTORNO DE VARIABLES ACTUAL PARA UTILIZARLO
%%%% EN LAS ETAPAS POSTERIORES DEL ALGORITMO DE EXTRACCION DE REGLAS
%save FDadesRulesTemp.mat;
save FDadesRulesTempVis.mat; %% Se salvan las variables generadas durante esta etapa
delete FDadesRulesTemp.mat; %% Se borra el archivo de datos de las estapas anteriores

if(exist('UnifiedRP')) StrUnif        = sprintf('Unified Rules: '); end;
if(exist('ResultNU')) StrNOUnif      = sprintf('Not Unified Rules: '); end;

if(exist('UnifiedRP')) StrUnifRules = StrUnif; end;

if(exist('UnifiedRP'))
    StrUnifRules   = strvcat(StrUnifRules,int2str(UnifiedRP));
else
    StrUnifRules   = '';
end;

if(exist('ResultNU')) StrNOUnifRules = StrNOUnif; end;

if(exist('ResultNU'))
    StrNOUnifRules   = strvcat(StrNOUnifRules,int2str(ResultNU));
else
    StrNOUnifRules   = '';
end;

%StrNOUnifRules = mat2str(ResultNU);
if(exist('ResultNU') | exist('UnifiedRP'))
    StrRules = strvcat(StrUnifRules, StrNOUnifRules);
else
    StrRules = num2str(CompactedRPNOConf);
end;
set(handles.ActualRules,'string',StrRules);

set(handles.BasicCompactation,'Enable','off');
set(handles.ImprovedCompactation1,'Enable','off');
set(handles.ImprovedCompactation2,'Enable','off');
set(handles.RemoveDuplicates,'Enable','off');
set(handles.UnificationRules,'Enable','off');
set(handles.FilteringRules,'Enable','off');
set(handles.SecondUnification,'Enable','off'); 
set(handles.RulesVisualization,'Enable','on');
set(handles.ManualOutliers,'Enable','off');
