package dds.nelflics

class ContenidoBuilder<T extends Contenido> {
	
	protected T contenido
	
	static def newRecital() {
		new RecitalBuilder
	}
	
	def destacado(){
		this.contenido.estaDestacado=true
		this
	}
	
	def build() {
		contenido
	}
	
}

class RecitalBuilder extends ContenidoBuilder<Recital> {

	new() {
		this.contenido = new Recital
	}	
}