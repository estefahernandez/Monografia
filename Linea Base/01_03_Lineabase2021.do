
*-------------------------------------------------------------------
*
*   Linea Base 2021
*     
*   1. Limpieza de los datos
*      
*      
*   2. 
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
    keep if modelo == 2021

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

        drop if cilindraje <= 800

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
        replace min_CO2 = 279.35 

        
    ** Media
        * Coincidencia exactas
            gen mean_CO2 = .
            replace mean_CO2 = 285.35 if modelo == 2022 & cilindraje == 1998

            replace mean_CO2 = mean_CO2 if missing(mean_CO2)
    
    ** Maximo

        *Coincidencia exactas
        gen max_CO2 = .
        replace max_CO2 = 293.6 if modelo == 2022 & cilindraje == 1998



    ** Desviacion Estandar

        *Coincidencia exactas
        gen sd_CO2 = .
        replace sd_CO2 = 6.05 if modelo == 2022 & cilindraje == 1998


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

   export excel using "$excel/Datos_tratados/excel/lineabase2022.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2022.dta", replace
