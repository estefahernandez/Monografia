*-------------------------------------------------------------------
*
*  Estadisticas descriptivas
*
*-------------------------------------------------------------------


**# ---------- Figura: Evolución del parque automotor 2023 por fecha de matricula

    ***** Figura: Parque automotor por clase agrupada

        * Datos
        use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

        ** Agrupar la variable Clase
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
        gen month_matricula = mofd(fecha_matricula)
        format month_matricula %tm

        * Crear una variable de conteo
        gen count_matricula = 1

        ** Collapsar la información
        collapse (sum) count_matricula, by(month_matricula  clase_n)

        ** Volver Panel la base de datos
        xtset clase_n month_matricula 

            xtline count if inrange(month_matricula, ym(2000,1), ym(2023,12)), overlay ///
            legend(on rows(1) pos(12) size(small) col(1)) ///
            title("", size(medium) color(black)) ///
            xtitle("Año", size(small)  color(black)) ///
            ytitle("Número de Vehículos", size(small) color(black) margin(small)) ///
            xlabel(, format(%tmCCYY-NN) labsize(small)) ///
            ylabel(, format(%9.0gc) labsize(small)) ///
            plot1opts(lcolor(cyan)) ///
            plot2opts(lcolor(orange)) ///
            plot3opts(lcolor(pink))


        //graph export "${figuras}/vehiculo_matriculas.pdf",  replace


    ***** Figura: Parque automotor  --> Camion, Bus, Campero

        * Filtrar los datos para cada grupo
        preserve

            use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

            ** Agrupar la variable Clase
            gen clase_agrupada = ""

            replace clase_agrupada = "Automovil" if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
            replace clase_agrupada = "Bus" if inlist(clase, "BUS", "BUS ELECTRICO", "BUSETA", "MICRO BUS")
            replace clase_agrupada = "Camion" if inlist(clase, "CAMION", "TRACTO-CAMION", "VOLQUETA")
            replace clase_agrupada = "Camioneta" if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
            replace clase_agrupada = "Campero" if inlist(clase, "CAMPERO", "CAMPERO HIBRIDO")
            replace clase_agrupada = "Motocicleta" if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO", "CUADRICICLO", "MOTOCARRO")

            * Variable panel
            encode clase_agrupada , gen(clase_n)
            
            keep if clase_n == 2 | clase_n == 3 | clase_n == 5

            * Modificar la fecha por meses 
            gen month_matricula = mofd(fecha_matricula)
            format month_matricula %tm

            * Crear una variable de conteo
            gen count_matricula = 1

            ** Collapsar la información
            collapse (sum) count_matricula, by(month_matricula  clase_n)

            ** Volver Panel la base de datos
            xtset clase_n month_matricula 

            ** Graficar el Grupo 1
            xtline count_matricula if inrange(month_matricula, ym(2000,1), ym(2023,12)), overlay ///
                legend(on rows(1) pos(12) size(small) col(1)) ///
                title("Grupo 1: Camión, Bus, Campero", size(medium) color(black)) ///
                xtitle("Año", size(small)  color(black)) ///
                ytitle("Número de Vehículos", size(small) color(black) margin(small)) ///
                xlabel(, format(%tmCCYY-NN) labsize(small)) ///
                ylabel(, format(%9.0gc) labsize(small)) ///
                plot1opts(lcolor(cyan)) ///
                plot2opts(lcolor(orange)) ///
                plot3opts(lcolor(pink))

        restore


    ***** Figura: Parque automotor  --> Automovil, Camioneta, Motocicleta

        * Filtrar los datos para cada grupo
        preserve
        
            use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

            ** Agrupar la variable Clase
            gen clase_agrupada = ""

            replace clase_agrupada = "Automovil" if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
            replace clase_agrupada = "Bus" if inlist(clase, "BUS", "BUS ELECTRICO", "BUSETA", "MICRO BUS")
            replace clase_agrupada = "Camion" if inlist(clase, "CAMION", "TRACTO-CAMION", "VOLQUETA")
            replace clase_agrupada = "Camioneta" if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
            replace clase_agrupada = "Campero" if inlist(clase, "CAMPERO", "CAMPERO HIBRIDO")
            replace clase_agrupada = "Motocicleta" if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO", "CUADRICICLO", "MOTOCARRO")

            * Variable panel
            encode clase_agrupada , gen(clase_n)

            keep if clase_n == 1 | clase_n == 4 | clase_n == 6

            * Modificar la fecha por meses 
            gen month_matricula = mofd(fecha_matricula)
            format month_matricula %tm

            * Crear una variable de conteo
            gen count_matricula = 1

            ** Collapsar la información
            collapse (sum) count_matricula, by(month_matricula  clase_n)

            ** Volver Panel la base de datos
            xtset clase_n month_matricula 

            ** Graficar el Grupo 1
            xtline count_matricula if inrange(month_matricula, ym(2000,1), ym(2023,12)), overlay ///
                legend(on rows(1) pos(12) size(small) col(1)) ///
                title("Grupo 1: Automovil, Camioneta, Motocicleta", size(medium) color(black)) ///
                xtitle("Año", size(small)  color(black)) ///
                ytitle("Número de Vehículos", size(small) color(black) margin(small)) ///
                xlabel(, format(%tmCCYY-NN) labsize(small)) ///
                ylabel(, format(%9.0gc) labsize(small)) ///
                plot1opts(lcolor(purple)) ///
                plot2opts(lcolor(orange red)) ///
                plot3opts(lcolor(ebblue)) ///
                yscale(range(0 .))   // Esta línea asegura que el eje y comienza en 0

        restore


    ***** Figura: Parque automotor  --> Automovil, Camioneta, Motocicleta, otros: Camion, Bus, Campero

        * Filtrar los datos para cada grupo
        preserve
        
            use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

            ** Agrupar la variable Clase
            gen clase_agrupada = ""

            replace clase_agrupada = "Automovil" if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
            replace clase_agrupada = "Camioneta" if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
            replace clase_agrupada = "Motocicleta" if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO", "CUADRICICLO", "MOTOCARRO")
            replace clase_agrupada = "Otro" if inlist(clase, "CUADRICICLO", "MOTOCARRO", "BUS", "BUS ELECTRICO", "BUSETA") ///
            | inlist(clase, "MICRO BUS", "CAMION", "TRACTO-CAMION", "VOLQUETA") ///
            | inlist(clase, "CAMPERO", "CAMPERO HIBRIDO")


            * Variable panel
            encode clase_agrupada , gen(clase_n)

            * Modificar la fecha por meses 
            gen month_matricula = mofd(fecha_matricula)
            format month_matricula %tm

            * Crear una variable de conteo
            gen count_matricula = 1

            ** Collapsar la información
            collapse (sum) count_matricula, by(month_matricula  clase_n)

            ** Volver Panel la base de datos
            xtset clase_n month_matricula 

            ** Graficar el Grupo 1
            xtline count_matricula if inrange(month_matricula, ym(2000,1), ym(2023,12)), overlay ///
                legend(on rows(1) pos(12) size(small) col(1)) ///
                title("", size(small) color(black)) ///
                xtitle("Año", size(small)  color(black)) ///
                ytitle("Número de Vehículos", size(small) color(black) margin(small)) ///
                xlabel(, format(%tmCCYY-NN) labsize(small)) ///
                ylabel(, format(%9.0gc) labsize(small)) ///
                plot1opts(lcolor(purple)) ///
                plot2opts(lcolor(orange red)) ///
                plot3opts(lcolor(ebblue)) ///
                yscale(range(0 .))

                graph export "${figuras}/matricula_vehiculo2.pdf",  replace

        restore

    ***** Figura: Parque automotor por año

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



