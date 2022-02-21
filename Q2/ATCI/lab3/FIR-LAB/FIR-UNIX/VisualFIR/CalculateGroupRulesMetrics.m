%%% Funcion para calcular las metricas de evaluacion de reglas conjuntas qe pueden ser de la misma clase de salida o diferentes,
%%% basandose en las matrices que contienen las metricas de cada regla,
%%% INPUTS: 
%%%    UnifiedRP    = Reglas del tipo unificadas que se desee evaluar las metricas conjuntas   
%%%    ResultNU     = Reglas del tipo NO unificadas que se desee evaluar las metricas conjuntas
%%%    RealDataMask = Contiene los datos reales (expresados en reglas patron)
%%%    nlm          = Contiene los landmarks de las m-entradas
%%%    lmOut        = Contiene los landmarks de la m-salida
%%%    ClassOut     = Clase de salida actual
%%%    NoDatosClaseActual = Numero de datos de la clase de salida actual

%%% Significado de los campos de la matriz de confusion:
%%%                   REAL
%%%                TRUE| FALSE
%%%Prediction TRUE  TP | FP
%%%           FALSE FN | TN
%%%    Sens =          Flecha hacia abajo en TP      = TP/(TP+FN) 
%%%    Spec =          Flecha hacia arriba en TN     = TN/(TN+FP)
%%%    PPV (Precision)=Flecha hacia la derecha en TP = TP/(TP+FP)
%%%    ACC = (TP+TN)/(TP+TN+FP+FN)
%%%  TP=SI ANT, SI CONS
%%%  FN=NO ANT, SI CONS
%%%  FP=SI ANT, NO CONS
%%%  TN=NO ANT, NO CONS

%function [Sens, Spec, PPV, Accuracy, ConfMatrix] = CalculateGroupRulesMetrics(UnifiedRP,ResultNU, RealDataMask, nlm, lmOut, ClassOut, NoDatosClaseActual)

%%% AGREGADO EN ENERO DE 2011 PARA ELIMINAR DE TN LOS DATOS QUE ESTEN EN FP
%function [Sens, Spec, PPV, Accuracy, ConfMatrix, TPNoCero, FPNoCero,FNNoCeroReal,TNNoCero] = CalculateGroupRulesMetrics(UnifiedRP,ResultNU, RealDataMask, nlm, lmOut, ClassOut, NoDatosClaseActual)

function [Sens, Spec, PPV, Accuracy, ConfMatrix, TPNoCero, FPNoCero,FNNoCeroReal,TNNoCeroReal] = CalculateGroupRulesMetrics(UnifiedRP,ResultNU, RealDataMask, nlm, lmOut, ClassOut, NoDatosClaseActual)


%%% Se crean las matrices que contendran los datos fitted en cada metrica de la matriz de confusion
TP=zeros(size(RealDataMask,1),(size(UnifiedRP,1)+size(ResultNU,1)));
FP=zeros(size(RealDataMask,1),(size(UnifiedRP,1)+size(ResultNU,1)));
FN=zeros(size(RealDataMask,1),(size(UnifiedRP,1)+size(ResultNU,1)));
TN=zeros(size(RealDataMask,1),(size(UnifiedRP,1)+size(ResultNU,1)));
%%%% Para todos y poder hacer la comparacion despues
TPTot=zeros(size(RealDataMask,1),1);
FPTot=zeros(size(RealDataMask,1),1);
FNTot=zeros(size(RealDataMask,1),1);
TNTot=zeros(size(RealDataMask,1),1);

Flag = 0;

%if(exist('UnifiedRP'))
if(~isempty(UnifiedRP))
    for u=1:size(UnifiedRP,1)%% Se itera sobre las reglas unificadas
        %%% Se manda llamar la funcion que obtiene las metricas para cada regla y los valores de cada parte de la matriz de confusion
        [MetricasUnif, indTP, indFN, indTN, indFP] = EvaluarReglasUnif1RegIndConfMat(UnifiedRP(u,:), RealDataMask, nlm, lmOut);
        TP(1:size(indTP,1),u) = indTP;
        FP(1:size(indFP,1),u) = indFP;
        FN(1:size(indFN,1),u) = indFN;
        TN(1:size(indTN,1),u) = indTN;
    end;%% Fin iterar reglas unificadas
    Flag = 1;
else
    u=0;
end;


%if(exist('ResultNU'))
if(~isempty(ResultNU))
    for nu=1:size(ResultNU,1)%% Se itera sobre las reglas NO unificadas
        %%% Se manda llamar la funcion que obtiene las metricas para cada regla y los valores de cada parte de la matriz de confusion
        [MetricasNOUnif, indTP, indFN, indTN, indFP] = EvaluarReglasNOUnifRegIndConfMat(ResultNU(nu,:), RealDataMask, nlm, lmOut);
        TP(1:size(indTP,1),nu+u) = indTP;
        FP(1:size(indFP,1),nu+u) = indFP;
        FN(1:size(indFN,1),nu+u) = indFN;
        TN(1:size(indTN,1),nu+u) = indTN;
    end;%% Fin iterar reglas NO unificadas  
    Flag = 1;
else
    nu=0;
end;    

