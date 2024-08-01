
*-------------------------------------------------------------------
*
*   Linea Base 2021
*     
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
    keep if modelo == 2020

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

        drop if cilindraje <= 600

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
        replace min_CO2 = 351.5 if modelo == 2020 & cilindraje == 1389
        replace min_CO2 = 259.15 if modelo == 2020 & cilindraje == 1598
        replace min_CO2 = 304.2 if modelo == 2020 & cilindraje == 1395

        * valores proporcionales minimo
        replace min_CO2 = 351.5 + (351.5 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace min_CO2 = 259.15 + (259.15 / 1598) * (cilindraje - 1598) if modelo == 2020 & cilindraje >= 1600
        replace min_CO2 = 304.2 + (304.2 / 1395) * (cilindraje - 1395) if modelo == 2020 &  cilindraje >= 1400 &  cilindraje < 1600

        * missing
        replace min_CO2 = min_CO2 if missing(min_CO2)
        
    ** Media
        * Coincidencia exactas
            gen mean_CO2 = .
            replace mean_CO2 = 354.6 if modelo == 2020 & cilindraje == 1389
            replace mean_CO2 = 262.25 if modelo == 2020 & cilindraje == 1496
            replace mean_CO2 = 331.8 if modelo == 2020 & cilindraje == 1395

        * Proporcional media
            replace mean_CO2 = 354.6 + (354.6 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
            replace mean_CO2 = 262.25 + (262.25 / 1496) * (cilindraje - 1496) if modelo == 2020 & cilindraje >= 1600
            replace mean_CO2 = 331.8 + (331.8 / 1395) * (cilindraje - 1395) if modelo == 2020 & cilindraje >= 1400 &  cilindraje < 1600
        
        * missing
            replace mean_CO2 = mean_CO2 if missing(mean_CO2)
    
    ** Maximo

        *Coincidencia exactas
        gen max_CO2 = .
        replace max_CO2 = 359.8 if modelo == 2020 & cilindraje == 1389
        replace max_CO2 = 267 if modelo == 2020 & cilindraje == 1496
        replace max_CO2 = 346.5 if modelo == 2020 & cilindraje == 1395

        * valores proporcionales maximo
        replace max_CO2 = 359.8 + (359.8 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace max_CO2 = 267 + (267 / 1496) * (cilindraje - 1496) if modelo == 2020 & cilindraje >= 1600
        replace max_CO2 = 346.5 + (346.5 / 1395) * (cilindraje - 1395) if modelo == 2020 & cilindraje >= 1400 &  cilindraje < 1600

        * missing
        replace max_CO2 = max_CO2 if missing(max_CO2)


    ** Desviacion Estandar

        *Coincidencia exactas
        gen sd_CO2 = .
        replace sd_CO2 = 3.7 if modelo == 2020 & cilindraje == 1389
        replace sd_CO2 = 4.8 if modelo == 2020 & cilindraje == 1598
        replace sd_CO2 = 19.1 if modelo == 2020 & cilindraje == 1968

        * valores proporcionales sd
        replace sd_CO2 = 3.7 + (3.7 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace sd_CO2 = 4.8 + (4.8 / 1598) * (cilindraje - 1598) if modelo == 2020 & cilindraje >= 1600
        replace sd_CO2 = 19.1 + (19.1 / 1968) * (cilindraje - 1968) if modelo == 2020 & cilindraje >= 1400 &  cilindraje < 1600

        * missing
        replace sd_CO2 = sd_CO2 if missing(sd_CO2)

**# Eliminación observaciones vacías

     misstable summarize // Observar todas la variables
    // drop if missing(mean_CO2)

**# Kilometros

    gen Km = 15000
    gen Km_sd = 3000

**# Precio CO2

    gen precio_CO2_gramos = .
    replace precio_CO2_gramos = 23394.60
    label variable precio_CO2_gramos "Precio x toneladas"

**# Exportación a excel

   export excel using "$excel/Datos_tratados/excel/lineabase2020.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2020.dta", replace