**# ---------- Figura: Evolución del parque automotor 2023 por modelo del vehículo

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

    gen clase_agrupada = ""

    replace clase_agrupada = "Automovil" if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
    replace clase_agrupada = "Bus" if inlist(clase, "BUS", "BUS ELECTRICO", "BUSETA", "MICRO BUS")
    replace clase_agrupada = "Camion" if inlist(clase, "CAMION", "TRACTO-CAMION", "VOLQUETA")
    replace clase_agrupada = "Camioneta" if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
    replace clase_agrupada = "Campero" if inlist(clase, "CAMPERO", "CAMPERO HIBRIDO")
    replace clase_agrupada = "Motocicleta" if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO", "CUADRICICLO", "MOTOCARRO")

    encode clase_agrupada , gen(clase_n)

    ** Modelo
    gen year_modelo = modelo
    format year_modelo %ty

    * Crear una variable de conteo
    gen count_modelo = 1

    ** Collapsar la información
    collapse (sum) count_modelo, by(year_modelo  clase_n)

    ** Volver Panel la base de datos
    xtset clase_n year_modelo

    * Generar la gráfica
    xtline count if inrange(year_modelo, 2000, 2023), overlay ///
        legend(on rows(1) pos(12) size(small) col(1)) ///
        title("", size(medium) color(black)) ///
        xtitle("Año", size(small) color(black)) ///
        ytitle("Número de Vehículos", size(small) color(black) margin(small)) ///
        xlabel(, labsize(small)) ///
        ylabel(, format(%9.0gc) labsize(small)) ///
        plot1opts(lcolor(cyan)) ///
        plot2opts(lcolor(lemon)) ///
        plot3opts(lcolor(pink)) ///
        plot4opts(lcolor(yellow)) ///
        plot5opts(lcolor(purple)) ///
        plot6opts(lcolor(orange))


    // graph export "${figuras}/vehiculo_modelo.pdf",  replace



