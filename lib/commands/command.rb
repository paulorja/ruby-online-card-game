class Command

	attr_accessor :ws, :channel, :sid, :server

	def initialize
		raise 'You are trying to instantiate an abstract class!'
	end

	def run
	   raise 'this method should be overriden'
	end

	protected

end