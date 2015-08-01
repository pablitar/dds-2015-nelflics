package dds.nelflics

import dds.nelflics.external.SistemaFacturacion
import java.util.List

class SistemaFacturacionParaTest implements SistemaFacturacion {
	
	List<Usuario> facturados = newArrayList
	List<Usuario> reintegrados = newArrayList
	
	override facturaPremiumA(Usuario usuario) {
		this.facturados.add(usuario)
	}
	
	override reintegraPremiumA(Usuario usuario) {
		this.reintegrados.add(usuario)
	}
	
	def fueFacturado(Usuario usuario) {
		this.facturados.contains(usuario)
	}
	
	def fueReintegrado(Usuario usuario) {
		this.reintegrados.contains(usuario)
	}
	
}