
*-------------------------------------------------------------------
*
*   Linea Base 2016
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
    keep if modelo == 2016

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso

    * Cilindrajes erroneos
    drop if cilindraje <= 814

**# Emisiones

    ** Minimo
    
        gen min_CO2eq_ton = .

        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.000301133 + (0.000301133 / 1598) * (cilindraje - 1598) if modelo == 2016
        replace min_CO2eq_ton = 0.0002589 + (0.0002589 / 1600) * (cilindraje - 1600) if modelo == 2016
        replace min_CO2eq_ton = 0.0002965 + (0.0002965 / 1998) * (cilindraje - 1998) if modelo == 2016
        replace min_CO2eq_ton = 0.0004355 + (0.0004355 / 1796) * (cilindraje - 1796) if modelo == 2016
        replace min_CO2eq_ton = 0.00054 + (0.00054 / 2477) * (cilindraje - 2477) if modelo == 2016

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.000301133 if modelo == 2016 & cilindraje == 1598
        replace min_CO2eq_ton = 0.0002589 if modelo == 2016 & cilindraje == 1600
        replace min_CO2eq_ton = 0.0002965 if modelo == 2016 & cilindraje == 1998
        replace min_CO2eq_ton = 0.0004355 if modelo == 2016 & cilindraje == 1796
        replace min_CO2eq_ton = 0.00054 if modelo == 2016 & cilindraje == 2477

    ** Media

        gen mean_CO2eq_ton = .

        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.000302433 + (0.000302433 / 1598) * (cilindraje - 1598) if modelo == 2016
        replace mean_CO2eq_ton = 0.000267 + (0.000267 / 1600) * (cilindraje - 1600) if modelo == 2016
        replace mean_CO2eq_ton = 0.000306 + (0.000306 / 1998) * (cilindraje - 1998) if modelo == 2016
        replace mean_CO2eq_ton = 0.0004593 + (0.0004593 / 1796) * (cilindraje - 1796) if modelo == 2016
        replace mean_CO2eq_ton = 0.0005525 + (0.0005525 / 2477) * (cilindraje - 2477) if modelo == 2016

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.000302433 if modelo == 2016 & cilindraje == 1598
        replace mean_CO2eq_ton = 0.000267 if modelo == 2016 & cilindraje == 1600
        replace mean_CO2eq_ton = 0.000306 if modelo == 2016 & cilindraje == 1998
        replace mean_CO2eq_ton = 0.0004593 if modelo == 2016 & cilindraje == 1796
        replace mean_CO2eq_ton = 0.0005525 if modelo == 2016 & cilindraje == 2477
        
    ** Maximo

        gen max_CO2eq_ton = .

        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0003559 + (0.0003559 / 1598) * (cilindraje - 1598) if modelo == 2016  
        replace max_CO2eq_ton = 0.0002691 + (0.0002691 / 1600) * (cilindraje - 1600) if modelo == 2016
        replace max_CO2eq_ton = 0.0003163 + (0.0003163 / 1998) * (cilindraje - 1998) if modelo == 2016
        replace max_CO2eq_ton = 0.0004817 + (0.0004817 / 1796) * (cilindraje - 1796) if modelo == 2016
        replace max_CO2eq_ton = 0.000567 + (0.000567 / 2477) * (cilindraje - 2477) if modelo == 2016

        * Coincidencia exactas
        replace max_CO2eq_ton = 0.0003559 if modelo == 2016 & cilindraje == 1598
        replace max_CO2eq_ton = 0.0002691 if modelo == 2016 & cilindraje == 1600
        replace max_CO2eq_ton = 0.0003163 if modelo == 2016 & cilindraje == 1998
        replace max_CO2eq_ton = 0.0004817 if modelo == 2016 & cilindraje == 1796
        replace max_CO2eq_ton = 0.000567 if modelo == 2016 & cilindraje == 2477

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

//    export excel using "$excel/Datos_tratados/excel/lineabase2016.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2016.dta", replace
