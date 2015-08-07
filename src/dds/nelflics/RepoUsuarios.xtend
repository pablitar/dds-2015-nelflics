package dds.nelflics

import java.util.List

class RepoUsuarios {
	
	private static RepoUsuarios instance
	
	List<Usuario> usuarios = newArrayList()
	
	static def getInstance(){
		if(instance == null) instance = new RepoUsuarios
		
		instance
	}
	
	def cantidad() {
		usuarios.size
	}
	
}