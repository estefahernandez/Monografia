*-------------------------------------------------------------------
*
*   Resultados
*       * Simulación 1: $23,394.60
*       * Simulación 2: $67,435.08
*       * Simulación 3: $219,057.37
*       
*-------------------------------------------------------------------

    * Plantilla figuras
    graph set window fontface "Times New Roman"

************************************************************************
*                     Simulación 1: $23,394.60
************************************************************************

    import excel "$dOutput/03_Simulacion/Simulacion_1.xlsx", sheet("Simulacion 1") firstrow clear

        keep ImpuestoActual_* impuestoPropuesta_*
        format ImpuestoActual_* impuestoPropuesta_* %12.0fc 

        collapse (sum) ImpuestoActual_* impuestoPropuesta_*

        * Identificador
        gen id = _n

        * Convertir el formato de ancho a largo usando reshape
        reshape long ImpuestoActual_ impuestoPropuesta_, i(id) j(year)

        * Impuestos expresados en millones
        replace ImpuestoActual_ = ImpuestoActual_/1000000
        replace impuestoPropuesta_ = impuestoPropuesta_/1000000

        rename (ImpuestoActual_ impuestoPropuesta_) (imp_actual imp_p1)
        drop id

    tempfile co2_p1
    save `co2_p1'

    ** Simulación 
    import excel "$dOutput/03_Simulacion/Simulacion_1.xlsx", sheet("Datos simulación salidas") firstrow clear
        drop in 1/4
        rename (B C) (obs simulacion1) 
        destring obs simulacion1, replace
        format simulacion1 %12.0fc 
    tempfile sim_1
    save `sim_1'


************************************************************************
*                   Simulación 2: $67,435.08 (1.59 UVT)
************************************************************************

    import excel "$dOutput/03_Simulacion/Simulacion_2.xlsx", sheet("Simulacion 2") firstrow clear

        keep ImpuestoActual_* impuestoPropuesta_*
        format ImpuestoActual_* impuestoPropuesta_* %12.0fc 

        collapse (sum) ImpuestoActual_* impuestoPropuesta_*

        * Identificador
        gen id = _n

        * Convertir el formato de ancho a largo usando reshape
        reshape long ImpuestoActual_ impuestoPropuesta_, i(id) j(year)

        * Impuestos expresados en millones
        replace ImpuestoActual_ = ImpuestoActual_/1000000
        replace impuestoPropuesta_ = impuestoPropuesta_/1000000

        rename (ImpuestoActual_ impuestoPropuesta_) (imp_actual imp_p2)
        drop imp_actual id

    tempfile co2_p2
    save `co2_p2'

    ** Simulación 
    import excel "$dOutput/03_Simulacion/Simulacion_2.xlsx", sheet("Datos simulación salidas") firstrow clear
        drop in 1/4
        rename (B C) (obs simulacion2) 
        destring obs simulacion2, replace
        format simulacion2 %12.0fc 
    tempfile sim_2
    save `sim_2'


************************************************************************
*                        Simulación 3: $219,057.37
************************************************************************

    import excel "$dOutput/03_Simulacion/Simulacion_3.xlsx", sheet("simulacion3") firstrow clear

        keep ImpuestoActual_* impuestoPropuesta_*
        format ImpuestoActual_* impuestoPropuesta_* %12.0fc 

        collapse (sum) ImpuestoActual_* impuestoPropuesta_*

        * Identificador
        gen id = _n

        * Convertir el formato de ancho a largo usando reshape
        reshape long ImpuestoActual_ impuestoPropuesta_, i(id) j(year)

        * Impuestos expresados en millones
        replace ImpuestoActual_ = ImpuestoActual_/1000000
        replace impuestoPropuesta_ = impuestoPropuesta_/1000000

        rename (ImpuestoActual_ impuestoPropuesta_) (imp_actual imp_p3)
        drop imp_actual id

    tempfile co2_p3
    save `co2_p3'

    ** Simulación 
    import excel "$dOutput/03_Simulacion/Simulacion_3.xlsx", sheet("Datos simulación salidas") firstrow clear
        drop in 1/4
        rename (B C) (obs simulacion3) 
        destring obs simulacion3, replace
        format simulacion3 %12.0fc 
    tempfile sim_3
    save `sim_3'

