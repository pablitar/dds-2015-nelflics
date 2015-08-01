package dds.nelflics

import org.junit.Test
import static org.junit.Assert.*

class SistemaFacturacionSuite {
	
	var usuario = new Usuario(new Normal)
	var sistema = new SistemaFacturacionParaTest
	
	@Test
	def void alCambiarDeCategoriaNormalAInfantilNoCobra (){
		usuario.cambiarDeCategoria(new Infantil, sistema)
		assertFalse(sistema.fueFacturado(usuario))
		assertFalse(sistema.fueReintegrado(usuario)) 
	}
	
	@Test
	def void alCambiarDeCategoriaNormalAPremiumCobra (){
		usuario.cambiarDeCategoria(new Premium, sistema)
		assertTrue(sistema.fueFacturado(usuario))
		assertFalse(sistema.fueReintegrado(usuario))  
	}
	
	@Test
	def void alCambiarDeCategoriaPremiumANormalDevuelve (){
		this.usuario = new Usuario(new Premium)
		this.usuario.cambiarDeCategoria(new Normal, sistema)
		assertFalse(sistema.fueFacturado(usuario))
		assertTrue(sistema.fueReintegrado(usuario))
	}
	
}