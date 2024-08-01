*-------------------------------------------------------------------
*
*   Linea Base 2014
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
    keep if modelo == 2014

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso

    * Cilindrajes erroneos
    drop if cilindraje <= 800

**# Emisiones

    ** Minimo
    
        gen min_CO2eq_ton = .

        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0002677 + (0.0002677 / 1390) * (cilindraje - 1390) if modelo == 2014
        replace min_CO2eq_ton = 0.0002307 + (0.0002307 / 1248) * (cilindraje - 1248) if modelo == 2014

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0002677 if modelo == 2014 & cilindraje == 1373
        replace min_CO2eq_ton = 0.0002307 if modelo == 2014 & cilindraje == 1248

    ** Media

        gen mean_CO2eq_ton = .

        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0002849 + (0.0002849 / 1390) * (cilindraje - 1390) if modelo == 2014
        replace mean_CO2eq_ton = 0.0002341 + (0.0002341 / 1248) * (cilindraje - 1248) if modelo == 2014

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0002849 if modelo == 2014 & cilindraje == 1390
        replace mean_CO2eq_ton = 0.0002341 if modelo == 2014 & cilindraje == 1248
        
    ** Maximo

        gen max_CO2eq_ton = .

        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0003038 + (0.0003038 / 1390) * (cilindraje - 1390) if modelo == 2014
        replace max_CO2eq_ton = 0.0002367 + (0.0002367 / 1248) * (cilindraje - 1248) if modelo == 2014

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0003038 if modelo == 2014 & cilindraje == 1390
        replace max_CO2eq_ton = 0.0002367 if modelo == 2014 & cilindraje == 1248

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

   export excel using "$excel/Datos_tratados/excel/lineabase2014.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2014.dta", replace
