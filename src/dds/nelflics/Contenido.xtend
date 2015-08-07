package dds.nelflics

import java.util.Collection
import java.util.Set
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension dds.nelflics.NelflicsIterableExtensions.*
import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

abstract class Contenido {

	@Accessors(AccessorType.PUBLIC_GETTER)
	Collection<String> generos

	@Accessors(AccessorType.PROTECTED_GETTER)
	Set<ContenidoVisto> visualizaciones = newHashSet()

	@Accessors(AccessorType.PUBLIC_GETTER)
	Set<Interprete> interpretes = newHashSet()

	@Accessors
	Boolean estaDestacado = false
	
	@Accessors
	/*
	 * Requerimiento: Poner como premium o no un contenido
	 * unContenido.esPremium = true
	 * unContenido.esPremium = false
	 */
	Boolean esPremium = false

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

	def Double relevancia()

	//Esto es quizás una decisión cuestionable, ya que implica mezclar modelo y metamodelo
	//Por ello, se abstrae en un método en particular, para poder cambiarlo luego
	def String tipo() {
		this.class.simpleName
	}

	def coincideAlgunGenero(Collection<String> generos) {
		generos.exists[this.esDeGenero(it)]
	}

	def esDeGenero(String genero) {
		this.generos.contains(genero)
	}

	def participaInterprete(Interprete interprete) {
		this.interpretes.contains(interprete)
	}

	def agregarInterprete(Interprete interprete) {
		interpretes.add(interprete)
		interprete.agregarObra(this)
	}

}

class Recital extends Contenido {

	override esRecomendadoPorTipoPara(Usuario usuario) {
		usuario.contenidosVistos.exists[it.contenido != this && it.contenido.coincideArtista(this)]
	}

	override coincideArtista(Recital recital) {
		this.interpretes.exists[recital.participaInterprete(it)]
	}

	override relevancia() {
		interpretes.average([it.calificacion])
	}

}

class Pelicula extends Contenido {

	override esRecomendadoPorTipoPara(Usuario usuario) {
		usuario.vioAlgunGenero(this.generos)
	}

	override relevancia() {
		(visualizaciones.size.doubleValue / RepoUsuarios.instance.cantidad) * visualizaciones.average[it.calificacion]
	}

}

class Serie extends Contenido {

	@Accessors
	Integer cantidadCapitulos

	override esRecomendadoPorTipoPara(Usuario usuario) {
		usuario.empezoPeroNoTermino(this)
	}

	override relevancia() {
		visualizaciones.average[it.calificacion] * cantidadVisualizacionesEnTotalidad
	}

	def cantidadVisualizacionesEnTotalidad() {
		visualizaciones.count[it.esSerieVistaEnTotalidad(this)]
	}

}
