*-------------------------------------------------------------------
*
*  Estadisticas descriptivas
*
*-------------------------------------------------------------------

**# Abrir base de datos recaudo fiscal año 2023

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

**# ---------- Figura: Evolución del parque automotor 2023 por fecha de matricula

** Agrupar la variable Clase

gen clase_agrupada = ""

replace clase_agrupada = "Automovil" if inlist(clase, "AUTOMOVIL", "AUTOMOVIL ELECTRICO", "AUTOMOVIL HIBRIDO")
replace clase_agrupada = "Bus" if inlist(clase, "BUS", "BUS ELECTRICO", "BUSETA", "MICRO BUS")
replace clase_agrupada = "Camion" if inlist(clase, "CAMION", "TRACTO-CAMION", "VOLQUETA")
replace clase_agrupada = "Camioneta" if inlist(clase, "CAMIONETA(C)", "CAMIONETA(C) ELECTRICO", "CAMIONETA(C) HIBRIDO", "CAMIONETA(P)", "CAMIONETA(P) ELECTRICO", "CAMIONETA(P) HIBRIDO")
replace clase_agrupada = "Campero" if inlist(clase, "CAMPERO", "CAMPERO HIBRIDO")
replace clase_agrupada = "Motocicleta" if inlist(clase, "CUATRIMOTO", "MOTOCICLETA", "MOTOTRICICLO")
replace clase_agrupada = "Otro" if inlist(clase, "CUADRICICLO", "MOTOCARRO")

** Variable panel
encode clase_agrupada , gen(clase_n)

preserve

    ** Modificar la fecha por meses 
    gen month_matricula = mofd(fecha_matricula)
    format month_matricula %tm

    * Crear una variable de conteo
    gen count_matricula = 1

    ** Collapsar la información
    collapse (sum) count_matricula, by(month_matricula  clase_n)

    ** Volver Panel la base de datos
    xtset clase_n month_matricula 

    * Generar la gráfica
    xtline count if inrange(month_matricula,ym(2000,1), ym(2023,12)) , overlay ///
        legend(on rows(1) pos(6) size(small)) ///
        title("Evolución del Número de Vehículos Matriculados por Año del Modelo (2000-2023)", size(medium) color(black)) ///
        xtitle("Año del Modelo", size(medium) color(black)) ///
        ytitle("Número de Vehículos", size(medium) color(black) margin(medium))

    //graph export "${figuras}/vehiculo_matriculas.pdf",  replace

restore

**# ---------- Figura: Evolución del parque automotor 2023 por modelo del vehículo

preserve 

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
    xtline count if inrange(year_modelo, 2000, 2023) , overlay ///
        legend(on rows(1) pos(6) size(small)) ///
        title("Evolución del Número de Vehículos Matriculados por Año del Modelo (2000-2023)", size(medium) color(black)) ///
        xtitle("Año del Modelo", size(medium) color(black)) ///
        ytitle("Número de Vehículos", size(medium) color(black) margin(medium))

    //graph export "${figuras}/vehiculo_modelo.pdf",  replace

restore

**# ---------- Figura: Combustible

use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

gen combustible_agrupada = ""
replace combustible_agrupada = "Eletricos" if combustible == "ELECTRICO" 
replace combustible_agrupada = "Gasolina" if combustible == "GASOLINA" 
replace combustible_agrupada = "Hibrido" if combustible == "GASOLINA & ELECTRICO" 

** Variable panel
encode combustible_agrupada , gen(combustible_n)

    ** Modelo
    gen year_modelo = modelo
    format year_modelo %ty

    * Crear una variable de conteo
    gen count_modelo = 1

    ** Collapsar la información
    collapse (sum) count_modelo, by(year_modelo  combustible_n)

    ** Volver Panel la base de datos
    xtset combustible_n year_modelo

    * Generar la gráfica
    xtline count if inrange(year_modelo, 2006, 2023) , overlay ///
        legend(on rows(1) pos(6) size(small)) ///
        title("Evolución tipo de combustible (2000-2023)", size(medium) color(black)) ///
        xtitle("Año por Matricula", size(medium) color(black)) ///
        ytitle("Número de Vehículos", size(medium) color(black) margin(medium))

    //graph export "${figuras}/vehiculo_matriculas.pdf",  replace

restore


**# ---------- Figura: Distribución entre Marca y modelo


use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

    ** Variable panel
    encode marca , gen(marca_n)

    * Crear una variable de conteo
    gen count_marca = 1

    ** Collapsar la información
     collapse (sum) count_marca, by(marca)


* Crear un gráfico de barras horizontal
graph hbar (sum) count_marca, over(marca) nofill



**# ---------- Figura: Recaudo hace 10 años




