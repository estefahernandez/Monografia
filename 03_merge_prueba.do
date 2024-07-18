
*-------------------------------------------------------------------
*
*   Merge
*     
*   
*
*-------------------------------------------------------------------




    use "$ruta/Data_prepared/01-02-AvaluoColombia-2024.dta"
        merge 1:1 LINEA MARCA using "$ruta/Data_prepared/02-Vehiculos-2019-2023.dta"
        
        keep if _merge == 3 
        drop _merge
    
    save "$ruta/Data_prepared/01-02-AvaluoColombia-2024_merge1.dta", replace

