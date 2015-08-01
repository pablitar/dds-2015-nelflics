package dds.nelflics.external

import dds.nelflics.Usuario

interface SistemaFacturacion {
	
	def void facturaPremiumA(Usuario usuario)
	
	def void reintegraPremiumA(Usuario usuario)
	
}