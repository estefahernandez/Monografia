
*-------------------------------------------------------------------
*
*   Avalúo del ministerio para los vehículos 2024
*     
*   Limpieza y organización de datos
*
*-------------------------------------------------------------------

**# Importar datos

/* Importar los datos en stata es complejo por el peso de los datos, por lo cual, son guardados inmediamente en .dta, para Limpiar y estructurar*/

    // Datos del avaluo vehiculos 2024

        import excel "$ruta/Data/Ministerio_2024/1_Automoviles.xlsx", sheet("Bases Gravables") cellrange(A5:AK4787) firstrow clear // Automoviles 2024

        keep H I /*J*/ AG AH AI AJ AK
        rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/01-Automoviles-2024.dta", replace

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 //CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/01-01-Automoviles-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 //CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/01-02-Automoviles-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 //CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/01-03-Automoviles-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 //CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/01-04-Automoviles-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 //CILINDRAJE
                    rename M_2023 AVALUO
                    gen AÑO = 2023
                    save "$ruta/Data_prepared/01-05-Automoviles-2024.dta", replace 
                restore

        * Unión en forma de panel 

                use "$ruta/Data_prepared/01-01-Automoviles-2024.dta", clear
                    append using "$ruta/Data_prepared/01-02-Automoviles-2024.dta"
                    append using "$ruta/Data_prepared/01-03-Automoviles-2024.dta"
                    append using "$ruta/Data_prepared/01-04-Automoviles-2024.dta"
                    append using "$ruta/Data_prepared/01-05-Automoviles-2024.dta"

                ds, has(type string) // Me dice cuales variables son string
                foreach var in `r(varlist)' { 
                    replace `var' = upper(`var')    
                }  // Convierte todas las variables string en mayuscula

                order AÑO, first
                duplicates report LINEA MARCA
                duplicates drop LINEA MARCA, force
                gen CLASE = "VEHICULO"

                save "$ruta/Data_prepared/01-06-Automoviles-2024.dta", replace  // Se guarda la base para el merge simple o inicial


    // Datos del avaluo Camionetas y Camperos 2024

        import excel "$ruta/Data/Ministerio_2024/2_Camionetas y Camperos.xlsx", sheet("Bases Gravables") cellrange(A5:AK3283) firstrow clear // Camionetas y Camperos 2024

        keep H I /*J*/ AG AH AI AJ AK
        rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/02-Camionetas&Camperos-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 //CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/02-01-Camionetas&Camperos-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 //CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/02-02-Camionetas&Camperos-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 //CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/02-03-Camionetas&Camperos-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 //CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/02-04-Camionetas&Camperos-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 //CILINDRAJE
                    rename M_2023 AVALUO
                    gen AÑO = 2023
                    save "$ruta/Data_prepared/02-05-Camionetas&Camperos-2024.dta", replace 
                restore

        * Unión en forma de panel 

                use "$ruta/Data_prepared/02-01-Camionetas&Camperos-2024.dta", clear
                    append using "$ruta/Data_prepared/02-02-Camionetas&Camperos-2024.dta"
                    append using "$ruta/Data_prepared/02-03-Camionetas&Camperos-2024.dta"
                    append using "$ruta/Data_prepared/02-04-Camionetas&Camperos-2024.dta"
                    append using "$ruta/Data_prepared/02-05-Camionetas&Camperos-2024.dta"

                ds, has(type string) // Me dice cuales variables son string
                foreach var in `r(varlist)' { 
                    replace `var' = upper(`var')    
                }  // Convierte todas las variables string en mayuscula

                order AÑO, first
                duplicates report LINEA MARCA
                duplicates drop LINEA MARCA, force
                gen CLASE = "CAMIONETA Y CAMPEROS"

                save "$ruta/Data_prepared/02-06-Camionetas&Camperos-2024.dta", replace  // Se guarda la base para el merge simple o inicial

   // Datos del avaluo Camionetas Doble Cabina 2024

        import excel "$ruta/Data/Ministerio_2024/3_Camionetas Doble Cabina.xlsx", sheet("Bases Gravables") cellrange(A5:AK601) firstrow clear // Camionetas Doble Cabina
        keep H I /*J*/ AG AH AI AJ AK
        rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/03-Camionetas-Doble-Cabina-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 //CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/03-01-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 //CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/03-02-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 //CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/03-03-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 //CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/03-04-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 //CILINDRAJE
                    rename M_2023 AVALUO
                    gen AÑO = 2023
                    save "$ruta/Data_prepared/03-05-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

        * Unión en forma de panel 

                use "$ruta/Data_prepared/03-01-Camionetas-Doble-Cabina-2024.dta", clear
                    append using "$ruta/Data_prepared/03-02-Camionetas-Doble-Cabina-2024.dta"
                    append using "$ruta/Data_prepared/03-03-Camionetas-Doble-Cabina-2024.dta"
                    append using "$ruta/Data_prepared/03-04-Camionetas-Doble-Cabina-2024.dta"
                    append using "$ruta/Data_prepared/03-05-Camionetas-Doble-Cabina-2024.dta"

                ds, has(type string) // Me dice cuales variables son string
                foreach var in `r(varlist)' { 
                    replace `var' = upper(`var')    
                }  // Convierte todas las variables string en mayuscula

                order AÑO, first
                duplicates report LINEA MARCA
                duplicates drop LINEA MARCA, force
                gen CLASE = "CAMIONETAS DOBLE CABINA"

                save "$ruta/Data_prepared/03-06-Camionetas-Doble-Cabina-2024.dta", replace  // Se guarda la base para el merge simple o inicial

   // Datos del avaluo Electricos 2024

        import excel "$ruta/Data/Ministerio_2024/4_Eléctricos.xlsx", sheet("Bases Gravables") cellrange(A5:AK168) firstrow clear // Electrico
        keep H I /*J*/ AG AH AI AJ AK
        rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/03-Electricos-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 //CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/04-01-Electricos-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 //CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/04-02-Electricos-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 //CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/04-03-Electricos-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 //CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/04-04-Electricos-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 //CILINDRAJE
                    rename M_2023 AVALUO
                    gen AÑO = 2023
                    save "$ruta/Data_prepared/04-05-Electricos-2024.dta", replace 
                restore

        * Unión en forma de panel 

                use "$ruta/Data_prepared/04-01-Electricos-2024.dta", clear
                    append using "$ruta/Data_prepared/04-02-Electricos-2024.dta"
                    append using "$ruta/Data_prepared/04-03-Electricos-2024.dta"
                    append using "$ruta/Data_prepared/04-04-Electricos-2024.dta"
                    append using "$ruta/Data_prepared/04-05-Electricos-2024.dta"

                ds, has(type string) // Me dice cuales variables son string
                foreach var in `r(varlist)' { 
                    replace `var' = upper(`var')    
                }  // Convierte todas las variables string en mayuscula

                order AÑO, first
                duplicates report LINEA MARCA
                duplicates drop LINEA MARCA, force
                gen CLASE = "ELECTRICO"
                //destring CILINDRAJE, i(KW) replace // La variable tenia 300 kw como ejemplo y eliminamos kw para que la variable fuera solo numerica

                save "$ruta/Data_prepared/04-06-Electricos-2024.dta", replace  // Se guarda la base para el merge simple o inicial

   // Datos del avaluo Motocicletas 2024

        import excel "$ruta/Data/Ministerio_2024/5_Motocicletas, Motocarros, Cuatrimotos, Mototriciclos, Motocicletas Eléctricas y Motocarros Eléctricos.xlsx", sheet("Bases Gravables") cellrange(A5:AK2527) firstrow clear 
        keep H I /*J*/ AG AH AI AJ AK
        rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/05-Motocicletas-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 //CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/05-01-Motocicletas-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 //CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/05-02-Motocicletas-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 //CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/05-03-Motocicletas-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 //CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/05-04-Motocicletas-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 //CILINDRAJE
                    rename M_2023 AVALUO
                    gen AÑO = 2023
                    save "$ruta/Data_prepared/05-05-Motocicletas-2024.dta", replace 
                restore

        * Unión en forma de panel 

                use "$ruta/Data_prepared/05-01-Motocicletas-2024.dta", clear
                    append using "$ruta/Data_prepared/05-02-Motocicletas-2024.dta"
                    append using "$ruta/Data_prepared/05-03-Motocicletas-2024.dta"
                    append using "$ruta/Data_prepared/05-04-Motocicletas-2024.dta"
                    append using "$ruta/Data_prepared/05-05-Motocicletas-2024.dta"

                ds, has(type string) // Me dice cuales variables son string
                foreach var in `r(varlist)' { 
                    replace `var' = upper(`var')    
                }  // Convierte todas las variables string en mayuscula

                order AÑO, first
                duplicates report LINEA MARCA
                duplicates drop LINEA MARCA, force
                gen CLASE = "MOTOCICLETA"

                save "$ruta/Data_prepared/05-06-Motocicletas-2024.dta", replace  // Se guarda la base para el merge simple o inicial

   // Datos del avaluo Pasajeros 2024

        import excel "$ruta/Data/Ministerio_2024/6_Pasajeros.xlsx", sheet("Bases Gravables") cellrange(A5:AK867) firstrow clear 
        keep H I /*J*/ AG AH AI AJ AK
        rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/06-Pasajeros-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 //CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/06-01-Pasajeros-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 //CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/06-02-Pasajeros-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 //CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/06-03-Pasajeros-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 //CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/06-04-Pasajeros-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 //CILINDRAJE
                    rename M_2023 AVALUO
                    gen AÑO = 2023
                    save "$ruta/Data_prepared/06-05-Pasajeros-2024.dta", replace 
                restore

        * Unión en forma de panel 

                use "$ruta/Data_prepared/06-01-Pasajeros-2024.dta", clear
                    append using "$ruta/Data_prepared/06-02-Pasajeros-2024.dta"
                    append using "$ruta/Data_prepared/06-03-Pasajeros-2024.dta"
                    append using "$ruta/Data_prepared/06-04-Pasajeros-2024.dta"
                    append using "$ruta/Data_prepared/06-05-Pasajeros-2024.dta"

                ds, has(type string) // Me dice cuales variables son string
                foreach var in `r(varlist)' { 
                    replace `var' = upper(`var')    
                }  // Convierte todas las variables string en mayuscula

                order AÑO, first
                duplicates report LINEA MARCA
                duplicates drop LINEA MARCA, force
                gen CLASE = "PASAJEROS"

                save "$ruta/Data_prepared/06-06-Pasajeros-2024.dta", replace  // Se guarda la base para el merge simple o inicial

   // Datos del avaluo Carga 2024

        import excel "$ruta/Data/Ministerio_2024/7_Carga.xlsx", sheet("Bases Gravables") cellrange(A5:AK3058) firstrow clear 
        keep H I /*J*/ AG AH AI AJ AK
        rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/07-Carga-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 //CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/07-01-Carga-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 //CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/07-02-Carga-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 //CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/07-03-Carga-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 //CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/07-04-Carga-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 //CILINDRAJE
                    rename M_2023 AVALUO
                    gen AÑO = 2023
                    save "$ruta/Data_prepared/07-05-Carga-2024.dta", replace 
                restore

        * Unión en forma de panel 

                use "$ruta/Data_prepared/07-01-Carga-2024.dta", clear
                    append using "$ruta/Data_prepared/07-02-Carga-2024.dta"
                    append using "$ruta/Data_prepared/07-03-Carga-2024.dta"
                    append using "$ruta/Data_prepared/07-04-Carga-2024.dta"
                    append using "$ruta/Data_prepared/07-05-Carga-2024.dta"

                ds, has(type string) // Me dice cuales variables son string
                foreach var in `r(varlist)' { 
                    replace `var' = upper(`var')    
                }  // Convierte todas las variables string en mayuscula

                order AÑO, first
                duplicates report LINEA MARCA
                duplicates drop LINEA MARCA, force
                gen CLASE = "CARGA"

                save "$ruta/Data_prepared/07-06-Carga-2024.dta", replace  // Se guarda la base para el merge simple o inicial


   // Datos del avaluo Ambulancia 2024

        import excel "$ruta/Data/Ministerio_2024/8_Ambulancias.xlsx", sheet("Bases Gravables") cellrange(A5:AK46) firstrow clear 
        keep H I /*J*/ AG AH AI AJ AK
        rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/08-Ambulacion-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 //CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/08-01-Ambulacion-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 //CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/08-02-Ambulacion-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 //CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/08-03-Ambulacion-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 //CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/08-04-Ambulacion-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 //CILINDRAJE
                    rename M_2023 AVALUO
                    gen AÑO = 2023
                    save "$ruta/Data_prepared/08-05-Ambulacion-2024.dta", replace 
                restore

        * Unión en forma de panel 

                use "$ruta/Data_prepared/08-01-Ambulacion-2024.dta", clear
                    append using "$ruta/Data_prepared/08-02-Ambulacion-2024.dta"
                    append using "$ruta/Data_prepared/08-03-Ambulacion-2024.dta"
                    append using "$ruta/Data_prepared/08-04-Ambulacion-2024.dta"
                    append using "$ruta/Data_prepared/08-05-Ambulacion-2024.dta"

                ds, has(type string) // Me dice cuales variables son string
                foreach var in `r(varlist)' { 
                    replace `var' = upper(`var')    
                }  // Convierte todas las variables string en mayuscula

                order AÑO, first
                duplicates report LINEA MARCA
                duplicates drop LINEA MARCA, force
                gen CLASE = "AMBULANCIA"

                save "$ruta/Data_prepared/08-06-Ambulacion-2024.dta", replace  // Se guarda la base para el merge simple o inicial


       // Datos del avaluo Hibrido 2024

            import excel "$ruta/Data/Ministerio_2024/9_Híbridos.xlsx", sheet("Bases Gravables") cellrange(A5:AK164) firstrow clear 
            keep H I /*J*/ AG AH AI AJ AK
            rename (H I /*J*/ AG AH AI AJ AK) (MARCA LINEA /*CILINDRAJE*/ M_2019 M_2020 M_2021 M_2022 M_2023)
            compress

            save "$ruta/Data_prepared/09-Hibridos-2024.dta", replace 

                * Año 2019
                    preserve
                        keep MARCA  LINEA  M_2019 //CILINDRAJE
                        rename M_2019 AVALUO
                        gen AÑO = 2019 
                        save "$ruta/Data_prepared/09-01-Hibridos-2024.dta", replace 
                    restore

                * Año 2020
                    preserve
                        keep MARCA  LINEA  M_2020 //CILINDRAJE
                        rename M_2020 AVALUO
                        gen AÑO = 2020
                        save "$ruta/Data_prepared/09-02-Hibridos-2024.dta", replace 
                    restore

                * Año 2021
                    preserve
                        keep MARCA  LINEA  M_2021 //CILINDRAJE
                        rename M_2021 AVALUO
                        gen AÑO = 2021
                        save "$ruta/Data_prepared/09-03-Hibridos-2024.dta", replace 
                    restore

                * Año 2022
                    preserve
                        keep MARCA  LINEA  M_2022 //CILINDRAJE
                        rename M_2022 AVALUO
                        gen AÑO = 2022
                        save "$ruta/Data_prepared/09-04-Hibridos-2024.dta", replace 
                    restore

                * Año 2023
                    preserve
                        keep MARCA  LINEA  M_2023 //CILINDRAJE
                        rename M_2023 AVALUO
                        gen AÑO = 2023
                        save "$ruta/Data_prepared/09-05-Hibridos-2024.dta", replace 
                    restore

            * Unión en forma de panel 

                    use "$ruta/Data_prepared/09-01-Hibridos-2024.dta", clear
                        append using "$ruta/Data_prepared/09-02-Hibridos-2024.dta"
                        append using "$ruta/Data_prepared/09-03-Hibridos-2024.dta"
                        append using "$ruta/Data_prepared/09-04-Hibridos-2024.dta"
                        append using "$ruta/Data_prepared/09-05-Hibridos-2024.dta"

                    ds, has(type string) // Me dice cuales variables son string
                    foreach var in `r(varlist)' { 
                        replace `var' = upper(`var')    
                    }  // Convierte todas las variables string en mayuscula

                    order AÑO, first
                    duplicates report LINEA MARCA
                    duplicates drop LINEA MARCA, force
                    gen CLASE = "HIBRIDO"
                

                    save "$ruta/Data_prepared/09-06-Hibridos-2024.dta", replace  // Se guarda la base para el merge simple o inicial

**# Append datos (Incluyendo las 9 clases del ministerio)

    use "$ruta/Data_prepared/01-06-Automoviles-2024.dta", clear
        append using "$ruta/Data_prepared/02-06-Camionetas&Camperos-2024.dta"
        append using "$ruta/Data_prepared/03-06-Camionetas-Doble-Cabina-2024.dta"
        append using "$ruta/Data_prepared/04-06-Electricos-2024.dta"
        append using "$ruta/Data_prepared/05-06-Motocicletas-2024.dta"
        append using "$ruta/Data_prepared/06-06-Pasajeros-2024.dta"
        append using "$ruta/Data_prepared/07-06-Carga-2024.dta"
        append using "$ruta/Data_prepared/08-06-Ambulacion-2024.dta"
        append using "$ruta/Data_prepared/09-06-Hibridos-2024.dta"
    
    save "$ruta/Data_prepared/01-01-AvaluoColombia-2024.dta", replace


