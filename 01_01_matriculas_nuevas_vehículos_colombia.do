*-------------------------------------------------------------------
*
*   Matriculas de vehículos nuevos en Colombia
*     
*   1. Se generara una nueva variable que contendra la primera palabra de la variable linea
*   2. Se organiza por orden mes y año
*   3. Se eliminan los duplicados
*   4. Se guarda una nuevo data set 
*
*-------------------------------------------------------------------


**# Matriculas nuevas

    use "$datacl/01-Vehiculos-2019-2023.dta", clear

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

    sort AÑO MES

    save "$ruta/Data_prepared/02-Vehiculos-2019-2023.dta", replace // Base completa vehículos Colombia
