package dds.nelflics

import java.util.List
import dds.nelflics.external.SistemaFacturacion

interface Categoria {	
	def Iterable<Contenido> contenidoPermitido(List<Contenido> contenidos)
	
	def void usuarioCambiaA(Usuario usuario, Categoria categoria, SistemaFacturacion facturacion)
	
}

class Premium implements Categoria {
	
	override contenidoPermitido(List<Contenido> contenidos) {
		contenidos
	}
	
	def dispatch void usuarioCambiaA(Usuario usuario, Premium categoria, SistemaFacturacion facturacion) {
		//NADA
	}
	def dispatch void usuarioCambiaA(Usuario usuario, Normal categoria, SistemaFacturacion facturacion) {
		facturacion.reintegraPremiumA(usuario)
	}
	
}
class Infantil extends Normal {
	
	override contenidoPermitido(List<Contenido> contenidos) {
		contenidos.filter[it.esInfantil]
	}
	
}

class Normal implements Categoria {
	
	override contenidoPermitido(List<Contenido> contenidos) {
		contenidos.filter[!it.esPremium]
	}
	
	def dispatch void usuarioCambiaA(Usuario usuario, Premium categoria, SistemaFacturacion facturacion) {
		facturacion.facturaPremiumA(usuario)
	}
	
	def dispatch void usuarioCambiaA(Usuario usuario, Normal categoria, SistemaFacturacion facturacion) {
		//NADA
	}
	
}