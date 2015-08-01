package dds.nelflics

import dds.nelflics.external.SistemaFacturacion
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

	/* Quizás en lugar de recibir una lista, uno querría recibir un repositorio, dado que
	 * eso permitiría que no toda la lista esté en memoria.
	 * Lo mismo sucede con el listado de los usuarios, que podría ser también la cantidad de usuarios
	 * */
	def List<Contenido> contenidoRecomendado(List<Contenido> todoElContenido, List<Usuario> todosLosUsuarios) {
		filtrarYOrdenarPorRecomendados(
			filtrarPorFiltros(
				categoria.contenidoPermitido(todoElContenido)
			),
			todosLosUsuarios
		)
	}

	def filtrarPorFiltros(Iterable<Contenido> contenidos) {
		contenidos.filter[c|filtrosConfigurados.forall[it.esPasadoPor(c)]]
	}

	def filtrarYOrdenarPorRecomendados(Iterable<Contenido> contenidos, Iterable<Usuario> usuarios) {
		contenidos.filter[it.esRecomendadoPara(this)].sortWith(Relevancia.comparator(usuarios))
	}

	def vioAlgunGenero(Collection<String> generos) {
		contenidosVistos.exists[it.contenido.coincideAlgunGenero(generos)]
	}

	def empezoPeroNoTermino(Serie serie) {
		contenidosVistos.exists[it.esSerieEmpezadaPeroNoTerminada(serie)]
	}

	//Quizás podría ser un observer
	def cambiarDeCategoria(Categoria categoria, SistemaFacturacion sistema) {
		this.categoria.usuarioCambiaA(this, categoria, sistema)
		this.categoria = categoria
	}

	//Interfaz externa, para volver a categoría normal cuando no se registra el pago
	def volverACategoriaNormal() {
		this.categoria = new Normal()
	}

	new(Categoria categoria) {
		this.categoria = categoria
	}

}
