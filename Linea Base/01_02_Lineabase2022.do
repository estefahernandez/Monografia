
*-------------------------------------------------------------------
*
*   Linea Base 2022
*   - Filtros con base a la información a usar
*   - Coincidencia de emisiones con el modelo y cilindraje 
*   - No coincidencia de modelo y cilindraje se hace la proporción
*      
*
*-------------------------------------------------------------------


**# importar recaudo fiscal 2023 Gobernación de Antioquia

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

**# Limpieza 

    * Quedarme solo con estas observaciones
    keep if inlist(clase, "AUTOMOVIL", "CAMIONETA(C)", "CAMPERO")
    keep if uso == "PARTICULAR"
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"
    keep if modelo == 2022

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso

    * Cilindrajes erroneos
    drop if cilindraje <= 800

**# Emisiones

    ** Minimo

        gen min_CO2eq_ton = .

        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0002842 + (0.0002842 / 1998) * (cilindraje - 1998) if modelo == 2022 & cilindraje >= 2000
        replace min_CO2eq_ton = 0.0002833 + (0.0002833 / 1598) * (cilindraje - 1598) if modelo == 2022 & cilindraje < 2000

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0002842 if modelo == 2022 & cilindraje == 1998
        replace min_CO2eq_ton = 0.0002833 if modelo == 2022 & cilindraje == 1598
        
    ** Media

        gen mean_CO2eq_ton = .

        * Proporcional media
        replace mean_CO2eq_ton = 0.00029155 + (0.00029155 / 1998) * (cilindraje - 1998) if modelo == 2022 & cilindraje >= 2000
        replace mean_CO2eq_ton = 0.0002888 + (0.0002888 / 1598) * (cilindraje - 1598) if modelo == 2022 & cilindraje < 2000

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.00029155 if modelo == 2022 & cilindraje == 1998
        replace mean_CO2eq_ton = 0.0002888 if modelo == 2022 & cilindraje == 1598

    
    ** Maximo

        gen max_CO2eq_ton = .

        * valores proporcionales maximo
        replace max_CO2eq_ton = 0.0003002 + (0.0003002 / 1998) * (cilindraje - 1998) if modelo == 2022 & cilindraje >= 2000
        replace max_CO2eq_ton = 0.0002941 + (0.0002941 / 1598) * (cilindraje - 1598) if modelo == 2022 & cilindraje < 2000

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0003002 if modelo == 2022 & cilindraje == 1998
        replace max_CO2eq_ton = 0.0002941 if modelo == 2022 & cilindraje == 1598

**# Eliminación observaciones vacías

    misstable summarize 

**# Kilometros

    gen Km = 15000
    gen Km_sd = 3000

**# Precio CO2

    gen precio_CO2eq_ton = .
    replace precio_CO2eq_ton = 23394.60
    label variable precio_CO2eq_ton "Precio x toneladas"

**# Exportación a excel

   export excel using "$excel/Datos_tratados/excel/lineabase2022.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2022.dta", replace
