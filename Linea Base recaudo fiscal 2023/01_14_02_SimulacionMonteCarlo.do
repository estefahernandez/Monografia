*-------------------------------------------------------------------
*
*   El impuesto cobrado por emisiones con base a una proyección a 10 años
*   
*   - Se unen los modelos con emisiones estimadas del periodo recaudado 2023
*   - 
*
*-------------------------------------------------------------------

**# Append Linea Base de los modelos 2011 hasta 2023 con sus respectivas estimaciones de las emisiones

    use "$datacl/modelos_emisiones_recaudo2023.dta", clear

    ** Organizar el formato de las variables impuesto y precio CO2
    format precio_CO2eq_ton %12.0fc
    format impuesto %12.0fc

**# ---------------- Simulacion Impuesto propueto a 10 años

    ** Paso 1: Crear la variabes tarifa CO2 para los años 2024 a 2033

        * Precio CO2 equivalente por tonelada
        gen PrecioCO2 = 23394.59  

        * Crear las variables TarifaCO2 para cada año usando las tasas de inflación fijas
        gen TarifaCO2_2024 = PrecioCO2 * (1 + 0.0928 + 0.01)
        gen TarifaCO2_2025 = PrecioCO2 * (1 + 0.057 + 0.01)
        gen TarifaCO2_2026 = PrecioCO2 * (1 + 0.043 + 0.01)
        gen TarifaCO2_2027 = PrecioCO2 * (1 + 0.039 + 0.01)
        gen TarifaCO2_2028 = PrecioCO2 * (1 + 0.037 + 0.01)
        gen TarifaCO2_2029 = PrecioCO2 * (1 + 0.036 + 0.01)
        gen TarifaCO2_2030 = PrecioCO2 * (1 + 0.03 + 0.01)
        gen TarifaCO2_2031 = PrecioCO2 * (1 + 0.03 + 0.01)
        gen TarifaCO2_2032 = PrecioCO2 * (1 + 0.03 + 0.01)
        gen TarifaCO2_2033 = PrecioCO2 * (1 + 0.03 + 0.01)

    ** Paso 2: Crear la variabes emisiones emitidas por año

    * Kilometros por año: Distribución normal
    gen km_total = rnormal(15000, 3000)

    * Emisiones estimadas: Distribución PERT

        * Se verificar que los parámetros PERT estén definidos
        assert !missing(min_CO2eq_ton) & !missing(mean_CO2eq_ton) & !missing(max_CO2eq_ton)

        * Definir parámetros PERT
        local min = min_CO2eq_ton[1]
        local mode = mean_CO2eq_ton[1]
        local max = max_CO2eq_ton[1]

        * Calcular los parámetros alpha y beta para la distribución beta
        local alpha = 1 + 4 * ((`mode' - `min') / (`max' - `min'))
        local beta = 1 + 4 * ((`max' - `mode') / (`max' - `min'))

        * Generar datos simulados para emisiones_CO2eq_ton
        gen emisiones_CO2eq_ton = `min' + (`max' - `min') * rbeta(`alpha', `beta')


    ** Paso 3: Crear las variables impuesto propuesta para los años 2024 a 2033

        * Calcular Impuesto_propuesta para cada año
        gen Impuesto_propuesta_2024 = TarifaCO2_2024 * emisiones_CO2eq_ton

        forvalues year=2025/2033 {
            gen Impuesto_propuesta_`year' = TarifaCO2_`year' * emisiones_CO2eq_ton
        }

    ** Paso 3: Calcular el VPN (Valor presente Neto) de los impuestos propuestos
    
        * Definir la tasa de descuento (ajusta este valor según tu estudio)
        gen tasa_descuento = 0.10  // 10% de descuento

        * Calcular el VPN del impuesto propuesto para cada observación
        gen VPN_impuesto_propuesta = 0

        forvalues year=2024/2033 {
            local t = `year' - 2023  // Periodo correspondiente para el descuento
            replace VPN_impuesto_propuesta = VPN_impuesto_propuesta + Impuesto_propuesta_`year' / (1 + tasa_descuento)^`t'
        }

    * Paso 4: Calcular el VPN acumulado

    * Calcular el VPN acumulado
    egen VPN_acumulado = total(VPN_impuesto_propuesta)

    *Paso 5: Simulación Monte Carlo 

        * Simulación Monte Carlo de 1000 iteraciones
    program monte_carlo_simulation, rclass
        // Definir el proceso de simulación: crear las variables y calcular el VPN acumulado
        // (Puedes copiar el código de los pasos anteriores dentro de este programa)
    end

    * Ejecutar la simulación 1000 veces
    simulate resultado = VPN_acumulado, reps(1000): monte_carlo_simulation

