
*-------------------------------------------------------------------
*
*       Alternativa Política
*     
*   
*
*-------------------------------------------------------------------

**# Impotación de datos

    use "$datacl/Linea_Base_Parque_automotor_impuesto_vehicular_ano_fiscal_2023", clear

**# Datos emisiones

    gen emisiones = .
    replace emisiones = 229.7 if modelo == 2011 & cilindraje == 1598
    replace emisiones = 405.5 if modelo == 2012 & cilindraje == 2500
    replace emisiones = 336.4 if modelo == 2013 & cilindraje == 1330
    replace emisiones = 258.5 if modelo == 2014 & cilindraje == 1390
    replace emisiones = 212.5 if modelo == 2014 & cilindraje == 1248
    replace emisiones = 211.3 if modelo == 2015 & cilindraje == 1396
    replace emisiones = 309.4 if modelo == 2015 & cilindraje == 199
    replace emisiones = 300.9 if modelo == 2016 & cilindraje == 1998
    replace emisiones = 325 if modelo == 2016 & cilindraje == 1598
    replace emisiones = 215.6 if modelo == 2016 & cilindraje == 1598
    replace emisiones = 344.9 if modelo == 2016 & cilindraje == 1598
    replace emisiones = 214.3 if modelo == 2016 & cilindraje == 1598
    replace emisiones = 402.2 if modelo == 2016 & cilindraje == 2477
    replace emisiones = 246.3 if modelo == 2016 & cilindraje == 1598
    replace emisiones = 258.5 if modelo == 2016 & cilindraje == 1600
    replace emisiones = 444.6 if modelo == 2016 & cilindraje == 1796
    replace emisiones = 373.8 if modelo == 2016 & cilindraje == 1598
    replace emisiones = 168.1 if modelo == 2017 & cilindraje == 1373
    replace emisiones = 354.6 if modelo == 2020 & cilindraje == 1389
    replace emisiones = 331.8 if modelo == 2020 & cilindraje == 1395
    replace emisiones = 272.8 if modelo == 2020 & cilindraje == 1598
    replace emisiones = 251.7 if modelo == 2020 & cilindraje == 1598
    replace emisiones = 384.1 if modelo == 2021 & cilindraje == 1998
    replace emisiones = 268.8 if modelo == 2022 & cilindraje == 1598
    replace emisiones = 261.9 if modelo == 2022 & cilindraje == 1998
    replace emisiones = 309.6 if modelo == 2022 & cilindraje == 1998
    replace emisiones = 161.2 if modelo == 2023 & cilindraje == 1496
    replace emisiones = 433.4 if modelo == 2023 & cilindraje == 1968
    replace emisiones = 346.9 if modelo == 2023 & cilindraje == 1968
    replace emisiones = 238.1 if modelo == 2023 & cilindraje == 1591
    replace emisiones = 370 if modelo == 2024 & cilindraje == 1333






**# Selección de información modelos 2022 - 2024



