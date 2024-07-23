

**# Importación de datos

    import excel "$ruta/Data_master/factores de emisión de vehículos livianos.xlsx", sheet("Hoja1") firstrow clear

    compress

    save "$datacl/factores-de-emision-de-vehiculos-livianos.dta", replace

**# Emisiones vehicular

    use "$datacl/factores-de-emision-de-vehiculos-livianos.dta", clear
    
    destring Kilometro, replace force


    rename (Cilindraje C02desvEstandar Modelo) (cilindraje CO2_sd modelo)
    keep cilindraje C02gkm modelo Kilometro CO2_sd

     

    tempfile investigacion
    save `investigacion'


**# Ajustar el Modelo de Regresión Lineal Simple

    use `investigacion', clear

    * Ajustar el modelo de regresión
    regress C02gkm cilindraje 

    * Ver los coeficientes del modelo
    display _b[_cons]
    display _b[cilindraje]

    * Volver a la base de datos del parque automotor
    use "$datacl/impuesto_vehicular_2023", clear

    * Calcular las emisiones de CO2 estimadas
    gen CO2_estimated = _b[_cons] + _b[cilindraje] * cilindraje

    gen CO2_estimated2 = _b[_cons] + _b[cilindraje] * cilindraje + _b[modelo] * modelo

    * Calcular los intervalos de confianza usando la desviación estándar
    gen CO2_lower = CO2_estimated - 1.95 * CO2_sd
    gen CO2_upper = CO2_estimated + 1.95 * CO2_sd



**# Describir los datos de investigación

    describe

    * Resumen estadístico
    summarize cilindraje CO2_media CO2_sd

    * Gráfico de dispersión para visualizar la relación entre cilindraje y CO2
    scatter CO2_media cilindraje    

