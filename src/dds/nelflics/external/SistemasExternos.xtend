package dds.nelflics.external

class SistemasExternos {
	static SistemaFacturacion sistemaFacturacion
	
	def static configurarSistemaFacturacion(SistemaFacturacion unSistema) {
		sistemaFacturacion = unSistema 
	}
	
	def static sistemaFacturacion() {
		sistemaFacturacion
	}
}