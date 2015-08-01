package dds.nelflics

import java.util.List
import org.junit.Test

import static org.junit.Assert.*
import org.junit.Before

class ContenidoRecomendadoSuite {
	
	var Contenido destacado
	var List<Contenido> todoElContenido = newArrayList
	
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
	}
	
	
	@Test
	def void unUsuarioQueNoVioNadaLeRecomiendaLoDestacado() {
		val usuario = new Usuario(new Normal)
		val List<Contenido> contenido = usuario.contenidoRecomendado(todoElContenido, newArrayList(usuario))
		
		assertArrayEquals(newArrayList(destacado).toArray, contenido.toArray)
	}

	@Test
	def void unUsuarioQueVioUnaSerieEnteraNoLeApareceEnRecomendaciones() {
		fail()
	}

}
