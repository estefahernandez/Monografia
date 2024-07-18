*-------------------------------------------------------------------
*
*   Avalúo del ministerio para los vehículos 2024
*     
*   1. Se importa la base 01-01-AvaluoColombia-2024.dta del do-file 02_Avaluo_vehiculos_ministerio_2024.do
*   2. Generar las variables como maximo, minimo y media. 
*
*-------------------------------------------------------------------

**# Avalucos Colombia desarrollada en 02_Avaluo_vehiculos_ministerio_2024.do

    use "$datacl/01-01-AvaluoColombia-2024.dta", clear // Base no repetidos de las 6 clases 

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

    save "$ruta/Data_prepared/01-02-AvaluoColombia-2024.dta", replace  // La base guardada sin repetidos