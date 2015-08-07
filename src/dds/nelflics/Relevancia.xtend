package dds.nelflics

import java.util.Comparator

class Relevancia {

	//La interfaz de comparator es muy confusa, pero permite ordenar usando sortWith
	public static val Comparator<Contenido> comparator = [ Contenido a, Contenido b |
		//Primero comparo por destaque. False comparado con True da 1 => En caso que a sea destacado y b no lo sea, entonces el resultado será que a va delante de b. 
		var result = b.estaDestacado.compareTo(a.estaDestacado)
		//En caso que sean iguales, comparo por relevancia. En los números, el menor número va delante del mayor. Como quiero que a más relevancia vaya más adelante, debo invertirlo.
		if(result == 0) result = b.relevancia.compareTo(a.relevancia)
		//En caso que sean iguales, comparo por premium. Es un caso similar al destaque. 
		if(result == 0) result = b.esPremium.compareTo(a.esPremium)
		return result
	]

}
