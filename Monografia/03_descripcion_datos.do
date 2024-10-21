
*-------------------------------------------------------------------
*
*   Estadistica descriptiva
*       * Figura 1: Evolución del parque automotor por fecha de matricula
*       * 
*       
*-------------------------------------------------------------------

    * Plantilla figuras
    graph set window fontface "Times New Roman"

************************************************************************
*   Figura 1: Evolución del parque automotor por fecha de matricula
************************************************************************
 
    use "$dCl/GobA_imp_veh_2023.dta", clear

        ** Agrupar la clase de vehiculos
        gen clase_agrupada = ""
        replace clase_agrupada = "Automovil" if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
        replace clase_agrupada = "Bus" if inlist(clase, "BUS", "BUS ELECTRICO", "BUSETA", "MICRO BUS")
        replace clase_agrupada = "Camion" if inlist(clase, "CAMION", "TRACTO-CAMION", "VOLQUETA")
        replace clase_agrupada = "Camioneta" if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
        replace clase_agrupada = "Campero" if inlist(clase, "CAMPERO", "CAMPERO HIBRIDO")
        replace clase_agrupada = "Motocicleta" if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO", "CUADRICICLO", "MOTOCARRO")
        // replace clase_agrupada = "Otro" if inlist(clase, "CUADRICICLO", "MOTOCARRO")

        * Variable panel
        encode clase_agrupada , gen(clase_n)

        * Modificar la fecha por meses 
        gen fecha_matricula0 = date(fecha_matricula, "YMD")
        gen mes_matricula = mofd(fecha_matricula0)
        format mes_matricula %tm

        * Crear una variable de conteo
        gen count_matricula = 1

        ** Collapsar la información
        collapse (sum) count_matricula, by(mes_matricula  clase_n)

        ** Volver Panel la base de datos
        xtset clase_n mes_matricula 

            xtline count if inrange(mes_matricula, ym(2000,1), ym(2023,12)), overlay ///
            legend(on rows(1) pos(12) size(10pt) col(1)) ///
            title("", size(medium) color(black)) ///
            xtitle("Año", size(10pt)  color(black)) ///
            ytitle("Número de Vehículos", size(10pt) color(black) margin(small)) ///
            xlabel(, format(%tmCCYY-NN) labsize(small) grid glp(dot) glc(black*0.2)) ///
            ylabel(, format(%9.0gc) labsize(small) grid glp(dot) glc(black*0.2)) ///
            plot1opts(lcolor(cyan)) ///
            plot2opts(lcolor(orange)) ///
            plot3opts(lcolor(pink))

************************************************************************
*   Figura 2: Parque automotor por año
************************************************************************
 
    use "$dCl/GobA_imp_veh_2023.dta", clear


        ** Modificar la fecha por año
        gen ano_matricula = yofd(fecha_matricula)
        format ano_matricula %ty

            * Crear una variable de conteo
        gen count_matricula = 1

        ** Collapsar la información
        collapse (sum) count_matricula, by(ano_matricula  clase_n)

        ** Volver Panel la base de datos
        xtset clase_n ano_matricula 

        * Generar la gráfica
        xtline count if inrange(ano_matricula,2000 , 2023) , overlay ///
            legend(on rows(1) pos(12) size(small)) ///
            title("", size(medium) color(black)) ///
            xtitle("Año del Modelo", size(medium) color(black)) ///
            ytitle("Número de Vehículos", size(medium) color(black) margin(medium))