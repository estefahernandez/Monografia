

* Initialize work environment

clear all
set more off
cap set maxvar 10000
set seed 23081980 
set sortseed 11041985
set varabbrev on, perm

version 17

* Define username
global suser = c(username) 

* Install packages used in the process
local commands = "vselect  missings unique confirmdir sepov pshare fastgini tabout fre tabstatmat pip spmap grstyle palettes wbopendata ineqdeco shp2dta mif2dta spshape2dta"  

foreach c of local commands {
	qui capture which `c' 
	qui if _rc!=0 {
		noisily di "This command requires '`c''. The package will now be downloaded and installed."
		ssc install `c', replace 
	}
}


* Estefania
if (inlist("${suser}","estefania", "estefania")) {
	*Local directory of the repository

	* global gdDo = "/Users/${suser}/Library/CloudStorage/OneDrive-Personal/PA/Do/estefa" // Ruta de onedrive
	global dDo = "/Users/estefania/Documents/Monografia/02_do/01_scripts"

	*Local directory to the shared folder
	
	*local ldAnalysis = "/Users/estefania/Library/CloudStorage/OneDrive-Personal/PA"  // Ruta de onedrive
	local folder = "/Users/estefania/Documents/Monografia"

	
}
else {
	di as error "Configure work environment in init.do before running the code."
	error 1
}

global folder	= "`folder'"
global dRaw	    = "`folder'/01_data/01_raw_data"  
global dCl		= "`folder'/01_data/02_cleaned_data"
global dOutput	= "`folder'/03_result" 

* If needed, create directories, and sub-directories used in the process 
foreach d in "${dOutput}" "${dOutput}/Data" /*"${gdTemp}"*/ {
	confirmdir "`d'" 
	if _rc!=0 mkdir "`d'" 
}
