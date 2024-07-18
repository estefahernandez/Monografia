*-------------------------------------------------------------------
*
*   Matriculas de vehículos nuevos en Colombia
*     
*   
*
*-------------------------------------------------------------------


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
