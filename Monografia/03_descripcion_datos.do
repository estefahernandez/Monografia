
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

        ** Agrupar la variable Clase
        gen clase_agrupada = ""
        replace clase_agrupada = "Automovil" if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
        replace clase_agrupada = "Camioneta" if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", ///
                                                    "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
        replace clase_agrupada = "Motocicleta" if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO", "CUADRICICLO", "MOTOCARRO")
        replace clase_agrupada = "Otro" if inlist(clase, "CUADRICICLO", "MOTOCARRO", "BUS", "BUS ELECTRICO", "BUSETA") ///
                                        | inlist(clase, "MICRO BUS", "CAMION", "TRACTO-CAMION", "VOLQUETA") ///
                                        | inlist(clase, "CAMPERO", "CAMPERO HIBRIDO")

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

        ** Grafica
        xtline count if inrange(mes_matricula, ym(2000,1), ym(2023,12)), overlay ///
                legend(on rows(1) pos(12) size(small) col(1) ring(0)) ///
                title("", size(10pt) color(black)) ///
                xtitle("Año", size(11pt) color(black)) ///
                ytitle("Número de Vehículos", size(11pt) color(black) margin(small)) ///
                xlabel(, format(%tmCCYY-NN) labsize(small) grid glp(dot) glc(black*0.2)) ///
                ylabel(, format(%9.0gc) labsize(small) grid glp(dot) glc(black*0.2)) ///
                plot1opts(lcolor(purple) lpattern(solid)) ///             // Automovil
                plot2opts(lcolor(orange red) lpattern(solid)) ///         // Camioneta
                plot3opts(lcolor("0 114 178") lpattern(solid)) ///             // Motocicleta
                plot4opts(lcolor("128 192 102") lpattern(solid))                  // Otro

    graph export "$dOutput/01_figura/evolucion_matricula.pdf",  replace

************************************************************************
*   Figura 2: Parque automotor por año
************************************************************************
 
