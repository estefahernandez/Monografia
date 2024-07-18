*-------------------------------------------------------------------
*
*   Matriculas de vehículos nuevos en Colombia
*     
*   1. Se generara una nueva variable que contendra la primera palabra de la variable linea
*   2. Eliminar todos los años menores a 2023
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

**# 2019

    preserve
        keep if AÑO == 2019

        gen FIRST_LINEA = word(LINEA, 1)  // Coger la primera palabra de la observacion y crear una nueva variable
        egen CANTIDAD = count(FIRST_LINEA), by(FIRST_LINEA)

        duplicates report MARCA LINEA
        duplicates drop LINEA MARCA, force

        duplicates report FIRST_LINEA
        duplicates drop FIRST_LINEA, force 

        sort  MES

        save "$datacl/02-Vehiculos-2019.dta", replace // solo 2019
    restore

**# 2020

    preserve
        keep if AÑO == 2020

        gen FIRST_LINEA = word(LINEA, 1)  // Coger la primera palabra de la observacion y crear una nueva variable
        egen CANTIDAD = count(FIRST_LINEA), by(FIRST_LINEA)

        duplicates report MARCA LINEA
        duplicates drop LINEA MARCA, force

        duplicates report FIRST_LINEA
        duplicates drop FIRST_LINEA, force 

        sort  MES

        save "$datacl/02-Vehiculos-2020.dta", replace // solo 2019
    restore

**# 2021

    preserve
        keep if AÑO == 2021

        gen FIRST_LINEA = word(LINEA, 1)  // Coger la primera palabra de la observacion y crear una nueva variable
        egen CANTIDAD = count(FIRST_LINEA), by(FIRST_LINEA)

        duplicates report MARCA LINEA
        duplicates drop LINEA MARCA, force

        duplicates report FIRST_LINEA
        duplicates drop FIRST_LINEA, force 

        sort  MES

        save "$datacl/02-Vehiculos-2021.dta", replace // solo 2019
    restore


**# 2022

    preserve
        keep if AÑO == 2022

        gen FIRST_LINEA = word(LINEA, 1)  // Coger la primera palabra de la observacion y crear una nueva variable
        egen CANTIDAD = count(FIRST_LINEA), by(FIRST_LINEA)

        duplicates report MARCA LINEA
        duplicates drop LINEA MARCA, force

        duplicates report FIRST_LINEA
        duplicates drop FIRST_LINEA, force 

        sort  MES

        save "$datacl/02-Vehiculos-2022.dta", replace // solo 2019
    restore

**# 2023

    preserve
        keep if AÑO == 2023

        gen FIRST_LINEA = word(LINEA, 1)  // Coger la primera palabra de la observacion y crear una nueva variable
        egen CANTIDAD = count(FIRST_LINEA), by(FIRST_LINEA)

        duplicates report MARCA LINEA
        duplicates drop LINEA MARCA, force

        duplicates report FIRST_LINEA
        duplicates drop FIRST_LINEA, force 

        sort  MES

        save "$datacl/02-Vehiculos-2023.dta", replace // solo 2019
    restore



