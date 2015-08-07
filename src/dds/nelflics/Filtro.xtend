package dds.nelflics

interface Filtro {

	def Boolean esPasadoPor(Contenido contenido)

}

class Filtros {

	/*
	 * Requerimiento: Filtrar por tipo de contenido
	 * unUsuario.agregarFiltro(Filtros.tipoDeContenido(Recital))
	 */
	static def Filtro tipoDeContenido(Class<? extends Contenido> clazz) {
		[Contenido contenido|contenido.tipo.equals(clazz.name)]
	}

	/*
	 * Requerimiento: Filtrar por tipo de contenido
	 * unUsuario.agregarFiltro(Filtros.genero("accion"))
	 */
	static def Filtro genero(String unGenero) {
		[Contenido contenido|contenido.esDeGenero(unGenero)]
	}

	/*
	 * Requerimiento: Filtrar por artista u actor
	 * unUsuario.agregarFiltro(Filtros.participaInterprete(unInterprete))
	 */
	static def Filtro participaInterprete(Interprete interprete) {
		[Contenido contenido|contenido.participaInterprete(interprete)]
	}
}
