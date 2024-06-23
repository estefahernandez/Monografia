
*-------------------------------------------------------------------
*
*   Avalúo del ministerio para los vehículos 2024
*     
*   Limpieza y organización de datos
*
*-------------------------------------------------------------------

**# Importar datos

/* Importar los datos en stata es complejo por el peso de los datos, por lo cual, son guardados inmediamente en .dta, para Limpiar y estructurar*/

* Datos 01-Avaluo-2024

    import excel "$ruta/Data/Master/Vehiculos-2019-2024.xlsx", sheet("BD 1") firstrow clear // Se importa 2019-2021