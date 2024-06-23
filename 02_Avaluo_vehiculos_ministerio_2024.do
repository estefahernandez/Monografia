
*-------------------------------------------------------------------
*
*   Avalúo del ministerio para los vehículos 2024
*     
*   Limpieza y organización de datos
*
*-------------------------------------------------------------------

**# Importar datos

/* Importar los datos en stata es complejo por el peso de los datos, por lo cual, son guardados inmediamente en .dta, para Limpiar y estructurar*/

    * Datos del avaluo vehiculos 2024

        import excel "$ruta/Data/Ministerio_2024/1_Automoviles.xlsx", sheet("Bases Gravables") cellrange(A5:AK4787) firstrow clear // Automoviles 2024

        keep H I J AG AH AI AJ AK
        rename (H I J AG AH AI AJ AK) (MARCA LINEA CILINDRAJE M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/01-Automoviles-2024.dta", replace

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/01-01-Automoviles-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/01-02-Automoviles-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/01-03-Automoviles-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/01-04-Automoviles-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 CILINDRAJE
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

                save "$ruta/Data_prepared/01-06-Automoviles-2024.dta", replace  // Se guarda la base para el merge simple o inicial


    * Datos del avaluo Camionetas y Camperos 2024

        import excel "$ruta/Data/Ministerio_2024/2_Camionetas y Camperos.xlsx", sheet("Bases Gravables") cellrange(A5:AK3283) firstrow clear // Camionetas y Camperos 2024

        keep H I J AG AH AI AJ AK
        rename (H I J AG AH AI AJ AK) (MARCA LINEA CILINDRAJE M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/02-Camionetas&Camperos-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/02-01-Camionetas&Camperos-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/02-02-Camionetas&Camperos-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/02-03-Camionetas&Camperos-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/02-04-Camionetas&Camperos-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 CILINDRAJE
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

                save "$ruta/Data_prepared/02-06-Camionetas&Camperos-2024.dta", replace  // Se guarda la base para el merge simple o inicial

   * Datos del avaluo Camionetas Doble Cabina 2024

        import excel "$ruta/Data/Ministerio_2024/3_Camionetas Doble Cabina.xlsx", sheet("Bases Gravables") cellrange(A5:AK601) firstrow clear // Camionetas Doble Cabina
        keep H I J AG AH AI AJ AK
        rename (H I J AG AH AI AJ AK) (MARCA LINEA CILINDRAJE M_2019 M_2020 M_2021 M_2022 M_2023)
        compress

        save "$ruta/Data_prepared/03-Camionetas-Doble-Cabina-2024.dta", replace 

            * Año 2019
                preserve
                    keep MARCA  LINEA  M_2019 CILINDRAJE
                    rename M_2019 AVALUO
                    gen AÑO = 2019 
                    save "$ruta/Data_prepared/03-01-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

            * Año 2020
                preserve
                    keep MARCA  LINEA  M_2020 CILINDRAJE
                    rename M_2020 AVALUO
                    gen AÑO = 2020
                    save "$ruta/Data_prepared/03-02-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

            * Año 2021
                preserve
                    keep MARCA  LINEA  M_2021 CILINDRAJE
                    rename M_2021 AVALUO
                    gen AÑO = 2021
                    save "$ruta/Data_prepared/03-03-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

            * Año 2022
                preserve
                    keep MARCA  LINEA  M_2022 CILINDRAJE
                    rename M_2022 AVALUO
                    gen AÑO = 2022
                    save "$ruta/Data_prepared/03-04-Camionetas-Doble-Cabina-2024.dta", replace 
                restore

            * Año 2023
                preserve
                    keep MARCA  LINEA  M_2023 CILINDRAJE
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

                save "$ruta/Data_prepared/03-06-Camionetas-Doble-Cabina-2024.dta", replace  // Se guarda la base para el merge simple o inicial

