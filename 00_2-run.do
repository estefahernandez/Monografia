
if ("$dDo" == "") {
	di as error "Configure work environment in 01-init.do before running the code."
	error 1
}

*----------------------------------*
*			 Monografía 
*-----------------------------------*

** Limpieza de datos
	/* Se realizan las restricciones y los supuestos para el analisis */

	include "$dDo/Monografia/01_limpieza.do"

** Emsiones
	/* Las emisiones son calculadas con base a la investigación en el cual se toma como base el modelo y el cilindraje */

	include "$dDo/Monografia/02_emisiones.do"

** Descripción datos
	/* Figuras que describen el comportamiento de los datos */

	include "$dDo/Monografia/03_descripcion_datos.do"

exit 