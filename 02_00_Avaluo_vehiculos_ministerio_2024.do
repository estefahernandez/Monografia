
*-------------------------------------------------------------------
*
*   Avalúo del ministerio para los vehículos 2024
*     
*   1. Importar los datos en stata es complejo por el peso de los datos, por lo cual, son guardados inmediamente en .dta, para Limpiar y estructurar
*   2. Existen en el ministerios varias clases de vehiculos, los cuales son organizados por clase, teniendo en cuenta cada uno de los años,
*      convirtiendo cada base de datos en un panel por año, avaluo y clase.
*
*-------------------------------------------------------------------


**# Importar Datos del avaluo 2024

**#  Vehiculos 2024

    import excel "$ruta/Data_master/1_Automoviles.xlsx", sheet("Bases Gravables") cellrange(A5:AK4787) firstrow clear // Automoviles 2024

    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/01-Automoviles-2024.dta", replace

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/01-01-Automoviles-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/01-02-Automoviles-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/01-03-Automoviles-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/01-04-Automoviles-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/01-05-Automoviles-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/01-01-Automoviles-2024.dta", clear
            append using "$datacl/01-02-Automoviles-2024.dta"
            append using "$datacl/01-03-Automoviles-2024.dta"
            append using "$datacl/01-04-Automoviles-2024.dta"
            append using "$datacl/01-05-Automoviles-2024.dta"

        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "VEHICULO"

        save "$datacl/01-06-Automoviles-2024.dta", replace  // Se guarda la base para el merge simple o inicial

**# Camionetas y Camperos 2024

    import excel "$ruta/Data_master/2_Camionetas y Camperos.xlsx", sheet("Bases Gravables") cellrange(A5:AK3283) firstrow clear // Camionetas y Camperos 2024

    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/02-Camionetas&Camperos-2024.dta", replace 

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/02-01-Camionetas&Camperos-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/02-02-Camionetas&Camperos-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/02-03-Camionetas&Camperos-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/02-04-Camionetas&Camperos-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/02-05-Camionetas&Camperos-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/02-01-Camionetas&Camperos-2024.dta", clear
            append using "$datacl/02-02-Camionetas&Camperos-2024.dta"
            append using "$datacl/02-03-Camionetas&Camperos-2024.dta"
            append using "$datacl/02-04-Camionetas&Camperos-2024.dta"
            append using "$datacl/02-05-Camionetas&Camperos-2024.dta"

        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "CAMIONETA Y CAMPEROS"

        save "$datacl/02-06-Camionetas&Camperos-2024.dta", replace  // Se guarda la base para el merge simple o inicial

**# Camionetas Doble Cabina 2024

    import excel "$ruta/Data_master/3_Camionetas Doble Cabina.xlsx", sheet("Bases Gravables") cellrange(A5:AK601) firstrow clear // Camionetas Doble Cabina
    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/03-Camionetas-Doble-Cabina-2024.dta", replace 

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/03-01-Camionetas-Doble-Cabina-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/03-02-Camionetas-Doble-Cabina-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/03-03-Camionetas-Doble-Cabina-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/03-04-Camionetas-Doble-Cabina-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/03-05-Camionetas-Doble-Cabina-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/03-01-Camionetas-Doble-Cabina-2024.dta", clear
            append using "$datacl/03-02-Camionetas-Doble-Cabina-2024.dta"
            append using "$datacl/03-03-Camionetas-Doble-Cabina-2024.dta"
            append using "$datacl/03-04-Camionetas-Doble-Cabina-2024.dta"
            append using "$datacl/03-05-Camionetas-Doble-Cabina-2024.dta"
        

        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "CAMIONETAS DOBLE CABINA"

        save "$datacl/03-06-Camionetas-Doble-Cabina-2024.dta", replace  // Se guarda la base para el merge simple o inicial

**# Electricos 2024

    import excel "$ruta/Data_master/4_Eléctricos.xlsx", sheet("Bases Gravables") cellrange(A5:AK168) firstrow clear // Electrico
    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/04-Electricos-2024.dta", replace 

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/04-01-Electricos-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/04-02-Electricos-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/04-03-Electricos-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/04-04-Electricos-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/04-05-Electricos-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/04-01-Electricos-2024.dta", clear
            append using "$datacl/04-02-Electricos-2024.dta"
            append using "$datacl/04-03-Electricos-2024.dta"
            append using "$datacl/04-04-Electricos-2024.dta"
            append using "$datacl/04-05-Electricos-2024.dta"


        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "ELECTRICO"
        //destring CILINDRAJE, i(KW) replace // La variable tenia 300 kw como ejemplo y eliminamos kw para que la variable fuera solo numerica

        save "$datacl/04-06-Electricos-2024.dta", replace  // Se guarda la base para el merge simple o inicial

**# Motocicletas 2024

    import excel "$ruta/Data_master/5_Motocicletas, Motocarros, Cuatrimotos, Mototriciclos, Motocicletas Eléctricas y Motocarros Eléctricos.xlsx", sheet("Bases Gravables") cellrange(A5:AK2527) firstrow clear 
    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/05-Motocicletas-2024.dta", replace 

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/05-01-Motocicletas-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/05-02-Motocicletas-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/05-03-Motocicletas-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/05-04-Motocicletas-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/05-05-Motocicletas-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/05-01-Motocicletas-2024.dta", clear
            append using "$datacl/05-02-Motocicletas-2024.dta"
            append using "$datacl/05-03-Motocicletas-2024.dta"
            append using "$datacl/05-04-Motocicletas-2024.dta"
            append using "$datacl/05-05-Motocicletas-2024.dta"


        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "MOTOCICLETA"

        save "$datacl/05-06-Motocicletas-2024.dta", replace  // Se guarda la base para el merge simple o inicial

