
*-------------------------------------------------------------------
*
*   Merge
*     
*   Merge de prueba entre Matriculas Nuevas y Avaluos Ministerio
*
*-------------------------------------------------------------------


    use "$ruta/Data_prepared/01-01-AvaluoColombia-2024.dta", clear // Base no repetidos de las 6 clases 

        duplicates report LINEA MARCA   
        duplicates drop LINEA MARCA, force

        gen 	FIRST_LINEA = word(LINEA, 1)   
        //gen 	linea_base = regexm(LINEA, "LINEA BASE ESTANDAR")  

        bys MARCA FIRST_LINEA: egen MEAN_AVALUO = mean(AVALUO) //Calcular la media
        bys MARCA FIRST_LINEA: egen MIN_AVALUO = min(AVALUO)
        bys MARCA FIRST_LINEA: egen MAX_AVALUO = max(AVALUO)

    save "$ruta/Data_prepared/01-02-AvaluoColombia-2024.dta", replace

   * Merge

    use "$ruta/Data_prepared/01-02-AvaluoColombia-2024.dta"
        merge 1:1 LINEA MARCA using "$ruta/Data_prepared/02-Vehiculos-2019-2023.dta"
        
        keep if _merge == 3 
        drop _merge
    
    save "$ruta/Data_prepared/01-02-AvaluoColombia-2024_merge1.dta", replace

