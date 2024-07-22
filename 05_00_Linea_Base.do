
*-------------------------------------------------------------------
*
*   Recaudo modelo 2023
*     
*   1. Los datos de la Gobernación de Antioquia de vehículos se tomorá los modelos desde 2022-2024
*      y analizando la fecha de matricula, seran eliminadas todas las fechas inferiores a 1 enero de 2021, por el supuesto
*      de que en el 2021 pueden vender modelos 2022.
*   2. Se eliminaran todas las matriculas que sus fechas sean del año 2024, lo cual solo nos quedamos con todo los modelos 2022 - 2024
*      efectuados desde 1 enero de 2021 hasta 31 de diciembre de 2023.
*
*-------------------------------------------------------------------

**# Impotación de datos

    use "$datacl/10_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2023", clear

**# Selección de información modelos 2022 - 2024

    keep if modelo >= 2022

    drop if fecha_matricula < date("01jan2021", "DMY")
    drop if fecha_matricula >= date("1jan2024", "DMY")

**# Vehículos de transporte público de pasajeros o carga exonerados
       // drop if clase == "BUS" | clase == "BUS ELECTRICO" | clase == "BUSETA" | clase == "MICRO BUS"

**# Estado de pago por parte de los propietarios año 2023

    gen estado_pago_2023 = "."
    replace estado_pago = "Descuento" if fecha_pago >= date("01jan2023", "DMY") & fecha_pago <= date("21apr2023", "DMY")
    replace estado_pago = "Sin Descuento" if fecha_pago >= date("22apr2023", "DMY") & fecha_pago <= date("21jul2023", "DMY")
    replace estado_pago = "Sancion Minima" if fecha_pago >= date("22jul2023", "DMY")
    label variable estado_pago "ESTADO DE PAGO"


**# Calcular el valor comercial del vehículo basado en el porcentaje del impuesto cobrado

    destring impuesto, replace force
    gen valor_comercial = .
    replace valor_comercial = impuesto / 0.015 if impuesto <= 52483000 * 0.015
    replace valor_comercial = impuesto / 0.025 if impuesto > 52483000 * 0.025 & impuesto <= 118083000 * 0.025
    replace valor_comercial = impuesto / 0.035 if impuesto > 118083000 * 0.035
    format valor_comercial %12.0fc // Formato no cientifico

**# Calcular el valor comercial del vehículo basado en el porcentaje del impuesto cobrado sin el descuento

    gen pago_sin_descuento = . 
    replace pago_sin_descuento = impuesto / 0.9 if estado_pago == "Descuento"
    replace pago_sin_descuento = impuesto - 212000 if estado_pago == "Sancion Minima"
    replace pago_sin_descuento = impuesto if estado_pago == "Sin Descuento" //| estado_pago == "Sancion Minima"
    replace pago_sin_descuento = impuesto / 0.8 if estado_pago == "Descuento" & combustible == "ELECTRICO"
    replace pago_sin_descuento = impuesto / 0.85 if estado_pago == "Descuento" & combustible == "GASOLINA & ELECTRICO"
    format valor_comercial %12.0fc // Formato no cientifico


**# Calcular el valor comercial del vehículo basado en el porcentaje del impuesto cobrado

    destring impuesto, replace force
    gen valor_comercial1 = .
    replace valor_comercial1 = pago_sin_descuento / 0.015 if pago_sin_descuento <= 52483000 * 0.015
    replace valor_comercial1 = pago_sin_descuento / 0.025 if pago_sin_descuento > 52483000 * 0.025 & pago_sin_descuento <= 118083000 * 0.025
    replace valor_comercial1 = pago_sin_descuento / 0.035 if pago_sin_descuento > 118083000 * 0.035
    format valor_comercial1 %12.0fc // Formato no cientifico

**# Recaudo Gobernación de Antioquia

    egen suma_valor_pagado = total(impuesto)
    format suma_valor_pagado %12.0fc // Formato no cientifico