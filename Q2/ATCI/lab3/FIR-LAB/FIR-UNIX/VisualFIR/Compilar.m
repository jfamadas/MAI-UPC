Avis = questdlg('Ull !!!. Aquesta funció compila els fitxers *.m i els elimina.... Vols continuar?','Perill', 'Si','No', 'Si');

if (isequal(Avis,'Si'))
    pcode DadesEntrada.m
    pcode DadesPrediccio.m
    pcode Codificar.m
    pcode Modelatge.m
    pcode Model.m
    pcode Prediccio.m
    pcode Regenerar.m
    pcode DadesSortida.m
    pcode Automatic.m
    %pcode Automatic.m GenerarSortida.m Pretractament.m
    pcode Parametres.m
    pcode PantallaPrincipal.m
    
    pcode fquality.m
    pcode mse2.m
    pcode rms.m
    
    pcode eq_width.m
    pcode eq_freq.m
    pcode fuzzy_cmeans.m
    pcode EEFP.m
        
    delete DadesEntrada.m
    delete DadesPrediccio.m
    delete Codificar.m
    delete Modelatge.m
    delete Model.m
    delete Prediccio.m
    delete Regenerar.m
    delete DadesSortida.m
    delete Automatic.m
    delete Parametres.m
    delete PantallaPrincipal.m
    
    delete fquality.m
    delete mse2.m
    delete rms.m
    delete eq_width.m
    delete eq_freq.m
    delete fuzzy_cmeans.m
    delete EEFP.m

    %delete compilar.m
end