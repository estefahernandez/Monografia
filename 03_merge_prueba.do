
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
        gen 	linea_base = regexm(LINEA, "LINEA BASE ESTANDAR")  
        drop if linea_base == 1
        drop linea_base

        bys MARCA FIRST_LINEA: egen MEAN_AVALUO = mean(AVALUO) //Calcular la media
        bys MARCA FIRST_LINEA: egen MIN_AVALUO = min(AVALUO)
        bys MARCA FIRST_LINEA: egen MAX_AVALUO = max(AVALUO)

        sum *_AVALUO, d

    save "$ruta/Data_prepared/01-02-AvaluoColombia-2024.dta", replace

**# Matriculas nuevas

    use "$ruta/Data_prepared/01-Vehiculos-2019-2023.dta", clear

    ds, has(type string) // Me dice cuales variables son string

    foreach var in `r(varlist)' { 
        replace `var' = upper(`var')    
    }  // Convierte todas las variables string en mayuscula

    gen FIRST_LINEA = word(LINEA, 1)  // Coger la primera palabra de la observacion y crear una nueva variable
    egen CANTIDAD = count(FIRST_LINEA), by(FIRST_LINEA)

    duplicates report MARCA LINEA
    duplicates drop LINEA MARCA, force



    duplicates report FIRST_LINEA
    duplicates drop FIRST_LINEA, force 



    save "$ruta/Data_prepared/02-Vehiculos-2019-2023.dta", replace // Base completa vehículos Colombia






    use "$ruta/Data_prepared/01-02-AvaluoColombia-2024.dta"
        merge 1:1 LINEA MARCA using "$ruta/Data_prepared/02-Vehiculos-2019-2023.dta"
        
        keep if _merge == 3 
        drop _merge
    
    save "$ruta/Data_prepared/01-02-AvaluoColombia-2024_merge1.dta", replace

