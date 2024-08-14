*-------------------------------------------------------------------
*
*  Estadisticas descriptivas
*
*-------------------------------------------------------------------

**# Abrir base de datos recaudo fiscal año 2023

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

**# Figura: Evolución del parque automotor 2023

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

// ** Modificar la fecha por meses 
// gen month_matricula = mofd(fecha_matricula)
// format month_matricula %tm

** Modelo
gen month_matricula = year(modelo)
format month_matricula %ty

* Crear una variable de conteo
gen count = 1

// ** Collapsar la información
// collapse (sum) count, by(month_matricula  clase_n)
collapse (sum) count, by(month_matricula  clase_n)
** Volver Panel la base de datos
xtset clase_n month_matricula 

xtline count if inrange(month_matricula,ym(2000,1), ym(2024,12)) , overlay ///
legend(on rows(1) pos(6) size(small)) ///
ylabel()


