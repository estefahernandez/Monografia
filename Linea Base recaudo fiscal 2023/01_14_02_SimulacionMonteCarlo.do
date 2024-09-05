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

**# Organizar el formato de las variables impuesto y precio CO2

format precio_CO2eq_ton %12.0fc
format impuesto %12.0fc

**# Simulacion Monte Carlo

    ** Paso 1: Crear la variabes tarifaCO2 para los años 2024 a 2023

    * Definir las variables básicas
    
    gen PrecioCO2 = 23394.59  // Puedes ajustar este valor
    
    * Definir las tasas de inflación ya conocidas
    gen inflacion2024 = 0.0928
    gen inflacion2025 = 0.057
    gen inflacion2026 = 0.043
    gen inflacion2027 = 0.039
    gen inflacion2028 = 0.037
    gen inflacion2029 = 0.036
    gen inflacion2030 = 0.03
    gen inflacion2031 = 0.03
    gen inflacion2032 = 0.03
    gen inflacion2033 = 0.03

    * Crear las variables TarifaCO2 para cada año usando las tasas de inflación fijas
    gen TarifaCO2_2024 = PrecioCO2 * (1 + inflacion2024 + 0.01)
    gen TarifaCO2_2025 = PrecioCO2 * (1 + inflacion2025 + 0.01)
    gen TarifaCO2_2026 = PrecioCO2 * (1 + inflacion2026 + 0.01)
    gen TarifaCO2_2027 = PrecioCO2 * (1 + inflacion2027 + 0.01)
    gen TarifaCO2_2028 = PrecioCO2 * (1 + inflacion2028 + 0.01)
    gen TarifaCO2_2029 = PrecioCO2 * (1 + inflacion2029 + 0.01)
    gen TarifaCO2_2030 = PrecioCO2 * (1 + inflacion2030 + 0.01)
    gen TarifaCO2_2031 = PrecioCO2 * (1 + inflacion2031 + 0.01)
    gen TarifaCO2_2032 = PrecioCO2 * (1 + inflacion2032 + 0.01)
    gen TarifaCO2_2033 = PrecioCO2 * (1 + inflacion2033 + 0.01)

  // Ejemplo de inflación en 2024 (5%)
    gen emisionesCO2_ano = 1000  // Emisiones de CO2 por año (puedes ajustar este valor)

    * Crear las variables TarifaCO2 para cada año
    gen TarifaCO2_2024 = PrecioCO2 * (1 + inflacion2024 + 0.01)

    * Variables de TarifaCO2 para los años 2025 a 2033
    forvalues year=2025/2033 {
        gen inflacion`year' = runiform(0.02, 0.06)  // Puedes definir rangos para la inflación
        gen TarifaCO2_`year' = PrecioCO2 * (1 + inflacion`year' + 0.01)
    }

    ** Paso 2: Crear las variables impuesto propuesta para los años 2024 a 2033

    * Calcular Impuesto_propuesta para cada año
    gen Impuesto_propuesta_2024 = TarifaCO2_2024 * emisionesCO2_ano

    forvalues year=2025/2033 {
        gen Impuesto_propuesta_`year' = TarifaCO2_`year' * emisionesCO2_ano
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

