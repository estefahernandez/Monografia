

**# Importación de datos

    import excel "$ruta/Data_master/factores de emisión de vehículos livianos.xlsx", sheet("Hoja1") firstrow clear

    compress

    save "$datacl/factores-de-emision-de-vehiculos-livianos.dta", replace

**# Emisiones vehicular

    use "$datacl/factores-de-emision-de-vehiculos-livianos.dta", clear

    * Restricción modelo
    keep if Modelo >= 2011
    sort Modelo

    drop COgkm Noxgkm NOgkm NO2gkm HCgkm PMmgkm PNx1012km


**# Emisiones vehículares 

    ** Importación de datos 
        import excel "$ruta/Data_master/factores de emisión de vehículos livianos.xlsx", sheet("Hoja2") firstrow clear

        compress

        save "$datacl/factores-de-emision-de-vehiculos-livianos-distribución.dta", replace
    
**# Emisiones agregado

    use "$datacl/factores-de-emision-de-vehiculos-livianos-distribución.dta", clear

    * Convertimos las emisiones de CO a equivalencias de CO2
    gen min_CO_CO2eq_gkm = min_COgkm  * 2
    gen mean_CO_CO2eq_gkm = mean_COgkm * 2
    gen max_CO_CO2eq_gkm = max_COgkm * 2

    * Convertimos las emisiones de NOx a equivalencias de CO2
    gen min_NOx_CO2eq_gkm = min_Noxgkm * 150
    gen mean_Nox_CO2eq_gkm = mean_Noxgkm * 150
    gen max_Nox_CO2eq_gkm = max_Noxgkm * 150

    keep Modelo Cilindraje Kilometro Rendkmgal min_CO2gkm mean_CO2gkm max_CO2gkm min_CO_CO2eq_gkm /// 
    mean_CO_CO2eq_gkm max_CO_CO2eq_gkm min_NOx_CO2eq_gkm mean_Nox_CO2eq_gkm max_Nox_CO2eq_gkm

    * Co2eq_agregado
    gen min_Co2eq_gkm_agregado = min_CO2gkm + min_CO_CO2eq_gkm + min_NOx_CO2eq_gkm
    gen mean_Co2eq_gkm_agregado = min_CO2gkm + min_CO_CO2eq_gkm + min_NOx_CO2eq_gkm
    gen max_Co2eq_gkm_agregado = min_CO2gkm + min_CO_CO2eq_gkm + min_NOx_CO2eq_gkm

    keep Modelo Cilindraje Kilometro min_Co2eq_gkm_agregado mean_Co2eq_gkm_agregado max_Co2eq_gkm_agregado

    save "$datacl/factores-de-emision-de-vehiculos-livianos-CO2equivalente_agregado.dta", replace