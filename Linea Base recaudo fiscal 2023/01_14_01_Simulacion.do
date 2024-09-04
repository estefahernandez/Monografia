
*-------------------------------------------------------------------
*
*   Recaudo fiscal 2023
*   - Modelos de vehículos desde 2011 hasta 2023
*   - Se genera una distribución PERT para generar la inflación
*    
*
*-------------------------------------------------------------------


**# Append Linea Base desde 2011 hasta 2023

use "$datacl/Linea_base_modelo_2023.dta", clear

append using "$datacl/Linea_base_modelo_2022.dta"
append using "$datacl/Linea_base_modelo_2021.dta"
append using "$datacl/Linea_base_modelo_2020.dta"
append using "$datacl/Linea_base_modelo_2017.dta"
append using "$datacl/Linea_base_modelo_2016.dta"
append using "$datacl/Linea_base_modelo_2015.dta"
append using "$datacl/Linea_base_modelo_2014.dta"
append using "$datacl/Linea_base_modelo_2013.dta"
append using "$datacl/Linea_base_modelo_2012.dta"
append using "$datacl/Linea_base_modelo_2011.dta"


**# Formato variables

format precio_CO2eq_ton %12.0fc
format impuesto %12.0fc


**# Guardar el documento en excel

//    export excel using "$excel/Datos_tratados/excel/lineabase_allmodelos.xlsx", replace firstrow(variables)

**# Distribución normal Km total

    // gen km_total = .
    // replace km_total = rnormal(15000, 3000)
    // histogram km_total

    // drop Km Km_sd

**# Distribucion PERT emisiones

    // * Definir parámetros PERT
    // local min = min_CO2eq_ton
    // local mode = mean_CO2eq_ton
    // local max = max_CO2eq_ton

    // * Calcular los parámetros alpha y beta para la distribución beta
    // local alpha = 1 + 4 * ((`mode' - `min') / (`max' - `min'))
    // local beta = 1 + 4 * ((`max' - `mode') / (`max' - `min'))

    // * Generar datos simulados
    // generate emisiones_CO2eq_ton = `min' + (`max' - `min') * rbeta(`alpha', `beta') //if _n == 1

**# Guardar data set 

    save "$datacl/simulacion.dta", replace

**# Simulacion Monte Carlo

    ** Paso 1: Definir el programa para la simulación

    capture program drop simulate_total_tax1

        program simulate_total_tax1, rclass
            // Limpiar el conjunto de datos
            drop _all
            
            // Restaurar el conjunto de datos original
            use "$datacl/simulacion.dta", clear

            // Generar datos simulados para km_total
            gen km_total = rnormal(15000, 3000)

        // Verificar que los parámetros PERT estén definidos
            assert !missing(min_CO2eq_ton) & !missing(mean_CO2eq_ton) & !missing(max_CO2eq_ton)

            // Definir parámetros PERT
            local min = min_CO2eq_ton[1]
            local mode = mean_CO2eq_ton[1]
            local max = max_CO2eq_ton[1]

            // Calcular los parámetros alpha y beta para la distribución beta
            local alpha = 1 + 4 * ((`mode' - `min') / (`max' - `min'))
            local beta = 1 + 4 * ((`max' - `mode') / (`max' - `min'))

            // Generar datos simulados para emisiones_CO2eq_ton
            gen emisiones_CO2eq_ton = `min' + (`max' - `min') * rbeta(`alpha', `beta')
            
            // Calcular total_impuesto para cada observación
            gen total_impuesto = km_total * emisiones_CO2eq_ton * precio_CO2eq_ton
            
            // Devolver el resultado
            return scalar total_impuesto_sum = sum(total_impuesto)
        end


    ** Paso 2: Realizar la simulación

        // Establecer la semilla para la reproducibilidad
        set seed 12345

        // Realizar la simulación
        simulate total_impuesto_sum=r(total_impuesto_sum), reps(10000) nodots: simulate_total_tax1
        format total_impuesto_sum %12.0fc


    ** Paso 3: Analizar los resultados

         // Resumen de los resultados
        summarize total_impuesto_sum

        // Graficar la distribución de total_impuesto_sum
        histogram total_impuesto_sum, normal




**# Inflación







**# Distribución PERT- Inflación

    * Definir parámetros PERT
    local min = 0.02
    local mode = 0.03
    local max = 0.10

    * Calcular los parámetros alpha y beta para la distribución beta
    local alpha = 1 + 4 * ((`mode' - `min') / (`max' - `min'))
    local beta = 1 + 4 * ((`max' - `mode') / (`max' - `min'))

    * Generar datos simulados
    generate inflacion = `min' + (`max' - `min') * rbeta(`alpha', `beta') in 1/10

    * Visualización de la distribución
    // histogram pert, name(HistPERT) title("Simulated PERT Distribution") width(0.1)

**# Presento valor vehícular proyeccion por 10 año

    gen valorpresunto_2025 = valor_presunto*(1-inflacion[1])
    format valorpresunto_2025 %12.0fc

    gen valorpresunto_2026 = valorpresunto_2025*(1-inflacion[2])
    format valorpresunto_2026 %12.0fc

    gen valorpresunto_2027 = valorpresunto_2026*(1-inflacion[3])
    format valorpresunto_2027 %12.0fc

    gen valorpresunto_2028 = valorpresunto_2027*(1-inflacion[4])
    format valorpresunto_2028 %12.0fc

    gen valorpresunto_2029 = valorpresunto_2028*(1-inflacion[5])
    format valorpresunto_2029 %12.0fc

    gen valorpresunto_2030 = valorpresunto_2029*(1-inflacion[6])
    format valorpresunto_2030 %12.0fc

    gen valorpresunto_2031 = valorpresunto_2030*(1-inflacion[7])
    format valorpresunto_2031 %12.0fc

    gen valorpresunto_2032 = valorpresunto_2031*(1-inflacion[8])
    format valorpresunto_2032 %12.0fc

    gen valorpresunto_2033 = valorpresunto_2032*(1-inflacion[9])
    format valorpresunto_2033 %12.0fc

    gen valorpresunto_2034 = valorpresunto_2033*(1-inflacion[10])
    format valorpresunto_2034 %12.0fc

**# tasa impositiva por rango de Presento valor vehícular

