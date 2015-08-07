package dds.nelflics

import dds.nelflics.external.SistemaFacturacion
import dds.nelflics.external.SistemasExternos
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*
import org.junit.After

class SistemaFacturacionSuite {

	var usuario = new Usuario(new Normal, new Pais(newArrayList()))
	var SistemaFacturacion sistemaAnterior
	var sistema = new SistemaFacturacionParaTest

	@Before
	def void setUp() {
		sistemaAnterior = SistemasExternos.sistemaFacturacion
		SistemasExternos.configurarSistemaFacturacion(sistema)
	}

	@After
	def void tearDown() {
		SistemasExternos.configurarSistemaFacturacion(sistemaAnterior)
	}

	@Test
	def void alCambiarDeCategoriaNormalAInfantilNoCobra() {
		usuario.cambiarDeCategoria(new Infantil)
		assertFalse(sistema.fueFacturado(usuario))
		assertFalse(sistema.fueReintegrado(usuario))
	}

	@Test
	def void alCambiarDeCategoriaNormalAPremiumCobra() {
		usuario.cambiarDeCategoria(new Premium)
		assertTrue(sistema.fueFacturado(usuario))
		assertFalse(sistema.fueReintegrado(usuario))
	}

	@Test
	def void alCambiarDeCategoriaPremiumANormalDevuelve() {
		this.usuario = new Usuario(new Premium, new Pais(newArrayList()))
		this.usuario.cambiarDeCategoria(new Normal)
		assertFalse(sistema.fueFacturado(usuario))
		assertTrue(sistema.fueReintegrado(usuario))
	}

}
