
clear
set more off

* Paso 1: Definir el programa para calcular VPN_acumulado en cada simulación
program define calc_vpn, rclass
    * Definir la variable PrecioCO2
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

    ** Paso 2: Crear las variables emisiones_CO2eq_ton usando distribución PERT
    * Generar km_total con distribución normal
    gen km_total = rnormal(15000, 3000)

    * Verificar que los parámetros PERT estén definidos
    assert !missing(min_CO2eq_ton) & !missing(mean_CO2eq_ton) & !missing(max_CO2eq_ton)

    * Definir los parámetros PERT
    local min = min_CO2eq_ton[1]
    local mode = mean_CO2eq_ton[1]
    local max = max_CO2eq_ton[1]

    * Calcular los parámetros alpha y beta para la distribución beta
    local alpha = 1 + 4 * ((`mode' - `min') / (`max' - `min'))
    local beta = 1 + 4 * ((`max' - `mode') / (`max' - `min'))

    * Generar datos simulados para emisiones_CO2eq_ton usando la distribución PERT
    gen emisiones_CO2eq_ton = `min' + (`max' - `min') * rbeta(`alpha', `beta')

    ** Paso 3: Crear las variables Impuesto_propuesta para cada año
    gen Impuesto_propuesta_2024 = TarifaCO2_2024 * emisiones_CO2eq_ton

    forvalues year=2025/2033 {
        gen Impuesto_propuesta_`year' = TarifaCO2_`year' * emisiones_CO2eq_ton
    }

    ** Paso 4: Calcular el VPN para cada observación
    gen tasa_descuento = 0.10  // Tasa de descuento del 10%

    gen VPN_impuesto_propuesta = 0
    forvalues year=2024/2033 {
        local t = `year' - 2023  // Definir el periodo para el descuento
        replace VPN_impuesto_propuesta = VPN_impuesto_propuesta + Impuesto_propuesta_`year' / (1 + tasa_descuento)^`t'
    }

    * Paso 5: Calcular el VPN acumulado
    egen VPN_acumulado = total(VPN_impuesto_propuesta)

    * Guardar el resultado del VPN acumulado en una variable de retorno
    return scalar resultado = VPN_acumulado[1]
end

* Paso 6: Simular 1000 veces para obtener la distribución del VPN_acumulado
simulate vpn_acumulado=resultado, reps(1000): calc_vpn

* Paso 7: Analizar la distribución del VPN_acumulado
summarize vpn_acumulado
histogram vpn_acumulado, normal
