package dds.nelflics

import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.AccessorType

class ContenidoVisto {
	@Accessors
	Double calificacion

	@Accessors(AccessorType.PUBLIC_GETTER)
	Contenido contenido

	def setContenido(Contenido contenido) {
		this.contenido = contenido
		contenido.addVisualizacion(this)
	}

	//Esto parece ser una solución mejorable. Quizás con Generics
	def esSerieEmpezadaPeroNoTerminada(Serie serie) {
		false
	}

	def esSerieVistaEnTotalidad(Serie serie) {
		false
	}

}

class SerieVista extends ContenidoVisto {

	@Accessors
	Integer ultimoCapituloVisto

	override esSerieEmpezadaPeroNoTerminada(Serie serie) {
		contenido == serie && serie.cantidadCapitulos == ultimoCapituloVisto
	}

	override esSerieVistaEnTotalidad(Serie serie) {
		serie.cantidadCapitulos == ultimoCapituloVisto
	}

}
