
*-------------------------------------------------------------------
*
*   Parque Automotor Gobernacion de Antioquia 2023 
*     
*   Recaudo desdes 2014 hasta 2023
** Quiero unir los 10 años para analizar el recaudo a lo largo del tiempo.
** Organizo por año el formato de la fecha de matricula y pago de impuesto
** Establecer por medio de las ordenanzas las fechas por año donde se da los descuento
*       y sanciones, ademas solo tendremos como restriccion los que pagaron la obligacion
*
*-------------------------------------------------------------------





**# ---------- Importación recaudo 2014

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2014.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

    order fecha_matricula, after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2014

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2014", "DMY") & fecha_pago <= date("01apr2014", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("02apr2014", "DMY") & fecha_pago <= date("18jul2014", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("19jul2014", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"


save "$datacl/recaudo_ano_fiscal_2014", replace

**# ---------- Importación recaudo 2015

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2015.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

    order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2015

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2015", "DMY") & fecha_pago <= date("20mar2015", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("21mar2015", "DMY") & fecha_pago <= date("17jul2015", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("18jul2015", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

save "$datacl/recaudo_ano_fiscal_2015", replace

**# ---------- Importación recaudo 2016

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2016.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

        order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2016

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2016", "DMY") & fecha_pago <= date("29apr2016", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("30apr2016", "DMY") & fecha_pago <= date("15jul2016", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("16jul2016", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

save "$datacl/recaudo_ano_fiscal_2016", replace

**# ---------- Importación recaudo 2017
import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2017.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

        order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2017

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2017", "DMY") & fecha_pago <= date("17mar2017", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("18mar2017", "DMY") & fecha_pago <= date("14jul2017", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("15jul2016", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

save "$datacl/recaudo_ano_fiscal_2017", replace

**# ---------- Importación recaudo 2018

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2018.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

        order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2018

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2018", "DMY") & fecha_pago <= date("16mar2018", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("17mar2018", "DMY") & fecha_pago <= date("13jul2018", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("14jul2018", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

save "$datacl/recaudo_ano_fiscal_2018", replace

**# ---------- Importación recaudo 2019

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2019.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

        order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2019

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2019", "DMY") & fecha_pago <= date("22mar2019", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("23mar2019", "DMY") & fecha_pago <= date("19jul2019", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("20jul2019", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"


save "$datacl/recaudo_ano_fiscal_2019", replace

**# ---------- Importación recaudo 2020

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2020.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

        order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2020

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2020", "DMY") & fecha_pago <= date("20mar2020", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("21mar2020", "DMY") & fecha_pago <= date("17jul2020", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("18jul2020", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

save "$datacl/recaudo_ano_fiscal_2020", replace

**# ---------- Importación recaudo 2021

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2021.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

        order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2021

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2021", "DMY") & fecha_pago <= date("16apr2021", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("17apr2021", "DMY") & fecha_pago <= date("18jul2021", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("19jul2021", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

save "$datacl/recaudo_ano_fiscal_2021", replace

**# ---------- Importación recaudo 2022

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2022.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

        order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

** Estado de pago por parte de los propietarios año 2022

    gen estado_pago = .
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2022", "DMY") & fecha_pago <= date("30apr2022", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("01may2022", "DMY") & fecha_pago <= date("18jul2022", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("19jul2022", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

save "$datacl/recaudo_ano_fiscal_2022", replace

**# ---------- Importación recaudo 2023

import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2023.csv", clear

** Formato
    destring impuesto, replace force

** Organizar fechas 

    * Matriculas
    gen fecha_matricula00 = date(fecha_matricula, "YMD")
    format fecha_matricula00 %td

    * Pagos
    gen fecha_pago00 = date(fecha_pago, "YMD")
    format fecha_pago00 %td

    * Renombrar variables
    drop fecha_pago fecha_matricula
    rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
    label variable fecha_pago "FECHA DE PAGO"
    label variable fecha_matricula "FECHA DE MATRICULA"

        order fecha_matricula,  after(modelo)
    order fecha_pago, before(impuesto)

    sort fecha_matricula

**# Estado de pago por parte de los propietarios año 2023

    gen estado_pago_2023 = "."
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2023", "DMY") & fecha_pago <= date("21apr2023", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("22apr2023", "DMY") & fecha_pago <= date("21jul2023", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("22jul2023", "DMY")
    label variable estado_pago "ESTADO DE PAGO"

    order fecha_pago, before(impuesto)

    *restricción
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"

save "$datacl/recaudo_ano_fiscal_2023", replace