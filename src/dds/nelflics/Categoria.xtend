package dds.nelflics

import dds.nelflics.external.SistemasExternos
import java.util.List

interface Categoria {	
	def Iterable<Contenido> contenidoPermitido(List<Contenido> contenidos)
	
	def void usuarioCambiaA(Usuario usuario, Categoria categoria)
	
}

class Premium implements Categoria {
	
	override contenidoPermitido(List<Contenido> contenidos) {
		contenidos
	}
	
	def dispatch void usuarioCambiaA(Usuario usuario, Premium categoria) {
		//NADA
	}
	def dispatch void usuarioCambiaA(Usuario usuario, Normal categoria) {
		SistemasExternos.sistemaFacturacion.reintegraPremiumA(usuario)
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
	
	def dispatch void usuarioCambiaA(Usuario usuario, Premium categoria) {
		SistemasExternos.sistemaFacturacion.facturaPremiumA(usuario)
	}
	
	def dispatch void usuarioCambiaA(Usuario usuario, Normal categoria) {
		//NADA
	}
	
}