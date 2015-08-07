package dds.nelflics

import java.util.Collection
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

class Usuario {
	@Accessors
	Categoria categoria

	@Accessors
	List<ContenidoVisto> contenidosVistos = newArrayList()

	@Accessors
	List<Filtro> filtrosConfigurados = newArrayList()
	
	@Accessors
	Pais pais

	/*
	 * Requerimiento: Contenido recomendado para un usuario
	 * unUsuario.contenidoRecomendado()
	 */
	def List<Contenido> contenidoRecomendado() {
		filtrarYOrdenarPorRecomendados(
			filtrarPorFiltros(
				categoria.contenidoPermitido(pais.contenido)
			)
		)
	}
	
	def agregarFiltro(Filtro filtro) {
		this.filtrosConfigurados.add(filtro)
	}
	
	def quitarFiltro(Filtro filtro) {
		this.filtrosConfigurados.remove(filtro)
	}

	def filtrarPorFiltros(Iterable<Contenido> contenidos) {
		contenidos.filter[c|filtrosConfigurados.forall[it.esPasadoPor(c)]]
	}

	def filtrarYOrdenarPorRecomendados(Iterable<Contenido> contenidos) {
		contenidos.filter[it.esRecomendadoPara(this)].sortWith(Relevancia.comparator)
	}

	def vioAlgunGenero(Collection<String> generos) {
		contenidosVistos.exists[it.contenido.coincideAlgunGenero(generos)]
	}

	def empezoPeroNoTermino(Serie serie) {
		contenidosVistos.exists[it.esSerieEmpezadaPeroNoTerminada(serie)]
	}

	//Quizás podría ser un observer
	/*
	 * Requerimiento: Cambiar de categoría de usuario
	 * unUsuario.cambiarDeCategoria(unaCategoria)
	 */
	def cambiarDeCategoria(Categoria categoria) {
		this.categoria.usuarioCambiaA(this, categoria)
		this.categoria = categoria
	}

	//Interfaz externa, para volver a categoría normal cuando no se registra el pago
	/*
	 * Requerimiento: Volver a categoría normal un usuario porque falló su pago.
	 * Dado que el sistema de facturación trata con usuarios (porque la interfaz está definida así),
	 * puedo asumir que le puede enviar este mensaje.
	 */
	def volverACategoriaNormal() {
		this.categoria = new Normal()
	}

	new(Categoria categoria, Pais pais) {
		this.categoria = categoria
		this.pais = pais
	}

}
