
*-------------------------------------------------------------------
*
*   Matriculas de vehículos nuevos en Colombia
*     
*   Limpieza y organización de datos
*
*-------------------------------------------------------------------

**# Importar datos

/* Importar los datos en stata es complejo por el peso de los datos, por lo cual, son guardados inmediamente en .dta, para Limpiar y estructurar*/

    * Datos 01-Vehiculos

        import excel "$ruta/Data/Master/Vehiculos-2019-2024.xlsx", sheet("BD 1") firstrow clear // Se importa 2019-2021

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$ruta/Data/Master/01-Vehiculos-2019-2021.dta", replace //Cuenta con observaciones de 2019 hasta 2021

    * Datos 02-Vehiculos

        import excel "$ruta/Data/Master/Vehiculos-2019-2024.xlsx", sheet("BD 2") firstrow clear // Se importa 2022-2024

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$ruta/Data/Master/02-Vehiculos-2022-2024.dta", replace //Cuenta con observaciones de 2022 hasta 2024

    * Unir ambas bases de datos de 01-vehiculos y 02-vehiculos 

        use "$ruta/Data/Master/01-Vehiculos-2019-2021.dta", clear
        append using "$ruta/Data/Master/02-Vehiculos-2022-2024.dta"

        label variable PBV "PESO BRUTO VEHICULAR"  
        drop if AÑO == 2024
        drop COLOR AREAMETROPOLITANA  
        keep if DEPARTAMENTO == "Antioquia" 
        distinct MUNICIPIOCIUDAD // Distingir las cantidad de observaciones que son diferntes en una misma variable

        save "$ruta/Data_prepared/01-Vehiculos-2019-2023.dta", replace //Cuenta con observaciones de 2019 hasta 2023, ideal para trabajar

    
**# Analisis para realizar Merge de prueba

    use "$ruta/Data_prepared/01-Vehiculos-2019-2023.dta", clear

    duplicates report MARCA LINEA
    duplicates drop LINEA MARCA, force

    ds, has(type string) // Me dice cuales variables son string

    foreach var in `r(varlist)' { 
        replace `var' = upper(`var')    
    }  // Convierte todas las variables string en mayuscula

    save "$ruta/Data_prepared/02-Vehiculos-2019-2023.dta", replace // limpieza de datos para el merges inicial