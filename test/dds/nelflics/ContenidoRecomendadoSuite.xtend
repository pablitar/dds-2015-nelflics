package dds.nelflics

import java.util.List
import org.junit.Test

import static org.junit.Assert.*
import org.junit.Before

class ContenidoRecomendadoSuite {
	
	var Contenido destacado
	var List<Contenido> todoElContenido = newArrayList
	var Pais pais
	
	@Before
	def void fixtureDeContenido() {
		destacado = ContenidoBuilder
					.newRecital
					.destacado
					.build
		
		todoElContenido.add(destacado)
		
		todoElContenido.add(ContenidoBuilder
			.newRecital
			.build
		)
		
		pais = new Pais(todoElContenido)
	}
	
	
	@Test
	def void unUsuarioQueNoVioNadaLeRecomiendaLoDestacado() {
		val usuario = new Usuario(new Normal, pais)
		val List<Contenido> contenido = usuario.contenidoRecomendado()
		
		assertArrayEquals(newArrayList(destacado).toArray, contenido.toArray)
	}

	@Test
	def void unUsuarioQueVioUnaSerieEnteraNoLeApareceEnRecomendaciones() {
		fail("Not implemented")
	}

}
