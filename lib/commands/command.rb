class Command

	attr_accessor :ws, :sid, :server, :params

	def initialize
		raise 'You are trying to instantiate an abstract class!'
	end

	def run
	   raise 'this method should be overriden'
	end

	protected

	def send_success(msg)
		send(msg, {type: 'success'})
	end

	def send_error(msg)
		send(msg, {type: 'error'})
	end

	def send(msg, params = nil)
		response = { msg: msg }
		response = response.merge(params) unless params.nil?
		@ws.send(JSON.generate(response))
	end

end