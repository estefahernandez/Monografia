*-------------------------------------------------------------------
*
*   Resultados
*       * Comportamiento en 10 años de impuesto actual vs el impuesto propuesto
*       * Simulación 1
*       * Simulación 2
*       
*-------------------------------------------------------------------

************************************************************************
*               Impuesto actual vs Impuesto propuesta $23,394.60
************************************************************************

    import excel "$dOutput/03_Simulacion/Modelocon25mil_excel.xlsx", sheet("Sheet1") firstrow clear

        * Conservar estas variables
        keep ImpuestoActual_2024-ImpuestoActual_2033 impuestoPropuesta_2024-impuestoPropuesta_2033 

        * Sumar el recaudo de los periodos proyectados entre 2024 hasta 2033 por impuesto propuesto y actual
        collapse (sum) ImpuestoActual_2024-ImpuestoActual_2033 impuestoPropuesta_2024-impuestoPropuesta_2033 

        * Identificador
        gen id = _n

        * Convertir el formato de ancho a largo usando reshape
        reshape long ImpuestoActual_ impuestoPropuesta_, i(id) j(year)

        * Renombrar las variables para que tengan nombres más claros
        rename (ImpuestoActual_ impuestoPropuesta_) (impuesto_actual impuesto_propuesta)
        format impuesto_actual impuesto_propuesta %12.0fc 

        * Impuestos expresados en millones
        replace impuesto_actual = impuesto_actual/1000000
        replace impuesto_propuesta = impuesto_propuesta/1000000

    tempfile co2_23000
    save `co2_23000'

    * Figura
    twoway  (line impuesto_actual year, lcolor("128 192 102") lpattern(solid)) ///  // Línea para impuesto actual
            (line impuesto_propuesta year, lcolor(orange red) lpattern(dash)), /// // Línea para impuesto propuesto
            title("") ///
            xtitle("Años proyectados") ///
            ytitle("Recaudo en millones de pesos") ///
            xlabel(2024(1)2033,labsize(small) grid glp(dot) glc(black*0.2)) /// 
            ylabel(, labsize(small) grid glp(dot) glc(black*0.2)) /// // Etiquetas de los años en el eje X
            legend(label(1 "Impuesto Actual") label(2 "Impuesto Propuesto") ///
            rows(1) pos(12) size(small) col(1) ring(0))

************************************************************************
*       Impuesto actual vs Impuesto propuesta $1.59 UVT (67,435.08)
************************************************************************

    import excel "$dOutput/03_Simulacion/ModeloconUVTmil_excel.xlsx", sheet("Sheet1") firstrow clear

        * Conservar estas variables
        keep ImpuestoActual_2024-ImpuestoActual_2033 impuestoPropuesta_2024-impuestoPropuesta_2033 

        * Sumar el recaudo de los periodos proyectados entre 2024 hasta 2033 por impuesto propuesto y actual
        collapse (sum) ImpuestoActual_2024-ImpuestoActual_2033 impuestoPropuesta_2024-impuestoPropuesta_2033 

        * Identificador
        gen id = _n

        * Convertir el formato de ancho a largo usando reshape
        reshape long ImpuestoActual_ impuestoPropuesta_, i(id) j(year)

        * Renombrar las variables para que tengan nombres más claros
        rename (ImpuestoActual_ impuestoPropuesta_) (impuesto_actual_uvt impuesto_propuesta_uvt)
        format impuesto_actual impuesto_propuesta %12.0fc 

        * Impuestos expresados en millones
        replace impuesto_actual_uvt = impuesto_actual_uvt/1000000
        replace impuesto_propuesta_uvt = impuesto_propuesta_uvt/1000000

    tempfile co2_uvt
    save `co2_uvt'

    * Figura
    twoway  (line impuesto_actual_uvt year, lcolor("128 192 102") lpattern(solid)) ///  // Línea para impuesto actual
            (line impuesto_propuesta_uvt year, lcolor(orange red) lpattern(dash)), /// // Línea para impuesto propuesto
            title("") ///
            xtitle("Años proyectados") ///
            ytitle("Recaudo en millones de pesos") ///
            xlabel(2024(1)2033,labsize(small) grid glp(dot) glc(black*0.2)) /// 
            ylabel(, labsize(small) grid glp(dot) glc(black*0.2)) /// // Etiquetas de los años en el eje X
            legend(label(1 "Impuesto Actual") label(2 "Impuesto Propuesto") ///
            rows(1) pos(12) size(small) col(1) ring(0))


************************************************************************
*                     Simulación 1: precio 23,394.60
************************************************************************

    import excel "$dOutput/03_Simulacion/Modelocon25mil_excel.xlsx", sheet("Hoja1") firstrow clear
    rename simlaucion simulacion1
    save "$dCl/simulación1.dta", replace

    histogram simulacion1, frequency ///
    title("") ///
    xtitle("Valor de la Variable") ///
    ytitle("Frecuencia") ///
    xlabel(,labsize(small) grid glp(dot) glc(black*0.2)) /// 
    ylabel(, labsize(small) grid glp(dot) glc(black*0.2)) 


************************************************************************
*                   Simulación 2: $1.59 UVT (67,435.08)
************************************************************************

    import excel "$dOutput/03_Simulacion/ModeloconUVTmil_excel.xlsx", sheet("Datos simulación salidas") firstrow clear
        drop in 1/4
        rename (B C) (obs simulacion2) 
        destring obs simulacion2, replace
        format simulacion2 %12.0fc 
    save "$dCl/simulacion2.dta", replace

    histogram simulacion2, frequency ///
    title("") ///
    xtitle("Valor de la Variable") ///
    ytitle("Frecuencia") ///
    xlabel(,labsize(small) grid glp(dot) glc(black*0.2)) /// 
    ylabel(, labsize(small) grid glp(dot) glc(black*0.2)) 


************************************************************************
*                        Simulación 3: 233.000
************************************************************************


