
*-------------------------------------------------------------------
*
*   Estadistica descriptiva
*       * Figura 1: Evolución del parque automotor por fecha de matricula
*       * Figura 2: Matriculas de Automoviles por tipo de Combustible (2015-2023)
*       * Figura 3: 
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
        replace clase_agrupada = "Automovil"    if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
        replace clase_agrupada = "Camioneta"    if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", ///
                                                                "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
        replace clase_agrupada = "Motocicleta"  if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO", "CUADRICICLO", "MOTOCARRO")
        replace clase_agrupada = "Otro"         if inlist(clase, "CUADRICICLO", "MOTOCARRO", "BUS", "BUS ELECTRICO", "BUSETA") ///
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
                    legend(on rows(1) pos(12) size(11pt) col(1)) ///
                    title("", size(10pt) color(black)) ///
                    xtitle("Año", size(11pt) color(black)) ///
                    ytitle("Número de Vehículos", size(11pt) color(black) margin(small)) ///
                    xlabel(, format(%tmCCYY-NN) labsize(small) grid glp(dot) glc(black*0.2)) ///
                    ylabel(0 2000 4000 6000, format(%9.0gc) labsize(small) grid glp(dot) glc(black*0.2)) ///
                    plot1opts(lcolor(purple) lpattern(solid)) ///             // Automovil
                    plot2opts(lcolor("255 121 95") lpattern(solid)) ///         // Camioneta
                    plot3opts(lcolor("0 114 178") lpattern(solid)) ///        // Motocicleta
                    plot4opts(lcolor("128 192 102") lpattern(solid))          // Otro

    graph export "$dOutput/01_figura/evolucion_matricula.pdf",  replace

************************************************************************
*  Figura 2: Matriculas de Automoviles por tipo de Combustible (2015-2023)
************************************************************************

    use "$dCl/GobA_imp_veh_2023.dta", clear

        * Agrupar la variable Clase
        gen clase_agrupada = ""
        replace clase_agrupada = "Automovil" if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
        replace clase_agrupada = "Camioneta" if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", ///
                                                    "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
        replace clase_agrupada = "Motocicleta" if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO")
        replace clase_agrupada = "Otro" if inlist(clase, "BUS", "BUS ELECTRICO", "BUSETA", "MICRO BUS", "CAMION", "TRACTO-CAMION", ///
                                                "VOLQUETA", "CAMPERO", "CAMPERO HIBRIDO")

        * Variable panel
        encode clase_agrupada, gen(clase_n)
        encode combustible, gen(comb_agrup)

        label define c_label 1 "Eléctrico" 2 "Gasolina" 3 "Híbrido"
        label values comb_agrup c_label

        * Modificar la fecha por meses
        gen fecha_matricula0 = date(fecha_matricula, "YMD")
        gen mes_matricula = mofd(fecha_matricula0)
        format mes_matricula %tm

        * Crear una variable de conteo
        gen count_matricula = 1

        * Collapsar la información
        collapse (sum) count_matricula, by(mes_matricula comb_agrup)

        * Volver Panel la base de datos
        xtset comb_agrup mes_matricula

        * Graficar la serie temporal
        xtline count_matricula if inrange(mes_matricula, ym(2015,1), ym(2023,12)), overlay ///
            title("", ring(0) size(medium) color(black)) ///
            xtitle("Año", size(11pt) color(black)) ///
            ytitle("Número de Vehículos", size(11pt) color(black) margin(small)) ///
            xlabel(, format(%tmCCYY-NN) labsize(small) grid glp(dot) glc(black*0.2)) ///
            ylabel(0 2500 5000 7500 10000, format(%9.0gc) labsize(small) grid glp(dot) glc(black*0.2)) ///
            legend(on rows(1) pos(12) size(11pt) col(1)) ///
            plot1opts(lcolor("128 192 102")) ///        // Electrico
            plot2opts(lcolor(purple)) ///               // Gasolina
            plot3opts(lcolor("255 121 95"))             // Híbrido

    graph export "$dOutput/01_figura/combustible.pdf",  replace

************************************************************************
*   Figura 3: Recaudo en los ultimos 10 años
************************************************************************
/*
    ** Grafica en porcentaje

        use "$dCl/imp_veh_Gob10.dta", clear

            * Variable numerica
            encode estado_pago, gen(estadopago_n)

            * Años
            gen periodo = vigencia
            format periodo %ty

            * Colapsar el impuesto por vigencia y estado de pago
            collapse (sum) impuesto, by(periodo estadopago_n)
            drop if missing(estadopago_n)

            * Total impuesto por año
            egen total_impuesto_periodo = total(impuesto), by(periodo)

            * Porcentaje 
            gen porcentaje = impuesto / total_impuesto_periodo * 100

            * Preparar datos para la gráfica
            collapse (sum) porcentaje, by(periodo estadopago_n)

        ** Grafica porcentaje

    graph   bar porcentaje, over(estadopago_n, label(labsize(small))) ///
            over(periodo, label(angle(0) labsize(small))) ///
            stack asyvars ///
            blabel(bar, position(center) format(%9.1f)) /// Ajuste para mostrar porcentaje dentro de las barras
            legend(order(1 "Descuento" 2 "Sin Descuento" 3 "Sanción") rows(1) position(bottom)) ///
            ytitle("Porcentaje del Impuesto Recaudado (%)", size(11pt)) ///
            title("") ///
            bar(1, fcolor("0 114 178%80") lwidth(none)) /// Color naranja
            bar(2, fcolor("128 192 102%80") lwidth(none)) /// Color verde
            bar(3, fcolor("255 121 95%80") lwidth(none)) /// Color gris
            plotregion(margin(0 0 0 12)) ///
            ylabel(, labsize(small) grid glp(dot) glc(black*0.2))


//graph export "$dOutput/01_figura/recaudo_10anos.pdf", as(pdf) name("Graph") replace
//graph export "$dOutput/01_figura/recaudo_10anos.pdf",  replace
*/
************************************************************************
*   Tabla 1: Recaudo en los ultimos 10 años
************************************************************************

        use "$dCl/imp_veh_Gob10.dta", clear

            * Convertir 'estado_pago' en una variable numérica
            encode estado_pago, gen(estadopago_n)

            * Crear la variable de periodo basado en la vigencia
            gen periodo = vigencia
            format periodo %ty

            * Colapsar el impuesto por vigencia y estado de pago
            collapse (sum) impuesto, by(periodo estadopago_n)
            drop if missing(estadopago_n)

            * Total impuesto por año
            egen total_impuesto_periodo = total(impuesto), by(periodo)

            * Porcentaje 
            gen porcentaje = impuesto / total_impuesto_periodo * 100

            * Colapsar los datos sumando 'impuesto' por vigencia y estado de pago
            collapse (sum) porcentaje impuesto , by(periodo estadopago_n)

            format impuesto %12.0fc
            replace impuesto = impuesto/1000000
            egen  total_imp = total(impuesto), by(periodo)

            reshape wide impuesto, i(periodo porcentaje total_imp) j(estadopago_n)
        
        export excel using"$dOutput/02_tabla/recaudo10.xlsx", firstrow(variables) replace


