
*-------------------------------------------------------------------
*
*   Base gravable
*
*   Se realiza nuevamente un merge      
*   Se agrupan los datos por marca y linea para calcular el maximo, minimo y promedio
*
*-------------------------------------------------------------------



**# Organizar ventas Antioquia

    use "$ruta/Data_prepared/02-Vehiculos-2019-2023.dta", clear

        gen 	FIRST_LINEA = word(LINEA, 1) // Generar una nueva variable en la que solo se encuentra la primera palabra de LINEA

    save "$ruta/Data_prepared/03-Vehiculos-2019-2023.dta", replace 


**# Organizar Avaluo ministerio 2024

    use "$ruta/Data_prepared/01-01-AvaluoColombia-2024.dta", clear

        gen 	FIRST_LINEA = word(LINEA, 1)   
        //gen 	linea_base = regexm(LINEA, "LINEA BASE ESTANDAR")  

        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        bys MARCA FIRST_LINEA: egen MEAN_AVALUO = mean(AVALUO) //Calcular la media
        bys MARCA FIRST_LINEA: egen MIN_AVALUO = min(AVALUO)
        bys MARCA FIRST_LINEA: egen MAX_AVALUO = max(AVALUO)


    save "$ruta/Data_prepared/01-03-AvaluoColombia-2024.dta", replace

**# Segundo Merge

    use "$ruta/Data_prepared/01-03-AvaluoColombia-2024.dta", clear


    gen 	linea_base = regexm(LINEA, "LINEA BASE ESTANDAR") 
    bys 	first_linea: egen min_linea_base = min(linea_base)
