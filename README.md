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
run generate_figures.do'''

**Metodolgía**
Los scripts implementan los siguientes pasos clave:
1. **Preparación de Datos**: Limpieza y asignación de valores de emisiones por vehículo considerando características como modelo y cilindraje.

2. **Simulación Monte Carlo**: Evaluación de las emisiones anuales de CO2 basadas en funciones de distribución PERT para modelar escenarios realistas de kilómetros recorridos y emisiones por vehículo.

3. **Proyecciones**: Análisis de los ingresos fiscales proyectados bajo diferentes tarifas de impuesto vehicular a lo largo de 10 años, considerando la inflación y la depreciación de los vehículos.

**Resultados**

El análisis demostró que:

- La tarifa actual basada en el valor del vehículo es insuficiente para maximizar el recaudo fiscal.

- Una tarifa basada en emisiones de $219.057,37 por tonelada de CO2 podría generar ingresos significativamente mayores y fomentar el uso de tecnologías limpias.

**Contribuciones**

Este proyecto está abierto a sugerencias. Realiza un fork del repositorio y envía un pull request con tus propuestas de mejora.

**Autora**: Estefanía Hernández Arroyave
**Institución**: Universidad de Antioquia