**# Pasajeros 2024

    import excel "$ruta/Data_master/6_Pasajeros.xlsx", sheet("Bases Gravables") cellrange(A5:AK867) firstrow clear 
    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/06-Pasajeros-2024.dta", replace 

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/06-01-Pasajeros-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/06-02-Pasajeros-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/06-03-Pasajeros-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/06-04-Pasajeros-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/06-05-Pasajeros-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/06-01-Pasajeros-2024.dta", clear
            append using "$datacl/06-02-Pasajeros-2024.dta"
            append using "$datacl/06-03-Pasajeros-2024.dta"
            append using "$datacl/06-04-Pasajeros-2024.dta"
            append using "$datacl/06-05-Pasajeros-2024.dta"


        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "PASAJEROS"

        save "$datacl/06-06-Pasajeros-2024.dta", replace  // Se guarda la base para el merge simple o inicial

**# Carga 2024

    import excel "$ruta/Data_master/7_Carga.xlsx", sheet("Bases Gravables") cellrange(A5:AK3058) firstrow clear 
    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/07-Carga-2024.dta", replace 

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/07-01-Carga-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/07-02-Carga-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/07-03-Carga-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/07-04-Carga-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/07-05-Carga-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/07-01-Carga-2024.dta", clear
            append using "$datacl/07-02-Carga-2024.dta"
            append using "$datacl/07-03-Carga-2024.dta"
            append using "$datacl/07-04-Carga-2024.dta"
            append using "$datacl/07-05-Carga-2024.dta"


        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "CARGA"

        save "$datacl/07-06-Carga-2024.dta", replace  // Se guarda la base para el merge simple o inicial


**# Ambulancia 2024

    import excel "$ruta/Data_master/8_Ambulancias.xlsx", sheet("Bases Gravables") cellrange(A5:AK46) firstrow clear 
    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/08-Ambulacion-2024.dta", replace 

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/08-01-Ambulacion-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/08-02-Ambulacion-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/08-03-Ambulacion-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/08-04-Ambulacion-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/08-05-Ambulacion-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/08-01-Ambulacion-2024.dta", clear
            append using "$datacl/08-02-Ambulacion-2024.dta"
            append using "$datacl/08-03-Ambulacion-2024.dta"
            append using "$datacl/08-04-Ambulacion-2024.dta"
            append using "$datacl/08-05-Ambulacion-2024.dta"


        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "AMBULANCIA"

        save "$datacl/08-06-Ambulacion-2024.dta", replace  // Se guarda la base para el merge simple o inicial


**# Hibrido 2024

    import excel "$ruta/Data_master/9_Híbridos.xlsx", sheet("Bases Gravables") cellrange(A5:AK164) firstrow clear 
    keep H I /*J*/ AG AH AI AJ AK
    rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
    compress

    save "$datacl/09-Hibridos-2024.dta", replace 

        * Año 2019
            preserve
                keep MARCA  LINEA  M_2019 //CILINDRAJE
                rename M_2019 AVALUO
                gen AÑO = 2019 
                save "$datacl/09-01-Hibridos-2024.dta", replace 
            restore

        * Año 2020
            preserve
                keep MARCA  LINEA  M_2020 //CILINDRAJE
                rename M_2020 AVALUO
                gen AÑO = 2020
                save "$datacl/09-02-Hibridos-2024.dta", replace 
            restore

        * Año 2021
            preserve
                keep MARCA  LINEA  M_2021 //CILINDRAJE
                rename M_2021 AVALUO
                gen AÑO = 2021
                save "$datacl/09-03-Hibridos-2024.dta", replace 
            restore

        * Año 2022
            preserve
                keep MARCA  LINEA  M_2022 //CILINDRAJE
                rename M_2022 AVALUO
                gen AÑO = 2022
                save "$datacl/09-04-Hibridos-2024.dta", replace 
            restore

        * Año 2023
            preserve
                keep MARCA  LINEA  M_2023 //CILINDRAJE
                rename M_2023 AVALUO
                gen AÑO = 2023
                save "$datacl/09-05-Hibridos-2024.dta", replace 
            restore

    * Unión en forma de panel 

        use "$datacl/09-01-Hibridos-2024.dta", clear
            append using "$datacl/09-02-Hibridos-2024.dta"
            append using "$datacl/09-03-Hibridos-2024.dta"
            append using "$datacl/09-04-Hibridos-2024.dta"
            append using "$datacl/09-05-Hibridos-2024.dta"

        ds, has(type string) // Me dice cuales variables son string
        foreach var in `r(varlist)' { 
            replace `var' = upper(`var')    
        }  // Convierte todas las variables string en mayuscula

        order AÑO, first
        gen CLASE = "HIBRIDO"
    
        save "$datacl/09-06-Hibridos-2024.dta", replace  // Se guarda la base para el merge simple o inicial

**# Append datos (Incluyendo las 9 clases del ministerio) Completra

    use "$datacl/01-06-Automoviles-2024.dta", clear
        append using "$datacl/02-06-Camionetas&Camperos-2024.dta"
        append using "$datacl/03-06-Camionetas-Doble-Cabina-2024.dta"
        append using "$datacl/04-06-Electricos-2024.dta"
        // append using "$datacl/05-06-Motocicletas-2024.dta"
        append using "$datacl/06-06-Pasajeros-2024.dta"
        append using "$datacl/07-06-Carga-2024.dta"
        append using "$datacl/08-06-Ambulacion-2024.dta"
        append using "$datacl/09-06-Hibridos-2024.dta"

        sort AÑO
        order AÑO, first

    save "$datacl/01-01-AvaluoColombia-2024.dta", replace

