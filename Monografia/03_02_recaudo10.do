*-------------------------------------------------------------------
*
*   Do-file: Añadir en un .dta el recaudo desde 2014 hasta 2023
*
*-------------------------------------------------------------------

    * ruta
    local ruta_archivo "$dRaw/Parque_automotor_impuesto_vehicular_año_fiscal_"
    local imp_veh_ imp_veh_

    * Cargar, guardas y append 2014-2023
    clear
        forvalues year = 2014/2023 {
            * Carga excels
            import delimited "`ruta_archivo'`year'.csv", clear
            * Guardar .dta
            save "$dCl/`imp_veh_'`year'.dta", replace
            * Append
            if `year' == 2014 {
                // Si es el primer archivo, simplemente guarda los datos como base
                save "$dCl/imp_veh_2014_2023.dta", replace
            } 
            else {
                // Si no es el primer archivo, haz el append al master
                append using "$dCl/imp_veh_2014_2023.dta"
                save "$dCl/imp_veh_2014_2023.dta", replace
            }
        }


    * Restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

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

    order fecha_matricula, after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula
    destring impuesto, replace force

    * Fecha de pago 2014
        gen estado_pago = ""
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2014", "DMY") & fecha_pago <= date("01apr2014", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("02apr2014", "DMY") & fecha_pago <= date("18jul2014", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("19jul2014", "DMY")

    * Fecha de pago 2015
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2015", "DMY") & fecha_pago <= date("20mar2015", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("21mar2015", "DMY") & fecha_pago <= date("17jul2015", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("18jul2015", "DMY")

    * Fecha de pago 2016
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2016", "DMY") & fecha_pago <= date("29apr2016", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("30apr2016", "DMY") & fecha_pago <= date("15jul2016", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("16jul2016", "DMY")

    * Fecha de pago 2017
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2017", "DMY") & fecha_pago <= date("17mar2017", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("18mar2017", "DMY") & fecha_pago <= date("14jul2017", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("15jul2016", "DMY")

    * Fecha de pago 2018
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2018", "DMY") & fecha_pago <= date("16mar2018", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("17mar2018", "DMY") & fecha_pago <= date("13jul2018", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("14jul2018", "DMY")

    * Fecha de pago 2019
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2019", "DMY") & fecha_pago <= date("22mar2019", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("23mar2019", "DMY") & fecha_pago <= date("19jul2019", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("20jul2019", "DMY")

    * Fecha de pago 2020
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2020", "DMY") & fecha_pago <= date("20mar2020", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("21mar2020", "DMY") & fecha_pago <= date("17jul2020", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("18jul2020", "DMY")

    * Fecha de pago 2021
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2021", "DMY") & fecha_pago <= date("16apr2021", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("17apr2021", "DMY") & fecha_pago <= date("18jul2021", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("19jul2021", "DMY")

    * Fecha de pago 2022
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2022", "DMY") & fecha_pago <= date("30apr2022", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("01may2022", "DMY") & fecha_pago <= date("18jul2022", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("19jul2022", "DMY")

    * Fecha de pago 2023
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2023", "DMY") & fecha_pago <= date("21apr2023", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("22apr2023", "DMY") & fecha_pago <= date("21jul2023", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("22jul2023", "DMY")

        label variable estado_pago "ESTADO DE PAGO"

save "$dCl/imp_veh_Gob10.dta", replace

exit 