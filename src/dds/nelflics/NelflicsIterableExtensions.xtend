package dds.nelflics

class NelflicsIterableExtensions {
	def static <T> Double average(Iterable<T> iterable, (T)=>Double f) {
		average(iterable, f, 0.0)
	}
	
	def static <T> Double average(Iterable<T> iterable, (T) => Double f, Double ifSize0) {
		if(iterable.size == 0) ifSize0
		else iterable.fold(0.0, [acum, t| acum + f.apply(t)]) / iterable.size
	}
	
	def static <T> Integer count(Iterable<T> iterable, (T) => Boolean f) {
		iterable.filter(f).size
	}
}
