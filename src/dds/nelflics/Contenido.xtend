package dds.nelflics

import java.util.Collection
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.AccessorType
import static extension dds.nelflics.NelflicsIterableExtensions.*

abstract class Contenido {

	@Accessors(AccessorType.PUBLIC_GETTER)
	Collection<String> generos

	@Accessors(AccessorType.PROTECTED_GETTER)
	Set<ContenidoVisto> visualizaciones = newHashSet()

	@Accessors
	Boolean estaDestacado = false

	def esPremium() {
		false
	}

	def esInfantil() {
		generos.contains(Genero.INFANTIL)
	}

	def esRecomendadoPara(Usuario usuario) {
		this.estaDestacado || this.esRecomendadoPorTipoPara(usuario)
	}

	def Boolean esRecomendadoPorTipoPara(Usuario usuario)

	def void addVisualizacion(ContenidoVisto visto) {
		visualizaciones.add(visto)
	}

	def boolean coincideArtista(Recital recital) {
		false
	}

	def calificacionPromedio() {
		visualizaciones.average[it.calificacion]
	}

	def Double relevancia(Iterable<Usuario> todosLosUsuarios)

	def coincideAlgunGenero(Collection<String> generos) {
		this.generos.exists[generos.contains(it)]
	}

}

class Recital extends Contenido {

	@Accessors(AccessorType.PUBLIC_GETTER)
	Set<Artista> artistas = newHashSet()

	override esRecomendadoPorTipoPara(Usuario usuario) {
		usuario.contenidosVistos.exists[it.contenido != this && it.contenido.coincideArtista(this)]
	}

	override coincideArtista(Recital recital) {
		recital.artistas.exists[this.artistas.contains(it)]
	}

	def agregarArtista(Artista a) {
		artistas.add(a)
		a.agregarRecital(this)
	}

	override relevancia(Iterable<Usuario> todosLosUsuarios) {
		artistas.average([it.calificacion])
	}

}

class Pelicula extends Contenido {

	override esRecomendadoPorTipoPara(Usuario usuario) {
		usuario.vioAlgunGenero(this.generos)
	}

	override relevancia(Iterable<Usuario> todosLosUsuarios) {
		(visualizaciones.size.doubleValue / todosLosUsuarios.size) * visualizaciones.average[it.calificacion]
	}

}

class Serie extends Contenido {
	
	@Accessors
	Integer cantidadCapitulos

	override esRecomendadoPorTipoPara(Usuario usuario) {
		usuario.empezoPeroNoTermino(this)
	}

	override relevancia(Iterable<Usuario> todosLosUsuarios) {
		visualizaciones.average[it.calificacion] * cantidadVisualizacionesEnTotalidad
	}
	
	def cantidadVisualizacionesEnTotalidad() {
		visualizaciones.count[it.esSerieVistaEnTotalidad(this)]
	}
	
}
