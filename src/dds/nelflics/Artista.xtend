package dds.nelflics

import java.util.Set
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension dds.nelflics.NelflicsIterableExtensions.*

class Artista {
	@Accessors(AccessorType.PUBLIC_GETTER)
	Set<Recital> recitales = newHashSet()
	
	def agregarRecital(Recital recital) {
		recitales.add(recital)
	}
	
	def Double calificacion() {
		//Se asume que la calificación de un artista es el promedio de los recitales en los que participó
		recitales.average([it.calificacionPromedio])
	}
	
}