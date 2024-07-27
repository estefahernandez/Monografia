
*-------------------------------------------------------------------
*
*   Linea Base 2023
*     
*   1. 
*      
*      
*   2. 
*      
*
*-------------------------------------------------------------------

**# Importar datos recaudo fiscal 2023 Gobernación de Antioquia

    import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2023.csv", clear

    save "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", replace


**# importar recaudo fiscal 2023 Gobernación de Antioquia

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

**# Limpieza 

    * Quedarme solo con estas observaciones
    keep if inlist(clase, "AUTOMOVIL", "CAMIONETA(C)", "CAMIONETA(P)", "CAMPERO")
    keep if uso == "PARTICULAR"
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"
    keep if modelo == 2023

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso

    ** Organizar fechas 

        * Matriculas
        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        * Pagos
        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        * Renombrar variables
        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        * Orden variables
        order fecha_matricula, first
        order fecha_pago, before(impuesto)

        sort fecha_matricula

        drop if cilindraje <= 600

    ** formato
    destring impuesto, replace force

**# Emisiones

    ** Media
        * Coincidencia exactas
            gen mean_CO2 = .
            replace mean_CO2 = 238.1 if modelo == 2023 & cilindraje == 1591
            replace mean_CO2 = 161.2 if modelo == 2023 & cilindraje == 1496
            replace mean_CO2 = 390.15 if modelo == 2023 & cilindraje == 1968

        * Proporcional media
            replace mean_CO2 = 238.1 + (238.1 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1500 & cilindraje < 1600
            replace mean_CO2 = 161.2 + (161.2 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1500
            replace mean_CO2 = 390.15 + (390.15 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000
        
        * missing
            replace mean_CO2 = mean_CO2 if missing(mean_CO2)
    
    ** Maximo

        *Coincidencia exactas
        gen max_CO2 = .
        replace max_CO2 = 240.7 if modelo == 2023 & cilindraje == 1591
        replace max_CO2 = 165.2 if modelo == 2023 & cilindraje == 1496
        replace max_CO2 = 424.7 if modelo == 2023 & cilindraje == 1968

        * valores proporcionales maximo
        replace max_CO2 = 240.7 + (240.7 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1500 & cilindraje < 1600
        replace max_CO2 = 165.2 + (165.2 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1500
        replace max_CO2 = 424.7 + (424.7 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        * missing
        replace max_CO2 = max_CO2 if missing(max_CO2)


    ** Minimo

        * Coincidencia exactas
        gen min_CO2 = .
        replace min_CO2 = 233.7 if modelo == 2023 & cilindraje == 1591
        replace min_CO2 = 154.7 if modelo == 2023 & cilindraje == 1496
        replace min_CO2 = 363.25 if modelo == 2023 & cilindraje == 1968

        * valores proporcionales minimo
        replace min_CO2 = 233.7 + (233.7 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1500 & cilindraje < 1600
        replace min_CO2 = 154.7 + (154.7 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1500
        replace min_CO2 = 363.25 + (363.25 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        * missing
        replace min_CO2 = min_CO2 if missing(min_CO2)

    ** Desviacion Estandar

        *Coincidencia exactas
        gen sd_CO2 = .
        replace sd_CO2 = 3.1 if modelo == 2023 & cilindraje == 1591
        replace sd_CO2 = 5.7 if modelo == 2023 & cilindraje == 1496
        replace sd_CO2 = 27.3 if modelo == 2023 & cilindraje == 1968

        * valores proporcionales sd
        replace sd_CO2 = 3.1 + (3.1 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1500 & cilindraje < 1600
        replace sd_CO2 = 5.7 + (5.7 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1500
        replace sd_CO2 = 27.3 + (27.3 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        * missing
        replace sd_CO2 = sd_CO2 if missing(sd_CO2)

**# Kilometros

    gen Km = 15000
    gen Km_sd = 3000

**# Precio CO2

    gen precio_CO2_gramos = .
    replace precio_CO2_gramos = 23394.60/1000000
    label variable precio_CO2_gramos "Precio en gramos"


**# Exportación a excel

    export excel using "/Users/estefania/Library/CloudStorage/OneDrive-UniversidaddeAntioquia/Monografia-tesis/Datos_tratados/excel/lineabase.xlsx", replace firstrow(variables)


**# Guardar

    save "$datacl/Linea_base_modelo_2023.dta", replace





