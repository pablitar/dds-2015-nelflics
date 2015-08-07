package dds.nelflics

import java.util.Set
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension dds.nelflics.NelflicsIterableExtensions.*
import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

class Interprete {
	@Accessors(AccessorType.PUBLIC_GETTER)
	Set<Contenido> obras = newHashSet()
	
	@Accessors
	String nombre
	
	def agregarObra(Contenido obra) {
		obras.add(obra)
	}
	
	def Double calificacion() {
		//Se asume que la calificación de un artista es el promedio de los recitales en los que participó
		obras.average([it.calificacionPromedio])
	}
	
}