
*-------------------------------------------------------------------
*
*   Linea Base 2023
*   - Filtros con base a la información a usar
*   - Coincidencia de emisiones con el modelo y cilindraje 
*   - No coincidencia de modelo y cilindraje se hace la proporción
*
*-------------------------------------------------------------------


**# importar recaudo fiscal 2023 Gobernación de Antioquia

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

**# Limpieza 

    * Quedarme solo con estas observaciones
    keep if inlist(clase, "AUTOMOVIL", "CAMIONETA(C)", "CAMPERO")
    keep if uso == "PARTICULAR"
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"
    keep if modelo == 2023

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso

    * Cilindrajes erroneos
    drop if cilindraje <= 600

**# Emisiones

    ** Minimo

        gen min_CO2eq_ton = .

        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0002555 + (0.0002555 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1600 & cilindraje < 2000
        replace min_CO2eq_ton = 0.0001558 + (0.0001558 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1600
        replace min_CO2eq_ton = 0.00043205 + (0.00043205 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0002555 if modelo == 2023 & cilindraje == 1591
        replace min_CO2eq_ton = 0.0001558 if modelo == 2023 & cilindraje == 1496
        replace min_CO2eq_ton = 0.00043205 if modelo == 2023 & cilindraje == 1968
        
    ** Media

        gen mean_CO2eq_ton = .

        * Proporcional media
        replace mean_CO2eq_ton = 0.0002635 + (0.0002635 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1600 & cilindraje < 2000
        replace mean_CO2eq_ton = 0.0001634 + (0.0001634 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1600
        replace mean_CO2eq_ton = 0.0004695 + (0.0004695 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0002635 if modelo == 2023 & cilindraje == 1591
        replace mean_CO2eq_ton = 0.0001634 if modelo == 2023 & cilindraje == 1496
        replace mean_CO2eq_ton = 0.0004695 if modelo == 2023 & cilindraje == 1968

    ** Maximo

        gen max_CO2eq_ton = .
    
        * valores proporcionales maximo
        replace max_CO2eq_ton = 0.0002701 + (0.0002701 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1600 & cilindraje < 2000
        replace max_CO2eq_ton = 0.0001664 + (0.0001664 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1600
        replace max_CO2eq_ton =  0.0008065 + (0.0008065 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0002701 if modelo == 2023 & cilindraje == 1591
        replace max_CO2eq_ton = 0.0001664 if modelo == 2023 & cilindraje == 1496
        replace max_CO2eq_ton = 0.0008065 if modelo == 2023 & cilindraje == 1968

**# Kilometros

    gen Km = 15000
    gen Km_sd = 3000

**# Precio CO2

    gen precio_CO2eq_ton = .
    replace precio_CO2eq_ton = 23394.60
    label variable precio_CO2eq_ton "Precio x toneladas"

**# Exportación a excel

   export excel using "$excel/Datos_tratados/excel/lineabase2023.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2023.dta", replace