**# ---------- Figura: Combustible

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

        ** Agrupar la variable Clase
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
    keep if clase_n == 1

    gen combustible_agrupada = ""
    replace combustible_agrupada = "Eletricos" if combustible == "ELECTRICO" 
    replace combustible_agrupada = "Gasolina" if combustible == "GASOLINA" 
    replace combustible_agrupada = "Hibrido" if combustible == "GASOLINA & ELECTRICO" 

    *** Matriculas

    ** panel
    encode combustible_agrupada , gen(combustible_n)

            // gen ano_matricula = yofd(fecha_matricula)
            // format ano_matricula %ty

    ** Modificar la fecha por meses 
    gen month_matricula = mofd(fecha_matricula)
    format month_matricula %tm

    * Crear una variable de conteo
    gen count_matricula = 1

    ** Collapsar la información
    collapse (sum) count_matricula, by(month_matricula  combustible_n)

    ** Volver Panel la base de datos
    xtset combustible_n month_matricula 

    * Generar la gráfica
    xtline count_matricula if inrange(month_matricula, ym(2015,1), ym(2023,12)), overlay ///
        legend(on rows(1) pos(12) size(small) col(1) ring(0)) ///
        title("", size(medium) color(black)) ///
        xtitle("Año", size(small)  color(black)) ///
        ytitle("Número de Vehículos", size(small) color(black) margin(small)) ///
        xlabel(, format(%tmCCYY-NN) labsize(small)) ///
        ylabel(, format(%9.0gc) labsize(small)) ///
        plot1opts(lcolor(cyan)) ///
        plot2opts(lcolor(orange)) ///
        plot3opts(lcolor(pink))

    //graph export "${figuras}/Combustible_matricula2.pdf",  replace