************************************************************************
*    Figura: linea de proyección en el tiempo a 10 años
************************************************************************

    use `co2_p1', clear
        merge 1:1 year using `co2_p2', nogen keep(match)
        merge 1:1 year using `co2_p3', nogen keep(match)
    save "$dCl/proyeccion_comparativa.dta", replace

    * Figura
    twoway  (line imp_actual year, lcolor("255 121 95") lpattern(solid) lwidth(medthick)) ///  // Línea para impuesto actual
            (line imp_p1 year, lcolor(purple) lpattern(dash) lwidth(medthick)) /// // Línea para impuesto propuesto
            (line imp_p2 year, lcolor("0 114 178") lpattern(dash) lwidth(medthick)) /// // Línea para impuesto propuesto
            (line imp_p3 year, lcolor("128 192 102") lpattern(dash) lwidth(medthick)), /// // Línea para impuesto propuesto
            title("") ///
            xtitle("Años de Proyección",  size(11pt)) ///
            ytitle("Recaudo en millones de pesos",  size(11pt)) ///
            xlabel(2024(1)2033, labsize(small) grid glp(dot) glc(black*0.2)) /// 
            ylabel(0 10000 20000 30000 40000 50000, labsize(small) grid glp(dot) glc(black*0.2)) /// // Etiquetas de los años en el eje X
            legend(order(1 "Impuesto Actual" 2 "Precio 1" 3 "Precio 2" 4 "Precio 3") ///
            rows(1) pos(12) size(11pt) col(1))

    graph export "$dOutput/01_figura/linea_proyección_precios.pdf",  replace

************************************************************************
*    Figura: Distribución  de simulaciones
************************************************************************

    use `sim_1', clear
        merge 1:1 obs using `sim_2', nogen keep(match)
        merge 1:1 obs using `sim_3', nogen keep(match)
    save "$dCl/simulaciones.dta", replace

    * Simulación 1
    twoway  (histogram simulacion1, color("0 114 178%60")  width(5) density), ///
            title("") ///
            xtitle("Simulación 1", size(11pt) color(black)) ///
            ytitle("Densidad", size(11pt) color(black) margin(small)) ///
            xlabel(26600 26700 26800, labsize(small) grid glp(dot) glc(black*0.2)) ///
            ylabel(, labsize(small) format(%9.3f) grid glp(dot) glc(black*0.2)) ///
            legend(order(1 "Distribución 1") rows(1) pos(12) size(small) col(1)) ///
            name(graf1, replace)

    graph export "$dOutput/01_figura/simulacion1.pdf",  replace

    * Simulación 2
    twoway  (histogram simulacion2, color("128 192 102%60") width(5) density), ///
            title("") ///
            xtitle("Simulación 2", size(11pt) color(black)) ///
            ytitle("Densidad", size(11pt) color(black) margin(small)) ///
            xlabel(76600 77000 77400, labsize(small) grid glp(dot) glc(black*0.2)) ///
            ylabel(, labsize(small) format(%9.3f) grid glp(dot) glc(black*0.2)) ///
            legend(order(1 "Distribución 2") rows(1) pos(12) size(small) col(1)) ///
            name(graf2, replace)

    graph export "$dOutput/01_figura/simulacion2.pdf",  replace

    * Simulación 3
    twoway  (histogram simulacion3, color("255 121 95%60") width(5) density), ///
            title("") ///
            xtitle("Simulación 3", size(11pt) color(black)) ///
            ytitle("Densidad", size(11pt) color(black) margin(small)) ///
            xlabel(249000 250000 251000, labsize(small) grid glp(dot) glc(black*0.2)) ///
            ylabel(, labsize(small) format(%9.4f) grid glp(dot) glc(black*0.2)) ///
            legend(order(1 "Distribución 3") rows(1) pos(12) size(small) col(1)) ///
            name(graf3, replace)

    graph export "$dOutput/01_figura/simulacion3.pdf",  replace

    * Figuras combinadas
    graph combine graf1 graf2 graf3, col(3) title("")

    graph export "$dOutput/01_figura/simulacion_combinada.pdf",  replace

exit