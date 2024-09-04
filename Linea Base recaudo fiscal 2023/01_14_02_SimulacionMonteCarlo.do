*-------------------------------------------------------------------
*
*   El impuesto cobrado por emisiones con base a una proyección a 10 años
*   
*   - Se unen los modelos con emisiones estimadas del periodo recaudado 2023
*   - 
*
*-------------------------------------------------------------------

**# Append Linea Base de los modelos 2011 hasta 2023 con sus respectivas estimaciones de las emisiones

    use "$datacl/Linea_base_modelo_2023.dta", clear

    append using "$datacl/Linea_base_modelo_2022.dta"
    append using "$datacl/Linea_base_modelo_2021.dta"
    append using "$datacl/Linea_base_modelo_2020.dta"
    append using "$datacl/Linea_base_modelo_2017.dta"
    append using "$datacl/Linea_base_modelo_2016.dta"
    append using "$datacl/Linea_base_modelo_2015.dta"
    append using "$datacl/Linea_base_modelo_2014.dta"
    append using "$datacl/Linea_base_modelo_2013.dta"
    append using "$datacl/Linea_base_modelo_2012.dta"
    append using "$datacl/Linea_base_modelo_2011.dta"

    save "$datacl/modelos_emisiones_recaudo2023.dta", replace

**# Organizar el formato de las variables impuesto y precio CO2

format precio_CO2eq_ton %12.0fc
format impuesto %12.0fc

**# Simulacion Monte Carlo

tarifa_CO2_2024