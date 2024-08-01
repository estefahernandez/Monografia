
*-------------------------------------------------------------------
*
*   Linea Base 2021
*     -  Filtros con base a la información a usar
*     - Solo se tiene una observación por lo cual las que coincidan se agrega la emisión
*       las que no se toma la propoción
*-------------------------------------------------------------------


**# importar recaudo fiscal 2023 Gobernación de Antioquia

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

**# Limpieza 

    * Quedarme solo con estas observaciones
    keep if inlist(clase, "AUTOMOVIL", "CAMIONETA(C)", "CAMPERO")
    keep if uso == "PARTICULAR"
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"
    keep if modelo == 2021

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso

    * Cilindrajes erroneos
    drop if cilindraje <= 800

**# Emisiones

    ** Minimo
    
        gen min_CO2eq_ton = .

        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0003816 + (0.0003816 / 1998) * (cilindraje - 1998) if modelo == 2021

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0003816 if modelo == 2021 & cilindraje == 1998

    ** Media

        gen mean_CO2eq_ton = .

        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0003928 + (0.0003928 / 1998) * (cilindraje - 1998) if modelo == 2021

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0003928 if modelo == 2021 & cilindraje == 1998
        
    ** Maximo

        gen max_CO2eq_ton = .

        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0004136 + (0.0004136 / 1998) * (cilindraje - 1998) if modelo == 2021

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0004136 if modelo == 2021 & cilindraje == 1998

**# Eliminación observaciones vacías

    misstable summarize // Observar todas la variables

**# Kilometros

    gen Km = 15000
    gen Km_sd = 3000

**# Precio CO2

    gen precio_CO2eq_ton = .
    replace precio_CO2eq_ton = 23394.60
    label variable precio_CO2eq_ton "Precio x toneladas"

**# Exportación a excel

   export excel using "$excel/Datos_tratados/excel/lineabase2021.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2021.dta", replace
