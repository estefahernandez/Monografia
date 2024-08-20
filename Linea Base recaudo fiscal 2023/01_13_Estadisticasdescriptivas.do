*-------------------------------------------------------------------
*
*  Estadisticas descriptivas
*
*-------------------------------------------------------------------


**# ---------- Figura: Evolución del parque automotor 2023 por fecha de matricula

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


    **** Figura: Grupo 1  --> Camion, Bus, Campero

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


    **** Figura: Grupo 2  --> Automovil, Camioneta, Motocicleta

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


    **** Figura: Grupo 3  --> Automovil, Camioneta, Motocicleta, otros: Camion, Bus, Campero

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
        title("Grupo 1: Automovil, Camioneta, Motocicleta", size(medium) color(black)) ///
        xtitle("Año", size(small)  color(black)) ///
        ytitle("Número de Vehículos", size(small) color(black) margin(small)) ///
        xlabel(, format(%tmCCYY-NN) labsize(small)) ///
        ylabel(, format(%9.0gc) labsize(small)) ///
        plot1opts(lcolor(purple)) ///
        plot2opts(lcolor(orange red)) ///
        plot3opts(lcolor(ebblue)) ///
        plot4opts(lcolor(pink)) ///


    restore

    *** Matricula por años

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
/*
    xtline count if inrange(year_modelo, 2000, 2023) , overlay ///
        legend(on rows(1) pos(6) size(small)) ///
        title("", size(medium) color(black)) ///
        xtitle("Año del Modelo", size(medium) color(black)) ///
        ytitle("Número de Vehículos", size(medium) color(black) margin(medium))

*/

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

    gen combustible_agrupada = ""
    replace combustible_agrupada = "Eletricos" if combustible == "ELECTRICO" 
    replace combustible_agrupada = "Gasolina" if combustible == "GASOLINA" 
    replace combustible_agrupada = "Hibrido" if combustible == "GASOLINA & ELECTRICO" 

    *** Matriculas

    ** panel
    encode combustible_agrupada , gen(combustible_n)

    ** Modificar la fecha por meses 
    gen month_matricula = mofd(fecha_matricula)
    format month_matricula %tm

    * Crear una variable de conteo
    gen count_matricula = 1

    ** Collapsar la información
    collapse (sum) count_matricula, by(month_matricula  combustible_n)

    ** Volver Panel la base de datos
    xtset combustible_n month_matricula 

    export excel using "$excel/Datos_tratados/excel/combustible.xlsx", replace firstrow(variables)

    twoway line combustible_n == 1 month_matricula, title("", size(medium) color(black)) || line combustible_n == 2 month_matricula, yaxis (2) title("", size(medium) color(black)) 

    * Generar la gráfica
    xtline count if inrange(month_matricula, ym(2015,1), ym(2023,12)), overlay ///
        legend(on rows(1) pos(12) size(small) col(1) ring(0) label(1 "Eléctrico") ///
            label(2 "Gasolina") label(3 "Híbrido")) ///
        title("", size(medium) color(black)) ///
        xtitle("Año", size(small)  color(black)) ///
        ytitle("Número de Vehículos", size(small) color(black) margin(small)) ///
        xlabel(, format(%tmCCYY-NN) labsize(small)) ///
        ylabel(, format(%9.0gc) labsize(small)) ///
        plot1opts(lcolor(cyan)) ///
        plot2opts(lcolor(orange)) ///
        plot3opts(lcolor(pink))

    graph export "${figuras}/Combustible_matricula.pdf",  replace


**# ---------- Figura: Recaudo hace 10 años

use "$datacl/recaudo_total_agregado", clear

** Variable panel
encode estado_pago , gen(estadopago_n)

* Vigencia
gen periodo = vigencia
format periodo %ty

* Colapsar los datos por vigencia 
collapse (sum) impuesto, by(periodo estadopago_n)



    * Generar la gráfica
twoway line estadopago_n periodo 
    line impuesto periodo

