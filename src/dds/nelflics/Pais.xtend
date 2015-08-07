package dds.nelflics

import java.util.List
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

class Pais {
	
	@Accessors(AccessorType.PUBLIC_GETTER)
	List<Contenido> contenido = newArrayList()
	
	new(List<Contenido> contenidos) {
		this.contenido = contenidos
	}
	
	
}