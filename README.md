# Propuesta de Actualización al Impuesto Vehicular en Antioquia Basada en Emisiones de CO2

## Descripción del Proyecto
Este repositorio contiene los scripts utilizados para analizar y proyectar la propuesta de modificación al impuesto vehicular en Antioquia, basado en emisiones de CO2 por kilómetro recorrido. El objetivo es incentivar el uso de tecnologías más limpias, aumentar el recaudo fiscal y reducir el impacto ambiental.

## Contenido del Repositorio
- **Scripts**: Código en Stata para generar los análisis y figuras.
- **Instrucciones**: Pasos detallados para reproducir las simulaciones y construir las figuras.
- **Metodología**: Documentación sobre las técnicas y datos utilizados.

## Figuras y Resultados
Las figuras incluyen:
1. **Evolución del número de matrículas por tipo de vehículo (2000-2023)**.
2. **Porcentaje de impuesto vehicular recaudado en Antioquia (2014-2023)**.
3. **Proyección del recaudo del impuesto vehicular en diferentes escenarios**.
4. **Distribución simulada del recaudo fiscal según tarifas**.

Puedes generar estas figuras ejecutando los scripts disponibles.

## Requisitos
1. **Software Necesario**:
   - Stata 16 o superior.

2. **Archivos Necesarios**:
   - Los scripts `.do` incluidos en este repositorio.

3. **Ejecución**:
   Abre Stata y ejecuta los scripts en el siguiente orden:
   1. Limpieza y preparación de datos: `clean_data.do`
   2. Simulación Monte Carlo: `monte_carlo_simulation.do`
   3. Generación de figuras: `generate_figures.do`

```stata
// Ejemplo de ejecución
run clean_data.do
run monte_carlo_simulation.do
run generate_figures.do
