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
*  Impuesto actual vs Impuesto propuesta $1.59 UVT (67,435.08) y 23,394.60
************************************************************************

    * Combinación de impuesto uvt, 23.000 e impuetso actual 
    merge 1:1 year using `co2_23000', nogen keep(matched) keepusing(impuesto_propuesta)

    * Figura
    twoway  (line impuesto_actual_uvt year, lcolor("128 192 102") lpattern(solid)) ///  // Línea para impuesto actual
            (line impuesto_propuesta_uvt year, lcolor(orange red) lpattern(solid)) /// // Línea para impuesto propuesto
            (line impuesto_propuesta year, lcolor("0 114 178") lpattern(solid)), /// // Línea para impuesto propuesto
            title("") ///
            xtitle("Años proyectados") ///
            ytitle("Recaudo en millones de pesos") ///
            xlabel(2024(1)2033,labsize(small) grid glp(dot) glc(black*0.2)) /// 
            ylabel(, labsize(small) grid glp(dot) glc(black*0.2)) /// // Etiquetas de los años en el eje X
            legend(order(1 "Impuesto Actual" 2 "Impuesto Propuesto UVT" 3 "Impuesto Propuesto 23.000") ///
            col(1) row(1)  position(12) ring(0) nobox size(*0.8) region(lstyle(none)))

************************************************************************
*                           Simulación 1
************************************************************************

    import excel "$dOutput/03_Simulacion/Modelocon25mil_excel.xlsx", sheet("Hoja1") firstrow clear
    save "$dCl/simulación1.dta", replace

    histogram simlaucion, frequency ///
    addplot(kdensity ) ///
    title("Histograma con Curva de Densidad") ///
    xtitle("Valor de la Variable") ///
    ytitle("Frecuencia")


************************************************************************
*                           Simulación 2
************************************************************************

save "$dCl/simulación2.dta", replace

