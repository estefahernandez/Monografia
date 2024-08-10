*-------------------------------------------------------------------
*
*   Linea Base 2017
*     - Se limpia la base de datos con base al modelo   
*     - Se agregan las emisiones de coincidencia y proporcionales
*     - Se guarda la base
*-------------------------------------------------------------------


**# importar recaudo fiscal 2023 Gobernación de Antioquia

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

**# Limpieza 

    * Quedarme solo con estas observaciones
    keep if inlist(clase, "AUTOMOVIL", "CAMIONETA(C)", "CAMPERO")
    keep if uso == "PARTICULAR"
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"
    keep if modelo == 2017

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso

    * Cilindrajes erroneos
    drop if cilindraje <= 815

**# Emisiones

    ** Minimo
    
        gen min_CO2eq_ton = .

        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0001662 + (0.0001662 / 1373) * (cilindraje - 1373) if modelo == 2017

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0001662 if modelo == 2017 & cilindraje == 1373

    ** Media

        gen mean_CO2eq_ton = .

        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0001744 + (0.0001744 / 1373) * (cilindraje - 1373) if modelo == 2017

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0001744 if modelo == 2017 & cilindraje == 1373
        
    ** Maximo

        gen max_CO2eq_ton = .

        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.00018 + (0.00018 / 1373) * (cilindraje - 1373) if modelo == 2017

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.00018 if modelo == 2017 & cilindraje == 1373

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

//    export excel using "$excel/Datos_tratados/excel/lineabase2017.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2017.dta", replace
