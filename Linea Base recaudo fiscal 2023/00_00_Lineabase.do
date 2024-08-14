
*-------------------------------------------------------------------
*
*   Recaudo fiscal 2023
*   - Modelos de vehículos desde 2011 hasta 2023
*   - Se genera una distribución PERT para generar la inflación
*   - 
*
*-------------------------------------------------------------------


**# Append Linea Base desde 2011 hasta 2023

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


**# Formato variables

format precio_CO2eq_ton %12.0fc
format impuesto %12.0fc


**# Guardar el documento en excel

    //export excel using "$excel/Datos_tratados/excel/lineabase_allmodelos_simulator.xlsx", replace firstrow(variables)