%%% Se obtienen los valores totales de cada metrica de la matriz de confusion
%%% TRUCO PORQUE UNION SOLO ACEPTA 2 VECTORES O MATRICES!!!!
if(Flag ~= 0)
    tot = 1;
    TPTot=union(TP(:,tot),TPTot);
    FPTot=union(FP(:,tot),FPTot);
    FNTot=union(FN(:,tot),FNTot);
    %TNTot=union(TN(:,tot),TNTot);%%Funciona cuando tenemos reglas que no se pueden unificar en la salida
    TNTot=union(TN(:,tot),TNTot);

    while tot < u+nu
        TPTot=union(TPTot,TP(:,tot+1));
        FPTot=union(FPTot,FP(:,tot+1));
        FNTot=union(FNTot,FN(:,tot+1));
        %TNTot=union(TNTot,TN(:,tot+1));%%Funciona cuando tenemos reglas que no se pueden unificar en la salida
        TNTot=intersect(TNTot,TN(:,tot+1));
        tot = tot + 1;
    end;

    %%% SE ELIMINAN LOS CEROS 
    %%% Se obtienen los indices de los valores no 0
    indTPNoCero=find(TPTot);
    indFPNoCero=find(FPTot);
    indFNNoCero=find(FNTot);
    indTNNoCero=find(TNTot);
    %%% Se obtienen los indices de los valores no 0
    TPNoCero = TPTot(indTPNoCero);
    FPNoCero = FPTot(indFPNoCero);
    FNNoCero = FNTot(indFNNoCero);
    TNNoCero = TNTot(indTNNoCero);
    %%%% FIN ELIMINAR CEROS
    
    %%%% AGREGADO JUNIO 2008
    %%%% NECESARIO PARA ELIMINAR DE FN TODOS AQUELLOS DATOS QUE ESTAN EN
    %%%% TP, cuyo significado es que fueron capturados por alguna otra
    %%%% regla
    FNNoCeroReal = setdiff(FNNoCero,TPNoCero);
    
    %%%% AGREGADO EN ENERO DE 2011
    %%%% NECESARIO PARA ELIMINAR DE TN TODOS LOS QUE ESTEN EN FP, CUYO
    %%%% SIGNIFICADO ES QUE SE DEBEN ELIMINAR PARA NO CONTABILIZARLOS 2
    %%%% VECES Y MANTENIENDO EL ERROR (FP) Y ELIMINANDO EL NO ERROR PERO
    %%%% TAMPOCO ACIERTO (TN), SERA ACIERTO SI DESPUES HAY OTRA REGLA DE OTR CLASE QUE
    %%%% LO CARACTERIZA BIEN 
    TNNoCeroReal = setdiff(TNNoCero,FPNoCero);
    %%%% FIN AGREGADO EN ENERO 2011
    

    %%% Se calculan los valores de cada metrica
    TPVal = size(TPNoCero,1);
    FPVal = size(FPNoCero,1);
    %FNVal = size(FNNoCero,1);
    FNVal = size(FNNoCeroReal,1);
    
    %%%% AGREGADO EN ENERO DE 2011
    %%%% NECESARIO PARA ELIMINAR DE TN TODOS LOS QUE ESTEN EN FP, CUYO
    %%%% SIGNIFICADO ES QUE SE DEBEN ELIMINAR PARA NO CONTABILIZARLOS 2
    %%%% VECES Y MANTENIENDO EL ERROR (FP) Y ELIMINANDO EL NO ERROR PERO
    %%%% TAMPOCO ACIERTO (TN), SERA ACIERTO SI DESPUES HAY OTRA REGLA DE OTR CLASE QUE
    %%%% LO CARACTERIZA BIEN 
    %TNVal = size(TNNoCero,1);
    TNVal = size(TNNoCeroReal,1);
    %%% FIN AGREGADO EN ENERO DE 2011
    
    
    
    %%% Se crea la Confusion matrix
    ConfMatrix(1,1)=TPVal;
    ConfMatrix(1,2)=FPVal;
    ConfMatrix(2,1)=FNVal;
    ConfMatrix(2,2)=TNVal;

    %%%% Para validar que no se divida por 0
    if((TPVal+FNVal)<=0)
        Sens = 0;
    else
        %if(ClassOut==3)
        %    Sens = TPVal / 58;
        %else
            Sens = TPVal / NoDatosClaseActual;%%% Dividido entre el total de datos de la clase de salida actual
            %Sens = TPVal / (FNVal);
            %Sens = TPVal / (TPVal+FNVal);
        %end;
    end;

    if((TNVal+FPVal)<=0)
        Spec = 0;
    else
        Spec = TNVal / (TNVal+FPVal);
        %Spec1 = 1-(FPVal/(size(RealDataMask,1)-NoDatosClaseActual))
        %Spec2 = 1-(FPVal/(size(RealDataMask,1)-NoDatosClaseActual));
        %Spec3 = TNVal/(size(RealDataMask,1)-NoDatosClaseActual);
        %Spec4 = (size(RealDataMask,1)-NoDatosClaseActual)/((size(RealDataMask,1)-NoDatosClaseActual)+FPVal);
    end;

    if((TPVal+FPVal)<=0)
        PPV = 0;
    else
        PPV = TPVal / (TPVal + FPVal);
    end;
        
    %Accuracy = TPVal / NoDatosClaseActual;%%% Igual a Sensitivity 
    
    Accuracy = (TPVal+TNVal)/(TPVal+TNVal+FPVal+FNVal);%%% REAL

    %if((TPVal+FPVal+FNVal+TNVal)<=0)
    %    Accuracy = 0;
    %else
    %    Accuracy = (TPVal +TNVal)/(TPVal + FPVal + FNVal + TNVal);
    %end;
else
    Sens=0;
    Spec=0;
    PPV = 0;
    Accuracy = 0;
end;%%%Evaluacion de Bandera