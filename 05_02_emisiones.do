

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

