package dds.nelflics

import java.util.Comparator

class Relevancia {

	//La interfaz de comparator es muy confusa, pero permite ordenar usando sortWith
	static def Comparator<Contenido> comparator(Iterable<Usuario> todosLosUsuarios) {
		[ Contenido a, Contenido b |
			//Si se devuelve un número negativo, se asume que a está delante de b 
			if (a.estaDestacado) {

				//En caso que sea destacado, comparo por orden comun si b es destacado, sino automáticamente a va antes que b
				if(b.estaDestacado) compararPorOrdenComun(a, b, todosLosUsuarios) else -1
			} else {

				//En caso que no sea destacado, si b está destacado automáticamente va antes que a. Sino, comparo por orden común
				if(b.estaDestacado) 1 else compararPorOrdenComun(a, b, todosLosUsuarios)
			}
		]
	}

	private static def int compararPorOrdenComun(Contenido a, Contenido b, Iterable<Usuario> todosLosUsuarios) {

		//El orden común, ante idéntica relevancia, prioriza a los premium
		if (a.relevancia(todosLosUsuarios).equals(b.relevancia(todosLosUsuarios)))
			if (a.esPremium)
				if(b.esPremium) 0 else -1
			else if(b.esPremium) 1 else 0
		else
			//Sacadas todas las excepciones, se compara la relevancia.
			b.relevancia(todosLosUsuarios).compareTo(a.relevancia(todosLosUsuarios))
	}

}
