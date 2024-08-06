

*-------------------------------------------------------------------
*
*   Gobernación de Antioquia recaudo fiscal 2023
*      
*
*-------------------------------------------------------------------

**# Importar datos recaudo fiscal 2023 Gobernación de Antioquia

    import delimited "$ruta/Data_master/Parque_automotor_impuesto_vehicular_año_fiscal_2023.csv", clear

**# Guarda data set

    compress
    save "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023_master.dta", replace

**# Abrir datos

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023_master.dta", clear

**# ID

    gen random_id = _n 
    egen id = group(marca modelo random_id)
    gen id_string = marca + string(modelo) + "_" + string(random_id)

    drop id random_id
    rename id_string ID

    order ID, first

**# Formato

    destring impuesto, replace force

**# Organizar fechas 

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

    order fecha_matricula,  after(ID)
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

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso


**# Valor del vehículo presunto

    ** Calcular el valor comercial del vehículo basado en el porcentaje del impuesto cobrado

        gen porcentaje = .

        replace porcentaje = 0.015 if impuesto <= 787245 
        replace porcentaje = 0.025 if impuesto > 787245 & impuesto <= 4132905
        replace porcentaje = 0.035 if impuesto > 4132905

        replace porcentaje = 0.015 if (impuesto <= 708520.5) & (estado_pago_2023 == "Descuento")
        replace porcentaje = 0.025 if (impuesto > 708520.5) & (impuesto <= 3719614.5) & (estado_pago_2023 == "Descuento")
        replace porcentaje = 0.035 if (impuesto > 3719614.5) & (estado_pago_2023 == "Descuento")

    ** Calcular el valor comercial del vehículo basado en el porcentaje del impuesto cobrado

        gen valor_presunto = .
        replace valor_presunto = impuesto/porcentaje

        format valor_presunto %12.0fc // Formato no cientifico



**# Guardar data set

    compress
    save "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", replace

