
*-------------------------------------------------------------------
*
*   Linea Base 2023
*   - Filtros con base a la información a usar
*   - Coincidencia de emisiones con el modelo y cilindraje 
*   - No coincidencia de modelo y cilindraje se hace la proporción
*
*-------------------------------------------------------------------

**# Tasa de intervención

import excel "/Users/estefania/Downloads/tasa_intervencion_historica.xlsx", sheet("Sheet1") firstrow

* Primero, asegurémonos de que la variable fecha esté en formato de fecha
gen fecha_num = date(Fechaddmmaaaa, "DMY") // Adaptar el formato de la fecha según corresponda
format fecha_num %td

* Extraer año y mes de la fecha
gen year = year(fecha_num)
gen month = month(fecha_num)

* Ordenar los datos por año, mes y fecha
sort year month fecha_num

* Mantener solo la primera observación de cada mes y año
by year month: keep if _n == 1

    * Guardar

    save "$datacl/tasa_intenvencion.dta", replace

**# Indice precios productos

import excel "/Users/estefania/Downloads/indice_pp_oferta_interna.xlsx", sheet("Hoja1") firstrow clear

* Crear una variable de día con valor 1
gen dia = 1

* Crear una variable numérica para el mes
gen mes_num = .

replace mes_num = 1 if mes == "Enero"
replace mes_num = 2 if mes == "Febrero"
replace mes_num = 3 if mes == "Marzo"
replace mes_num = 4 if mes == "Abril"
replace mes_num = 5 if mes == "Mayo"
replace mes_num = 6 if mes == "Junio"
replace mes_num = 7 if mes == "Julio"
replace mes_num = 8 if mes == "Agosto"
replace mes_num = 9 if mes == "Septiembre"
replace mes_num = 10 if mes == "Octubre"
replace mes_num = 11 if mes == "Noviembre"
replace mes_num = 12 if mes == "Diciembre"

replace mes_num = 1 if mes == "Enero "
replace mes_num = 2 if mes == "Febrero "
replace mes_num = 3 if mes == "Marzo "
replace mes_num = 4 if mes == "Abril "
replace mes_num = 5 if mes == "Mayo "
replace mes_num = 6 if mes == "Junio "
replace mes_num = 7 if mes == "Julio "
replace mes_num = 8 if mes == "Agosto "
replace mes_num = 9 if mes == "Septiembre "
replace mes_num = 10 if mes == "Octubre "
replace mes_num = 11 if mes == "Noviembre "
replace mes_num = 12 if mes == "Diciembre "

drop if missing(mes_num)
drop mes

* Asegurarse de que año es numérico
destring año, replace

* Crear una variable de fecha a partir de año y mes, usando el primer día del mes
gen año_str = string(año, "%04.0f")
gen mes_str = string(mes_num, "%02.0f")
gen dia_str = string(dia, "%02.0f")

gen fecha_str = año_str + "-" + mes_str + "-" + dia_str
gen fecha = date(fecha_str, "YMD")
format fecha %td

sort fecha

drop año dia mes_num año_str mes_str dia_str fecha_str

    * Guardar

    save "$datacl/indice_pp.dta", replace


**# Indice de precios al consumidor

import excel "/Users/estefania/Downloads/ipc.xlsx", sheet("Hoja2") firstrow clear

* Crear una variable numérica para el mes
gen mes_num = .
replace mes_num = 1 if mes == "Enero"
replace mes_num = 2 if mes == "Febrero"
replace mes_num = 3 if mes == "Marzo"
replace mes_num = 4 if mes == "Abril"
replace mes_num = 5 if mes == "Mayo"
replace mes_num = 6 if mes == "Junio"
replace mes_num = 7 if mes == "Julio"
replace mes_num = 8 if mes == "Agosto"
replace mes_num = 9 if mes == "Septiembre"
replace mes_num = 10 if mes == "Octubre"
replace mes_num = 11 if mes == "Noviembre"
replace mes_num = 12 if mes == "Diciembre"

* Crear una variable de día con valor 1
gen dia = 1

* Crear una variable de fecha a partir de año y mes, usando el primer día del mes
gen año_str = string(año, "%04.0f")
gen mes_str = string(mes_num, "%02.0f")
gen dia_str = string(dia, "%02.0f")


gen fecha_str = año_str + "-" + mes_str + "-" + dia_str
gen fecha = date(fecha_str, "YMD")
format fecha %td

* Ordenar los datos por fecha
sort fecha

* Ahora tienes una base de datos en formato largo con panel
