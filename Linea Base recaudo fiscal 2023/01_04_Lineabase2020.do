
*-------------------------------------------------------------------
*
*   Linea Base 2020
*     - Se limpia la base de datos con base al modelo   
*     - Se agregan las emisiones de coincidencia y proporcionales
*     - Se guarda la base
*-------------------------------------------------------------------

**# importar recaudo fiscal 2023 Gobernación de Antioquia

    use "$datacl/Parque_automotor_impuesto_vehicular_año_fiscal_2023.dta", clear

**# Limpieza 

    * Quedarme solo con estas observaciones
    keep if inlist(clase, "AUTOMOVIL", "CAMIONETA(C)", "CAMPERO")
    keep if uso == "PARTICULAR"
    keep if estado_agrupado == "PAGO DE LA OBLIGACION"
    keep if modelo == 2020

    * Eliminar variables
    drop capacidad vigencia estado_agrupado combustible uso

    * Cilindrajes erroneos
    drop if cilindraje <= 800

**# Emisiones

    ** Minimo

        gen min_CO2eq_ton = .

        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0003615 + (0.0003615 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace min_CO2eq_ton = 0.0002642 + (0.0002642 / 1598) * (cilindraje - 1598) if modelo == 2020 & cilindraje >= 1600
        replace min_CO2eq_ton = 0.0003095 + (0.0003095 / 1395) * (cilindraje - 1395) if modelo == 2020 &  cilindraje >= 1400 &  cilindraje < 1600
        
        *Coincidencia exactas
        replace min_CO2eq_ton = 0.0003615 if modelo == 2020 & cilindraje == 1389
        replace min_CO2eq_ton = 0.0002642 if modelo == 2020 & cilindraje == 1598
        replace min_CO2eq_ton = 0.0003095 if modelo == 2020 & cilindraje == 1395

    ** Media

        gen mean_CO2eq_ton = .

        * Proporcional media
        replace mean_CO2eq_ton = 0.0003666 + (0.0003666 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace mean_CO2eq_ton = 0.00026995 + (0.00026995 / 1598) * (cilindraje - 1598) if modelo == 2020 & cilindraje >= 1600
        replace mean_CO2eq_ton = 0.0003449 + (0.0003449 / 1395) * (cilindraje - 1395) if modelo == 2020 & cilindraje >= 1400 &  cilindraje < 1600
    
        *Coincidencia exactas
        replace mean_CO2eq_ton = 0.0003666 if modelo == 2020 & cilindraje == 1389
        replace mean_CO2eq_ton = 0.00026995 if modelo == 2020 & cilindraje == 1598
        replace mean_CO2eq_ton = 0.0003449 if modelo == 2020 & cilindraje == 1395

    ** Maximo

        gen max_CO2eq_ton = .

        * valores proporcionales maximo
        replace max_CO2eq_ton = 0.0003729 + (0.0003729 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace max_CO2eq_ton = 0.0002755 + (0.0002755 / 1598) * (cilindraje - 1598) if modelo == 2020 & cilindraje >= 1600
        replace max_CO2eq_ton = 0.0004152 + (0.0004152 / 1395) * (cilindraje - 1395) if modelo == 2020 & cilindraje >= 1400 &  cilindraje < 1600

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0003729 if modelo == 2020 & cilindraje == 1389
        replace max_CO2eq_ton = 0.0002755 if modelo == 2020 & cilindraje == 1598
        replace max_CO2eq_ton = 0.0004152 if modelo == 2020 & cilindraje == 1395

**# Eliminación observaciones vacías

     misstable summarize // Observar todas la variables

**# Kilometros

    gen Km = 15000
    gen Km_sd = 3000

**# Precio CO2

    gen precio_CO2eq_ton = .
    replace precio_CO2eq_ton = 23394.60
    label variable precio_CO2eq_ton "Precio x toneladas"

**# Exportación a excel

//    export excel using "$excel/Datos_tratados/excel/lineabase2020.xlsx", replace firstrow(variables)

**# Guardar

    save "$datacl/Linea_base_modelo_2020.dta", replace
