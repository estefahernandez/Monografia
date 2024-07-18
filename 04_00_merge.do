
*-------------------------------------------------------------------
*
*   Merge 
*
*   1. Se hace un merge entre ambas bases de datos   01_01_matriculas_nuevas_vehículos_colombia.do & 02_01_Avaluo_vehiculos_ministerio_2024.do
*    
*
*-------------------------------------------------------------------

clear all

**# Merge 2019

    use "$datacl/02-Vehiculos-2019.dta"
        merge 1:1 FIRST_LINEA using "$datacl/01-03-AvaluoColombia-2019.dta"

        keep if _merge == 3 
        drop _merge
    
    save "$datacl/01-02-AvaluoColombia-2019_merge1.dta", replace


**# Merge 2020

    use "$datacl/02-Vehiculos-2020.dta"
        merge 1:1 FIRST_LINEA using "$datacl/01-03-AvaluoColombia-2020.dta"

        keep if _merge == 3 
        drop _merge
    
    save "$datacl/01-02-AvaluoColombia-2020_merge1.dta", replace


**#  Merge 2021

    use "$datacl/02-Vehiculos-2021.dta"
        merge 1:1 FIRST_LINEA using "$datacl/01-03-AvaluoColombia-2021.dta"

        keep if _merge == 3 
        drop _merge
    
    save "$datacl/01-02-AvaluoColombia-2021_merge1.dta", replace


**# Merge 2022

    use "$datacl/02-Vehiculos-2022.dta"
        merge 1:1 FIRST_LINEA using "$datacl/01-03-AvaluoColombia-2022.dta"

        keep if _merge == 3 
        drop _merge
    
    save "$datacl/01-02-AvaluoColombia-2022_merge1.dta", replace


**# Merge 2023

    use "$datacl/02-Vehiculos-2023.dta"
        merge 1:1 FIRST_LINEA using "$datacl/01-03-AvaluoColombia-2023.dta"

        keep if _merge == 3 
        drop _merge
    
    save "$datacl/01-02-AvaluoColombia-2023_merge1.dta", replace

**# Panel


        use "$datacl/01-02-AvaluoColombia-2019_merge1.dta", clear
            append using "$datacl/01-02-AvaluoColombia-2020_merge1.dta"
            append using "$datacl/01-02-AvaluoColombia-2021_merge1.dta"
            append using "$datacl/01-02-AvaluoColombia-2022_merge1.dta"
            append using "$datacl/01-02-AvaluoColombia-2023_merge1.dta"

        save "$datacl/01-02-AvaluoColombia-merge1.dta", replace

