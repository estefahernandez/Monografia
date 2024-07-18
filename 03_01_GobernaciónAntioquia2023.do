
*-------------------------------------------------------------------
*
*   Parque Automotor Gobernacion de Antioquia 2023 
*     
*   Organización de Datos
*
*-------------------------------------------------------------------

/*  1. Organización de variable Pronto pago, sin descuento, Moroso por medio de las fechas (Ordenanza #35 de 2022)
    2. Calcular el valor comercial de los vehiculos
    
*/

**# Importación de los datos

    use "$datacl/10_Vehiculo_Parque_automotor_impuesto_vehicular_ano_fiscal_2023", clear

**# Organización de datos

    ** Vehículos de transporte público de pasajeros o carga exonerados
       // drop if clase == "BUS" | clase == "BUS ELECTRICO" | clase == "BUSETA" | clase == "MICRO BUS"

    ** Estado de pago por parte de los propietarios
        gen estado_pago = "."
        replace estado_pago = "Descuento" if fecha_pago >= date("01jan2023", "DMY") & fecha_pago <= date("21apr2023", "DMY")
        replace estado_pago = "Sin Descuento" if fecha_pago >= date("22apr2023", "DMY") & fecha_pago <= date("21jul2023", "DMY")
        replace estado_pago = "Sancion Minima" if fecha_pago >= date("22jul2023", "DMY")
        label variable estado_pago "ESTADO DE PAGO"

    ** Calcular el valor comercial del vehículo basado en el porcentaje del impuesto cobrado
        destring impuesto, replace force
        gen valor_comercial = .
        replace valor_comercial = impuesto / 0.015 if impuesto <= 52483000 * 0.015
        replace valor_comercial = impuesto / 0.025 if impuesto > 52483000 * 0.025 & impuesto <= 118083000 * 0.025
        replace valor_comercial = impuesto / 0.035 if impuesto > 118083000 * 0.035
        format valor_comercial %12.0fc // Formato no cientifico