**# ---------- Figura: Recaudo hace 10 años

    ** Figura: Mensual

        use "$datacl/recaudo_total_agregado", clear

        * Convertir 'estado_pago' en una variable numérica
        encode estado_pago, gen(estadopago_n)

        * Crear la variable de fecha mensual basada en 'fecha_pago'
        gen month_impuesto = mofd(fecha_pago)
        format month_impuesto %tm

        * Colapsar los datos sumando 'impuesto' por mes y estado de pago
        collapse (sum) impuesto, by(month_impuesto estadopago_n)

        * Eliminar observaciones con valores faltantes en 'estadopago_n'
        drop if missing(estadopago_n)

        * Formatear la variable 'impuesto' para que esté en millones de pesos
        gen impuesto_n = impuesto / 1000000

        * Configurar los datos en formato panel (serie temporal)
        xtset month_impuesto estadopago_n

        * Generar la gráfica con 'twoway line'
        twoway (line impuesto_n month_impuesto if estadopago_n == 1, lcolor(cyan)) ///
            (line impuesto_n month_impuesto if estadopago_n == 2, lcolor(orange)) ///
            (line impuesto_n month_impuesto if estadopago_n == 3, lcolor(pink)), ///
            legend(label(1 "Descuento") label(2 "Sin Descuento") label(3 "Sanción") pos(3) col(1)) ///
            title("Evolución Mensual del Recaudo del Impuesto por Estado de Pago") ///
            xtitle("Fecha (Año-Mes)") ytitle("Recaudo del Impuesto (Millones de Pesos)") ///
            xlabel(, format(%tmCCYY-NN) labsize(small)) ///
            ylabel(, format(%9.0gc) labsize(small))

    

    ** Figura fecha de pago por año

        use "$datacl/recaudo_total_agregado", clear

            *Variable panel
            encode estado_pago , gen(estadopago_n)

            * Fecha por año
            gen year_modelo = yofd(fecha_pago)
            format year_modelo %ty

            * Colapsar los datos por vigencia 
            collapse (sum) impuesto, by(year_modelo estadopago_n)

            drop if missing(estadopago_n)

            format impuesto %12.0fc

            gen impuesto_n = impuesto/1000000

            ** Volver Panel la base de datos
            xtset year_modelo estadopago_n 

            * Generar la gráfica
            twoway (line impuesto_n year_modelo if estadopago_n == 1, lcolor(cyan)) ///
                (line impuesto_n year_modelo if estadopago_n == 2, lcolor(orange)) ///
                (line impuesto_n year_modelo if estadopago_n == 3, lcolor(pink)), ///
                legend(label(1 "Descuento") label(2 "Sin Descuento") label(3 "Sanción") pos(3)  col(1)) ///
                title("") ///
                xtitle("Año") ytitle("Recaudo del Impuesto (Millones de Pesos)") ///
                xlabel(2014(1)2023, labsize(small)) ///
                ylabel(, format(%9.0gc)  labsize(small))

    ** Figura Vigencia

            use "$datacl/recaudo_total_agregado", clear

            *Variable panel
            encode estado_pago , gen(estadopago_n)

            * Vigencia
            gen periodo = vigencia
            format periodo %ty

            * Colapsar los datos por vigencia 
            collapse (sum) impuesto, by(periodo estadopago_n)

            drop if missing(estadopago_n)

            format impuesto %12.0fc

            gen impuesto_n = impuesto/1000000

            ** Volver Panel la base de datos
            xtset periodo estadopago_n 

            * Generar la gráfica
            twoway (line impuesto_n periodo if estadopago_n == 1, lcolor(cyan)) ///
                (line impuesto_n periodo if estadopago_n == 2, lcolor(orange)) ///
                (line impuesto_n periodo if estadopago_n == 3, lcolor(pink)), ///
                legend(label(1 "Descuento") label(2 "Sin Descuento") label(3 "Sanción") pos(3)  col(1)) ///
                title("") ///
                xtitle("Año") ytitle("Recaudo del Impuesto (Millones de Pesos)") ///
                xlabel(2014(1)2023, labsize(small)) ///
                ylabel(, format(%9.0gc)  labsize(small))


    ** Figura Recaudo total

            use "$datacl/recaudo_total_agregado", clear

            * Crear una variable de conteo
            gen count_matricula = 1

            * Colapsar los datos por vigencia 
            collapse (sum) count_matricula, by(impuesto fecha_pago)

            ** Volver Panel la base de datos
            // xtset periodo  

            twoway (line impuesto fecha_pago)

    ** Recaudo por porcentaje

    use "$datacl/recaudo_total_agregado", clear

        * Convertir 'estado_pago' en una variable numérica
        encode estado_pago, gen(estadopago_n)

        * Crear la variable de periodo basado en la vigencia
        gen periodo = vigencia
        format periodo %ty

        * Colapsar los datos sumando 'impuesto' por vigencia y estado de pago
        collapse (sum) impuesto, by(periodo estadopago_n)

        * Eliminar observaciones con valores faltantes en 'estadopago_n'
        drop if missing(estadopago_n)

        * Calcular el total del impuesto recaudado por cada periodo (año)
        bysort periodo: egen total_impuesto = total(impuesto)

        * Calcular el porcentaje del impuesto por estado de pago
        gen porcentaje_impuesto = (impuesto / total_impuesto) * 100

        * Formatear el porcentaje
        format porcentaje_impuesto %9.2f

        * Generar la gráfica mostrando el porcentaje de impuesto recaudado por estado de pago
        twoway (line porcentaje_impuesto periodo if estadopago_n == 1, lcolor(cyan)) ///
            (line porcentaje_impuesto periodo if estadopago_n == 2, lcolor(orange)) ///
            (line porcentaje_impuesto periodo if estadopago_n == 3, lcolor(pink)), ///
            legend(label(1 "Descuento") label(2 "Sin Descuento") label(3 "Sanción") pos(3) col(1)) ///
            title("Porcentaje del Recaudo del Impuesto por Estado de Pago (2014-2023)", size(small) color(black)) ///
            xtitle("Año") ytitle("Porcentaje del Recaudo del Impuesto (%)") ///
            xlabel(2014(1)2023, labsize(small)) ///
            ylabel(0(10)100, labsize(small))



