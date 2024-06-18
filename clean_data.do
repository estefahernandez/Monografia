*-------------------------------------------------------------------
*
*     Clean data
*     
*    Organizar, limpiar y estructurar la base de datos para aplicar
*    el Método de simulación Monte Carlo
*
*-------------------------------------------------------------------

// Ruta

global ruta "/Users/estefania/Library/CloudStorage/OneDrive-UniversidaddeAntioquia/Monografia de grado"


//### Importar datos
/* Se importa los datos para organizarlos y guardarlos en data set */

* Avalúo del ministerio de transporte año 2023
import excel "$ruta/Data/Tabla 1.- Automóviles. BG 2023.xlsx", sheet("Bases Gravables") cellrange(A6:AJ4738) clear

rename (A B C D E F G H I J K L) (CTR ID FECHA PROYECCION TIPO CLASE MARCA LINEA CILINDRAJE CAPACIDAD_TONELADAS CAPCIDAD_PASAJEROS M_antes_1998)
rename (M N O P Q R S T U V W X Y Z AA AB AC AD AE AF AG AH AI AJ) (M_1999 M_2000 M_2001 M_2002 M_2003 M_2004 M_2005 M_2006 M_2007 M_2008 M_2009 M_2010 M_2011 M_2012 M_2013 M_2014 M_2015 M_2016 M_2017 M_2018 M_2019 M_2020 M_2021 M_2022)


// Contrucción data set con las ventas desde 2019 hasta 2023

    * Registro de Andemos de las ventas realizadas 2019-2020

        import excel "$ruta/Data/Ventas_Andemos.xlsx", sheet("M2019_2020") firstrow clear
        rename (C D) (M2019 M2020)
        drop VAR
        order MARCA, first
        sort MARCA LINEA
        save "$ruta/Data_prepared/ventas2019&2020.dta", replace
    
    * Ventas 2019 Colombia
        preserve
            keep MARCA  LINEA  M2019
            rename M2019 CANTIDAD
            gen YEAR = 2019 
            save "$ruta/Data_prepared/tmp_2019", replace 
        restore

    * Ventas 2020 Colombia
        preserve
            keep MARCA  LINEA  M2020
            rename M2020 CANTIDAD
            gen YEAR = 2020 
            save "$ruta/Data_prepared/tmp_2020", replace 
        restore

     * Registro de Andemos de las ventas realizadas 2021-2022
        import excel "$ruta/Data/Ventas_Andemos.xlsx", sheet("M2021_2022") firstrow clear
        rename (C D) (M2021 M2022)
        drop VAR
        order MARCA, first
        sort MARCA LINEA
        save "$ruta/Data_prepared/ventas2021&2022.dta", replace

    * Ventas 2021 Colombia
        preserve
            keep MARCA  LINEA  M2021
            rename M2021 CANTIDAD
            gen YEAR = 2021 
            save "$ruta/Data_prepared/tmp_2021", replace 
        restore

    * Ventas 2022 Colombia
        preserve
            keep MARCA  LINEA  M2022
            rename M2022 CANTIDAD
            gen YEAR = 2022 
            save "$ruta/Data_prepared/tmp_2022", replace 
        restore

    * Registro de Andemos de las ventas realizadas 2023-2024
        import excel "$ruta/Data/Ventas_Andemos.xlsx", sheet("M2023_2024") firstrow clear
        rename (C D) (M2023 M2024)
        drop VAR
        order MARCA, first
        sort MARCA LINEA
        save "$ruta/Data_prepared/ventas2023&2024.dta", replace
    
    * Ventas 2023 Colombia
        preserve
            keep MARCA  LINEA  M2023
            rename M2023 CANTIDAD
            gen YEAR = 2023 
            save "$ruta/Data_prepared/tmp_2023", replace 
        restore

    * Ventas 2024 Colombia
        preserve
            keep MARCA  LINEA  M2024
            rename M2024 CANTIDAD
            gen YEAR = 2024 
            save "$ruta/Data_prepared/tmp_2024", replace 
        restore

    * Append las ventas desde 2019 hasta 2024 Colombia

    use "$ruta/Data_prepared/tmp_2019", clear
    append using "$ruta/Data_prepared/tmp_2020"
    append using "$ruta/Data_prepared/tmp_2021"
    append using "$ruta/Data_prepared/tmp_2022"
    append using "$ruta/Data_prepared/tmp_2023"
    append using "$ruta/Data_prepared/tmp_2024"

    order YEAR, first


/* Merge
    * Registro de Andemos de las ventas realizadas 2019-2020
    import excel "$ruta/Data/Ventas_Andemos.xlsx", sheet("M2019_2020") firstrow clear
    rename (C D) (M2019 M2020)
    drop VAR
    order MARCA, first
    sort MARCA LINEA
    duplicates report
    save "$ruta/Data_prepared/ventas2019&2020.dta", replace

    * Registro de Andemos de las ventas realizas del 2021-2022
    import excel "$ruta/Data/Ventas_Andemos.xlsx", sheet("M2021_2022") firstrow clear
    rename (C D) (M2021 M2022)
    drop VAR
    order MARCA , first
    sort MARCA LINEA
    duplicates report
    save "$ruta/Data_prepared/ventas2021&2022.dta", replace

    * Registro de Andemos de las ventas realizadas 2023
    import excel "$ruta/Data/Ventas_Andemos.xlsx", sheet("M2023_2024") firstrow clear
    rename (C D) (M2023 M2024)
    drop VAR M2024
    order MARCA , first
    sort MARCA LINEA
    duplicates report
    save "$ruta/Data_prepared/ventas2023.dta" , replace

    // Merge entre las ventas de Andemos

    use "$ruta/Data_prepared/ventas2023.dta" , clear
    merge 1:1 MARCA LINEA using "$ruta/Data_prepared/ventas2021&2022.dta"
    drop _merge
    save "$ruta/Data_prepared/ventascombinado.dta" , replace

*/

