*-------------------------------------------------------------------
*
*   Parque Automotor Gobernacion de Antioquia 
*     
*   Limpieza y organización de datos
*
*-------------------------------------------------------------------

**# Importación CVS de datos 

/* Se ordena y organiza la base de datos con base a los requerimientos de la investigación.
    1. inicialmente se hace una clasificación de vehículos y motocicletas
    2. Dentro de cada año del parque automotor, hay algunos inconsistencia en las que se toma la decisión de eliminar modelos de vehículos que no tiene relación con
    el año gravable
    3. La fecha de matricula & fecha de pago eran variables string y la cambie en fecha
*/

**# Parque Automotor impuesto vehicular año fiscal 2014

        import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2014.csv", clear

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        drop if modelo > 2015

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/01_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2014", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/01_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2014", replace
        restore

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$datacl/01_Parque_automotor_impuesto_vehicular_ano_fiscal_2014", replace

**# Parque Automotor impuesto vehicular año fiscal 2015

        import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2015.csv", clear

        drop if modelo > 2016

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/02_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2015", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/02_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2015", replace
        restore

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$datacl/02_Parque_automotor_impuesto_vehicular_ano_fiscal_2015", replace


**# Parque Automotor impuesto vehicular año fiscal 2016

        import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2016.csv", clear
        
        drop if modelo > 2017

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/03_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2016", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/03_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2016", replace
        restore

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$datacl/03_Parque_automotor_impuesto_vehicular_ano_fiscal_2016", replace

**# Parque Automotor impuesto vehicular año fiscal 2017

        import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2017.csv", clear

        drop if modelo > 2018

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/04_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2017", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/04_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2017", replace
        restore

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$datacl/04_Parque_automotor_impuesto_vehicular_ano_fiscal_2017", replace

**# Parque Automotor impuesto vehicular año fiscal 2018

        import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2018.csv", clear

        drop if modelo > 2019

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/05_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2018", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/05_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2018", replace
        restore

        compress 
        save "$datacl/05_Parque_automotor_impuesto_vehicular_ano_fiscal_2018", replace

**# Parque Automotor impuesto vehicular año fiscal 2019

        import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2019.csv", clear

        drop if modelo > 2020

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/06_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2019", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/06_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2019", replace
        restore

        compress 
        save "$datacl/06_Parque_automotor_impuesto_vehicular_ano_fiscal_2019", replace


**# Parque Automotor impuesto vehicular año fiscal 2020

       import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2020.csv", clear

        drop if modelo > 2021

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/07_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2020", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/07_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2020", replace
        restore

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$datacl/07_Parque_automotor_impuesto_vehicular_ano_fiscal_2020", replace

**# Parque Automotor impuesto vehicular año fiscal 2021

        import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2021.csv", clear

        drop if modelo > 2022

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/08_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2021", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/08_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2021", replace
        restore

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$datacl/08_Parque_automotor_impuesto_vehicular_ano_fiscal_2021", replace

**# Parque Automotor impuesto vehicular año fiscal 2022

       import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2022.csv", clear

        drop if modelo > 2023

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/09_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2022", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/09_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2022", replace
        restore

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$datacl/09_Parque_automotor_impuesto_vehicular_ano_fiscal_2022", replace

**# Parque Automotor impuesto vehicular año fiscal 2023

       import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2023.csv", clear

        drop if modelo > 2024

        gen clase00 = 0
        replace clase00 = 1 if inlist(clase, "MOTOTRICICLO", "MOTOCICLETA", "MOTOCICLETA ELECTRICA", "MOTOCARRO", "CUATRIMOTO") // Clasificando los vehiculos y las motos
        label define clase00 0 "VEHICULOS" 1 "MOTOCICLETAS"

        gen fecha_matricula00 = date(fecha_matricula, "YMD")
        format fecha_matricula00 %td

        gen fecha_pago00 = date(fecha_pago, "YMD")
        format fecha_pago00 %td

        drop fecha_pago fecha_matricula
        rename (fecha_pago00 fecha_matricula00) (fecha_pago fecha_matricula)
        label variable fecha_pago "FECHA DE PAGO"
        label variable fecha_matricula "FECHA DE MATRICULA"

        preserve
            keep if clase00 == 1
            save "$datacl/10_Motocicleta_Parque_automotor_impuesto_vehicular_ano_fiscal_2023", replace
        restore

        preserve
            keep if clase00 == 0
            save "$datacl/10_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2023", replace
        restore

        compress // Guardar espacio cuando se guarde data set en el archivo

        save "$datacl/10_Parque_automotor_impuesto_vehicular_ano_fiscal_2023", replace

