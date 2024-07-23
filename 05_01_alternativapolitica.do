
*-------------------------------------------------------------------
*
*       Alternativa Política
*     
*   
*
*-------------------------------------------------------------------

**# Impotación de datos

    use "$datacl/10_Parque_automotor_impuesto_vehicular_ano_fiscal_2023", clear

**# Eliminación de variables

    drop clase00 capacidad 

**# Selección de información modelos 2022 - 2024

    destring Kilometro, replace force

