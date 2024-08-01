
*-------------------------------------------------------------------
*
*   Linea Base 2017
*     
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

    ** formato
    destring impuesto, replace force

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

        drop if cilindraje < 900

    ** Estado de pago por parte de los propietarios año 2023

    gen estado_pago_2023 = "."
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2023", "DMY") & fecha_pago <= date("21apr2023", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("22apr2023", "DMY") & fecha_pago <= date("21jul2023", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("22jul2023", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

**# Emisiones

    ** Minimo

        * Coincidencia exactas
        gen min_CO2 = .
        replace min_CO2 = 486.3 if modelo == 2017 & cilindraje == 1598
        replace min_CO2 = 251.3 if modelo == 2017 & cilindraje == 1600
        replace min_CO2 = 423.6 if modelo == 2017  & cilindraje == 1796
        replace min_CO2 = 292 if modelo == 2017 & cilindraje == 1998
        replace min_CO2 = 394.8 if modelo == 2017 & cilindraje == 2477

        * valores proporcionales minimo
        replace min_CO2 = 486.3 + (486.3 / 1598) * (cilindraje - 1598) if modelo == 2017 & cilindraje <= 1500
        replace min_CO2 = 251.3 + (251.3 / 1600) * (cilindraje - 1600) if modelo == 2017 & cilindraje > 1500  & cilindraje <= 1600
        replace min_CO2 = 423.6 + (423.6 / 1796) * (cilindraje - 1796) if modelo == 2017 & cilindraje > 1600 & cilindraje < 2000
        replace min_CO2 = 292 + (292 / 1998) * (cilindraje - 1998) if modelo == 2017 & cilindraje >= 2000 & cilindraje < 2500
        replace min_CO2 = 394.8 + (394.8 / 2477) * (cilindraje - 2477) if modelo == 2017 & cilindraje >= 2500

        * missing
        replace min_CO2 = min_CO2 if missing(min_CO2)
        
    ** Media
        * Coincidencia exactas
            gen mean_CO2 = .
            replace mean_CO2 = 521.1 if modelo == 2017 & cilindraje == 1598
            replace mean_CO2 = 258.5 if modelo == 2017 & cilindraje == 1600
            replace mean_CO2 = 444.6 if modelo == 2017 & cilindraje == 1796
            replace mean_CO2 = 300.9 if modelo == 2017 & cilindraje == 1998
            replace mean_CO2 = 402.2 if modelo == 2017 & cilindraje == 2477

        * Proporcional media
            replace mean_CO2 = 521.1 + (521.1 / 1598) * (cilindraje - 1598) if modelo == 2017 & cilindraje <= 1500
            replace mean_CO2 = 258.5 + (258.5 / 1600) * (cilindraje - 1600) if modelo == 2017 & cilindraje > 1500  & cilindraje <= 1600
            replace mean_CO2 = 444.6 + (444.6 / 1796) * (cilindraje - 1796) if modelo == 2017 & cilindraje > 1600 & cilindraje < 2000
            replace mean_CO2 = 300.9 + (3300.9 / 1998) * (cilindraje - 1998) if modelo == 2017 & cilindraje >= 2000 & cilindraje < 2500
            replace mean_CO2 = 402.2 + (402.2 / 2477) * (cilindraje - 2477) if modelo == 2017 & cilindraje >= 2500
            
        * missing
            replace mean_CO2 = mean_CO2 if missing(mean_CO2)
    
    ** Maximo

        *Coincidencia exactas
        gen max_CO2 = .
        replace max_CO2 = 522.5 if modelo == 2017 & cilindraje == 1598
        replace max_CO2 = 258.7 if modelo == 2017 & cilindraje == 1600
        replace max_CO2 = 462.8 if modelo == 2017 & cilindraje == 1796
        replace max_CO2 = 310.8 if modelo == 2017 & cilindraje == 1998
        replace max_CO2 = 410.3 if modelo == 2017 & cilindraje == 2477

        * valores proporcionales maximo
        replace max_CO2 = 240.7 + (240.7 / 1598) * (cilindraje - 1598) if modelo == 2017 & cilindraje >= 1500 & cilindraje < 2000
        replace max_CO2 = 165.2 + (165.2 / 1496) * (cilindraje - 1496) if modelo == 2017 & cilindraje < 1500
        replace max_CO2 = 424.7 + (424.7 / 1968) * (cilindraje - 1968) if modelo == 2017 & cilindraje >= 2000
        replace max_CO2 = 424.7 + (424.7 / 1968) * (cilindraje - 1968) if modelo == 2017 & cilindraje >= 2000
        replace max_CO2 = 424.7 + (424.7 / 1968) * (cilindraje - 1968) if modelo == 2017 & cilindraje >= 2000

        * missing
        replace max_CO2 = max_CO2 if missing(max_CO2)


    ** Desviacion Estandar

        *Coincidencia exactas
        gen sd_CO2 = .
        replace sd_CO2 = 16.3 if modelo == 2017 & cilindraje == 1598
        replace sd_CO2 = 5.2 if modelo == 2017 & cilindraje == 1600
        replace sd_CO2 = 16.3 if modelo == 2017 & cilindraje == 1796
        replace sd_CO2 = 7.7 if modelo == 2017 & cilindraje == 1998
        replace sd_CO2 = 7.7 if modelo == 2017 & cilindraje == 2477

        * valores proporcionales sd
        replace sd_CO2 = 3.1 + (3.1 / 1598) * (cilindraje - 1598) if modelo == 2017 & cilindraje >= 1500 & cilindraje < 2000
        replace sd_CO2 = 5.7 + (5.7 / 1496) * (cilindraje - 1496) if modelo == 2017 & cilindraje < 1500
        replace sd_CO2 = 27.3 + (27.3 / 1968) * (cilindraje - 1968) if modelo == 2017 & cilindraje >= 2000
        replace sd_CO2 = 27.3 + (27.3 / 1968) * (cilindraje - 1968) if modelo == 2017 & cilindraje >= 2000
        replace sd_CO2 = 27.3 + (27.3 / 1968) * (cilindraje - 1968) if modelo == 2017 & cilindraje >= 2000

        * missing
        replace sd_CO2 = sd_CO2 if missing(sd_CO2)


**# Eliminación observaciones vacías

    misstable summarize // Observar todas la variables
    // drop if missing(mean_CO2)

**# Kilometros

    gen Km = 15000
    gen Km_sd = 3000

**# Precio CO2

    gen precio_CO2_ton = .
    replace precio_CO2_ton = 23394.60
    label variable precio_CO2_ton "Precio x toneladas"

**# Exportación a excel

   export excel using "$excel/Datos_tratados/excel/lineabase2017.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2017.dta", replace
