
*-------------------------------------------------------------------
*
*   Linea Base 2023
*   - Filtros con base a la información a usar
*   - Coincidencia de emisiones con el modelo y cilindraje 
*   - No coincidencia de modelo y cilindraje se hace la proporción
*
*-------------------------------------------------------------------

**# Tasa de intervención

import excel "/Users/estefania/Downloads/tasa_intervencion_historica.xlsx", sheet("Sheet1") firstrow clear

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

drop if year < 2003

drop year month Fechaddmmaaaa
rename fecha_num fecha

order fecha, first


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

drop if año < 2003

* Crear una variable de fecha a partir de año y mes, usando el primer día del mes
gen año_str = string(año, "%04.0f")
gen mes_str = string(mes_num, "%02.0f")
gen dia_str = string(dia, "%02.0f")

gen fecha_str = año_str + "-" + mes_str + "-" + dia_str
gen fecha = date(fecha_str, "YMD")
format fecha %td

sort fecha

drop año dia mes_num año_str mes_str dia_str fecha_str

order fecha, first

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

drop fecha_str dia_str mes_str año_str dia mes_num mes año
drop if missing(ipc)

order fecha, first

    * Guardar

    save "$datacl/indice_ipc.dta", replace

**# Unión de Datos

* Cargar el primer dataset
use "$datacl/indice_ipc.dta", clear

* Realizar el merge con el segundo dataset
merge 1:1 fecha using "$datacl/indice_pp.dta"

drop if missing(OfertaInterna)

drop _merge

    * Guardar

    save "$datacl/inflacion.dta", replace

* Cargar el segundo dataset
use "$datacl/inflacion.dta", clear

* Realizar el merge con el segundo dataset
merge 1:1 fecha using "$datacl/tasa_intenvencion.dta"

drop if _merge == 2 | _merge == 1

drop _merge

    save "$datacl/inflacion.dta", replace


**# Modelo ARIMA

use "$datacl/inflacion.dta", clear

** Paso 1: Preparar los Datos
tsset fecha

** Paso 2: Revisión Gráfica de las Series

tsline ipc OfertaInterna Tasadeintervencióndepolítica

** Paso 3: Estacionariedad

dfuller ipc, trend regress lags(12)
dfuller OfertaInterna, lags(12)
dfuller Tasadeintervencióndepolítica, lags(12)
