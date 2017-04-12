class Command

	attr_accessor :ws, :sid, :server, :params

	def initialize
		raise 'You are trying to instantiate an abstract class!'
	end

	def run
	   raise 'this method should be overriden'
	end

	protected

	def send_success(msg, params = nil)
		total_params = {type: 'success'}
		total_params = total_params.merge params if params.is_a? Hash

		send(msg, total_params)
	end

	def send_error(msg, params = nil)
		total_params = {type: 'error'}
		total_params = total_params.merge params if params.is_a? Hash

		send(msg, total_params)
	end

	def send(msg, params = nil)
		response = { msg: msg }
		response = response.merge(params) if params.is_a? Hash

    @ws.send(JSON.generate(response))
    Log.log 'Sent: '.blue + response.to_s
  end

end