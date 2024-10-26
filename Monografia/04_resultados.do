*-------------------------------------------------------------------
*
*   Resultados
*       * Simulación 1: $23,394.60
*       * Simulación 2: $67,435.08
*       * Simulación 3: $219,057.37
*       
*-------------------------------------------------------------------


************************************************************************
*                     Simulación 1: $23,394.60
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
*                   Simulación 2: $67,435.08 (1.59 UVT)
************************************************************************

    ** Recaudo por año
    import excel "$dOutput/03_Simulacion/Simulacion_2_sinrisk.xlsx", sheet("Simulacion 2") firstrow clear

    keep ImpuestoActual_* impuestoPropuesta_*

    ** Distribución Monte Carlo
        import excel "$dOutput/03_Simulacion/Simulacion_2_sinrisk.xlsx", sheet("Datos simulación salidas") firstrow clear
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
*                        Simulación 3: $219,057.37
************************************************************************


