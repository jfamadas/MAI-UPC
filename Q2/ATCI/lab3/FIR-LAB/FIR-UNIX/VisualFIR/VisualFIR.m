global qualms repo confi miss_data miss_data_real memb_shape meth_search def abs_weight norm_reg distance envol valida_dat CausalRelevancy nVeins pantalla idioma

def = 1;
abs_weight = 1;
norm_reg = 2;
meth_search = 1;
memb_shape = 0;
miss_data = 0;
miss_data_real = 0;
qualms = 1;
repo = 0;
confi = 0;
distance = 1;
envol = 0;
valida_dat = 0;
CausalRelevancy = 1;
nVeins = 5;
pantalla = 0;
idioma = 2;         % Nom�s per windows Idioma = 1 -> Catala; = 2 -> Angles;
SO = computer;
if ~isequal(SO, 'PCWIN64')
%if getenv('OS') ~= 'Windows_NT'
    idioma = 0;     % Si no �s windows queda les pantalles originals 
end


PantallaPrincipal;
