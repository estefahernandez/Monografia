
*-------------------------------------------------------------------
*
*   Emisiones vehículos
*       * Supuestos emisiones contaminantes en toneladas
*       * Precio al carbon
*       
*-------------------------------------------------------------------

**# Recaudo fiscal del periodo 2023 de la Gobernación de Antioquia

    use "$dCl/GobA_recaudo_fiscal_2023.dta", clear

************************************************************************
*   Emisiones modelo 2023
************************************************************************

    ** Minimo
    gen min_CO2eq_ton = .

        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0002555 + (0.0002555 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1600 & cilindraje < 2000
        replace min_CO2eq_ton = 0.0001558 + (0.0001558 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1600
        replace min_CO2eq_ton = 0.00043205 + (0.00043205 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0002555 if modelo == 2023 & cilindraje == 1591
        replace min_CO2eq_ton = 0.0001558 if modelo == 2023 & cilindraje == 1496
        replace min_CO2eq_ton = 0.00043205 if modelo == 2023 & cilindraje == 1968
        
    ** Media
    gen mean_CO2eq_ton = .

        * Proporcional media
        replace mean_CO2eq_ton = 0.0002635 + (0.0002635 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1600 & cilindraje < 2000
        replace mean_CO2eq_ton = 0.0001634 + (0.0001634 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1600
        replace mean_CO2eq_ton = 0.0004695 + (0.0004695 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0002635 if modelo == 2023 & cilindraje == 1591
        replace mean_CO2eq_ton = 0.0001634 if modelo == 2023 & cilindraje == 1496
        replace mean_CO2eq_ton = 0.0004695 if modelo == 2023 & cilindraje == 1968

    ** Maximo
    gen max_CO2eq_ton = .
    
        * valores proporcionales maximo
        replace max_CO2eq_ton = 0.0002701 + (0.0002701 / 1591) * (cilindraje - 1591) if modelo == 2023 & cilindraje >= 1600 & cilindraje < 2000
        replace max_CO2eq_ton = 0.0001664 + (0.0001664 / 1496) * (cilindraje - 1496) if modelo == 2023 & cilindraje < 1600
        replace max_CO2eq_ton =  0.0008065 + (0.0008065 / 1968) * (cilindraje - 1968) if modelo == 2023 & cilindraje >= 2000

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0002701 if modelo == 2023 & cilindraje == 1591
        replace max_CO2eq_ton = 0.0001664 if modelo == 2023 & cilindraje == 1496
        replace max_CO2eq_ton = 0.0008065 if modelo == 2023 & cilindraje == 1968

************************************************************************
*   Emisiones modelo 2022
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0002842 + (0.0002842 / 1998) * (cilindraje - 1998) if modelo == 2022 & cilindraje >= 2000
        replace min_CO2eq_ton = 0.0002833 + (0.0002833 / 1598) * (cilindraje - 1598) if modelo == 2022 & cilindraje < 2000

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0002842 if modelo == 2022 & cilindraje == 1998
        replace min_CO2eq_ton = 0.0002833 if modelo == 2022 & cilindraje == 1598
        
    ** Media
        * Proporcional media
        replace mean_CO2eq_ton = 0.00029155 + (0.00029155 / 1998) * (cilindraje - 1998) if modelo == 2022 & cilindraje >= 2000
        replace mean_CO2eq_ton = 0.0002888 + (0.0002888 / 1598) * (cilindraje - 1598) if modelo == 2022 & cilindraje < 2000

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.00029155 if modelo == 2022 & cilindraje == 1998
        replace mean_CO2eq_ton = 0.0002888 if modelo == 2022 & cilindraje == 1598

    
    ** Maximo
        * valores proporcionales maximo
        replace max_CO2eq_ton = 0.0003002 + (0.0003002 / 1998) * (cilindraje - 1998) if modelo == 2022 & cilindraje >= 2000
        replace max_CO2eq_ton = 0.0002941 + (0.0002941 / 1598) * (cilindraje - 1598) if modelo == 2022 & cilindraje < 2000

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0003002 if modelo == 2022 & cilindraje == 1998
        replace max_CO2eq_ton = 0.0002941 if modelo == 2022 & cilindraje == 1598

************************************************************************
*   Emisiones modelo 2021
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0003816 + (0.0003816 / 1998) * (cilindraje - 1998) if modelo == 2021

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0003816 if modelo == 2021 & cilindraje == 1998

    ** Media
        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0003928 + (0.0003928 / 1998) * (cilindraje - 1998) if modelo == 2021

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0003928 if modelo == 2021 & cilindraje == 1998
        
    ** Maximo
        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0004136 + (0.0004136 / 1998) * (cilindraje - 1998) if modelo == 2021

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0004136 if modelo == 2021 & cilindraje == 1998


************************************************************************
*   Emisiones modelo 2020
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0003615 + (0.0003615 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace min_CO2eq_ton = 0.0002642 + (0.0002642 / 1598) * (cilindraje - 1598) if modelo == 2020 & cilindraje >= 1600
        replace min_CO2eq_ton = 0.0003095 + (0.0003095 / 1395) * (cilindraje - 1395) if modelo == 2020 &  cilindraje >= 1400 &  cilindraje < 1600
        
        *Coincidencia exactas
        replace min_CO2eq_ton = 0.0003615 if modelo == 2020 & cilindraje == 1389
        replace min_CO2eq_ton = 0.0002642 if modelo == 2020 & cilindraje == 1598
        replace min_CO2eq_ton = 0.0003095 if modelo == 2020 & cilindraje == 1395

    ** Media
        * Proporcional media
        replace mean_CO2eq_ton = 0.0003666 + (0.0003666 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace mean_CO2eq_ton = 0.00026995 + (0.00026995 / 1598) * (cilindraje - 1598) if modelo == 2020 & cilindraje >= 1600
        replace mean_CO2eq_ton = 0.0003449 + (0.0003449 / 1395) * (cilindraje - 1395) if modelo == 2020 & cilindraje >= 1400 &  cilindraje < 1600
    
        *Coincidencia exactas
        replace mean_CO2eq_ton = 0.0003666 if modelo == 2020 & cilindraje == 1389
        replace mean_CO2eq_ton = 0.00026995 if modelo == 2020 & cilindraje == 1598
        replace mean_CO2eq_ton = 0.0003449 if modelo == 2020 & cilindraje == 1395

    ** Maximo
        * valores proporcionales maximo
        replace max_CO2eq_ton = 0.0003729 + (0.0003729 / 1389) * (cilindraje - 1389) if modelo == 2020 & cilindraje < 1400
        replace max_CO2eq_ton = 0.0002755 + (0.0002755 / 1598) * (cilindraje - 1598) if modelo == 2020 & cilindraje >= 1600
        replace max_CO2eq_ton = 0.0004152 + (0.0004152 / 1395) * (cilindraje - 1395) if modelo == 2020 & cilindraje >= 1400 &  cilindraje < 1600

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0003729 if modelo == 2020 & cilindraje == 1389
        replace max_CO2eq_ton = 0.0002755 if modelo == 2020 & cilindraje == 1598
        replace max_CO2eq_ton = 0.0004152 if modelo == 2020 & cilindraje == 1395

************************************************************************
*   Emisiones modelo 2017
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0001662 + (0.0001662 / 1373) * (cilindraje - 1373) if modelo == 2017

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0001662 if modelo == 2017 & cilindraje == 1373

    ** Media
        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0001744 + (0.0001744 / 1373) * (cilindraje - 1373) if modelo == 2017

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0001744 if modelo == 2017 & cilindraje == 1373
        
    ** Maximo
        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.00018 + (0.00018 / 1373) * (cilindraje - 1373) if modelo == 2017

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.00018 if modelo == 2017 & cilindraje == 1373

************************************************************************
*   Emisiones modelo 2016
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.000301133 + (0.000301133 / 1598) * (cilindraje - 1598) if modelo == 2016
        replace min_CO2eq_ton = 0.0002589 + (0.0002589 / 1600) * (cilindraje - 1600) if modelo == 2016
        replace min_CO2eq_ton = 0.0002965 + (0.0002965 / 1998) * (cilindraje - 1998) if modelo == 2016
        replace min_CO2eq_ton = 0.0004355 + (0.0004355 / 1796) * (cilindraje - 1796) if modelo == 2016
        replace min_CO2eq_ton = 0.00054 + (0.00054 / 2477) * (cilindraje - 2477) if modelo == 2016

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.000301133 if modelo == 2016 & cilindraje == 1598
        replace min_CO2eq_ton = 0.0002589 if modelo == 2016 & cilindraje == 1600
        replace min_CO2eq_ton = 0.0002965 if modelo == 2016 & cilindraje == 1998
        replace min_CO2eq_ton = 0.0004355 if modelo == 2016 & cilindraje == 1796
        replace min_CO2eq_ton = 0.00054 if modelo == 2016 & cilindraje == 2477

    ** Media
        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.000302433 + (0.000302433 / 1598) * (cilindraje - 1598) if modelo == 2016
        replace mean_CO2eq_ton = 0.000267 + (0.000267 / 1600) * (cilindraje - 1600) if modelo == 2016
        replace mean_CO2eq_ton = 0.000306 + (0.000306 / 1998) * (cilindraje - 1998) if modelo == 2016
        replace mean_CO2eq_ton = 0.0004593 + (0.0004593 / 1796) * (cilindraje - 1796) if modelo == 2016
        replace mean_CO2eq_ton = 0.0005525 + (0.0005525 / 2477) * (cilindraje - 2477) if modelo == 2016

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.000302433 if modelo == 2016 & cilindraje == 1598
        replace mean_CO2eq_ton = 0.000267 if modelo == 2016 & cilindraje == 1600
        replace mean_CO2eq_ton = 0.000306 if modelo == 2016 & cilindraje == 1998
        replace mean_CO2eq_ton = 0.0004593 if modelo == 2016 & cilindraje == 1796
        replace mean_CO2eq_ton = 0.0005525 if modelo == 2016 & cilindraje == 2477
        
    ** Maximo
        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0003559 + (0.0003559 / 1598) * (cilindraje - 1598) if modelo == 2016  
        replace max_CO2eq_ton = 0.0002691 + (0.0002691 / 1600) * (cilindraje - 1600) if modelo == 2016
        replace max_CO2eq_ton = 0.0003163 + (0.0003163 / 1998) * (cilindraje - 1998) if modelo == 2016
        replace max_CO2eq_ton = 0.0004817 + (0.0004817 / 1796) * (cilindraje - 1796) if modelo == 2016
        replace max_CO2eq_ton = 0.000567 + (0.000567 / 2477) * (cilindraje - 2477) if modelo == 2016

        * Coincidencia exactas
        replace max_CO2eq_ton = 0.0003559 if modelo == 2016 & cilindraje == 1598
        replace max_CO2eq_ton = 0.0002691 if modelo == 2016 & cilindraje == 1600
        replace max_CO2eq_ton = 0.0003163 if modelo == 2016 & cilindraje == 1998
        replace max_CO2eq_ton = 0.0004817 if modelo == 2016 & cilindraje == 1796
        replace max_CO2eq_ton = 0.000567 if modelo == 2016 & cilindraje == 2477


************************************************************************
*   Emisiones modelo 2015
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0002809 + (0.0002809 / 1396) * (cilindraje - 1396) if modelo == 2015

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0002809 if modelo == 2015 & cilindraje == 1396

    ** Media
        * valores proporcionales minimo
        replace mean_CO2eq_ton = .0002847 + (.0002847 / 1396) * (cilindraje - 1396) if modelo == 2015

        * Coincidencia exactas
        replace mean_CO2eq_ton = .0002847 if modelo == 2015 & cilindraje == 1396
        
    ** Maximo
        * valores proporcionales minimo
        replace max_CO2eq_ton = .0002893 + (.0002893 / 1396) * (cilindraje - 1396) if modelo == 2015

        *Coincidencia exactas
        replace max_CO2eq_ton = .0002893 if modelo == 2015 & cilindraje == 1396

************************************************************************
*   Emisiones modelo 2014
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0002677 + (0.0002677 / 1390) * (cilindraje - 1390) if modelo == 2014
        replace min_CO2eq_ton = 0.0002307 + (0.0002307 / 1248) * (cilindraje - 1248) if modelo == 2014

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0002677 if modelo == 2014 & cilindraje == 1373
        replace min_CO2eq_ton = 0.0002307 if modelo == 2014 & cilindraje == 1248

    ** Media
        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0002849 + (0.0002849 / 1390) * (cilindraje - 1390) if modelo == 2014
        replace mean_CO2eq_ton = 0.0002341 + (0.0002341 / 1248) * (cilindraje - 1248) if modelo == 2014

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0002849 if modelo == 2014 & cilindraje == 1390
        replace mean_CO2eq_ton = 0.0002341 if modelo == 2014 & cilindraje == 1248
        
    ** Maximo
        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0003038 + (0.0003038 / 1390) * (cilindraje - 1390) if modelo == 2014
        replace max_CO2eq_ton = 0.0002367 + (0.0002367 / 1248) * (cilindraje - 1248) if modelo == 2014

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0003038 if modelo == 2014 & cilindraje == 1390
        replace max_CO2eq_ton = 0.0002367 if modelo == 2014 & cilindraje == 1248

************************************************************************
*   Emisiones modelo 2013
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0003456 + (0.0003456 / 1330) * (cilindraje - 1330) if modelo == 2013

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0003456 if modelo == 2013 & cilindraje == 1330

    ** Media
        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0003479 + (0.0003479 / 1330) * (cilindraje - 1330) if modelo == 2013

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0003479 if modelo == 2013 & cilindraje == 1330
        
    ** Maximo
        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0003514 + (0.0003514 / 1330) * (cilindraje - 1330) if modelo == 2013

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0003514 if modelo == 2013 & cilindraje == 1330

************************************************************************
*   Emisiones modelo 2012
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0004356 + (0.0004356 / 2500) * (cilindraje - 2500) if modelo == 2012

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0004356 if modelo == 2012 & cilindraje == 2500

    ** Media
        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0004493 + (0.0004493 / 2500) * (cilindraje - 2500) if modelo == 2012

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0004493 if modelo == 2012 & cilindraje == 2500
        
    ** Maximo
        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0004624 + (0.0004624 / 2500) * (cilindraje - 2500) if modelo == 2012

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0004624 if modelo == 2012 & cilindraje == 2500

************************************************************************
*   Emisiones modelo 2011
************************************************************************

    ** Minimo
        * valores proporcionales minimo
        replace min_CO2eq_ton = 0.0002287 + (0.0002287 / 1598) * (cilindraje - 1598) if modelo == 2011

        * Coincidencia exactas
        replace min_CO2eq_ton = 0.0002287 if modelo == 2011 & cilindraje == 1598

    ** Media
        * valores proporcionales minimo
        replace mean_CO2eq_ton = 0.0002347 + (0.0002347 / 1598) * (cilindraje - 1598) if modelo == 2011

        * Coincidencia exactas
        replace mean_CO2eq_ton = 0.0002347 if modelo == 2011 & cilindraje == 1598
        
    ** Maximo
        * valores proporcionales minimo
        replace max_CO2eq_ton = 0.0002404 + (0.0002404 / 1598) * (cilindraje - 1598) if modelo == 2011

        *Coincidencia exactas
        replace max_CO2eq_ton = 0.0002404 if modelo == 2011 & cilindraje == 1598


**# Precio CO2

    gen precio_CO2eq_ton = 23394.60
    label variable precio_CO2eq_ton "Precio x toneladas"

/*
**# Exportación a excel

   export excel using "$excel/Datos_tratados/excel/lineabase2023.xlsx", replace firstrow(variables) */

**# Guardar

    save "$dCl/GobA_emisiones.dta", replace

exit