**# ---------- Figura: Recaudo hace 10 años barras

        use "$datacl/recaudo_total_agregado", clear

        * Convertir 'estado_pago' en una variable numérica
        encode estado_pago, gen(estadopago_n)

        * Crear la variable de periodo basado en la vigencia
        gen periodo = vigencia
        format periodo %ty

        * Colapsar los datos sumando 'impuesto' por vigencia y estado de pago
        collapse (sum) impuesto, by(periodo estadopago_n)

        format impuesto %12.0fc
        *gen impuesto_millones = impuesto/1000000
        *drop impuesto


        * Eliminar observaciones con valores faltantes en 'estadopago_n'
        drop if missing(estadopago_n)

    ** Grafica

        graph bar impuesto_millones,  over(estadopago_n) over(periodo) stack asyvars

graph bar impuesto_millones, over(estadopago_n, gap(10) label(labsize(vsmall))) ///
    over(periodo, label(angle(45) labsize(vsmall) format(%9.0gc))) ///
    blabel(bar, position(outside) format(%9.0gc)) ///
    stack asyvars ///
    legend(order(1 "Categoria 1" 2 "Categoria 2" 3 "Categoria 3")) ///
    ytitle("Impuestos Recaudados (en millones)") ///
    title("") ///
    bar(1, fcolor(red)) bar(2, fcolor(blue)) bar(3, fcolor(green)) ///
    plotregion(margin(0 0 0 12))


    graph bar impuesto_millones, over(estadopago_n, gap(10) label(labsize(vsmall))) ///
    over(periodo, label(angle(45) labsize(vsmall))) ///
    blabel(bar, position(inside) format(%9.2f)) ///
    stack asyvars ///
    legend(order(1 "Categoria 1" 2 "Categoria 2" 3 "Categoria 3")) ///
    ytitle("Impuestos Recaudados (en millones)") ///
    title("Impuesto Recaudado por Estado de Pago y Año") ///
    bar(1, fcolor(red)) bar(2, fcolor(blue)) bar(3, fcolor(green)) ///
    plotregion(margin(0 0 0 12))


    ** Grafica en porcentaje

        * Asumiendo que ya tienes 'impuesto_millones' y 'estadopago_n' y 'periodo' adecuadamente definidos

        * Calcular el total de impuestos por periodo
        egen total_impuesto_periodo = total(impuesto), by(periodo)

        * Calcular el porcentaje que representa cada categoría
        gen porcentaje = impuesto / total_impuesto_periodo * 100

        * Preparar datos para la gráfica
        collapse (sum) porcentaje, by(periodo estadopago_n)

        ** Grafica porcentaje
        graph bar porcentaje, over(estadopago_n, gap(10) label(labsize(small))) ///
            over(periodo, label(angle(0) labsize(small))) ///
            blabel(bar, position(inside) format(%9.1f "%%")) /// Mostrar el porcentaje dentro de las barras
            stack asyvars ///
            legend(order(1 "Descuento" 2 "Sin Descuento" 3 "Sanción") rows(1) position(bottom)) ///
            ytitle("Porcentaje del Impuesto Recaudado") ///
            title("") ///
            bar(1, fcolor(sand) lwidth(none)) bar(2, fcolor(gray) lwidth(none)) bar(3, fcolor(maroon) lwidth(none)) ///
            plotregion(margin(0 0 0 12)) ///
            ylabel(, labsize(small))


