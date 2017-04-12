class ClientResponses

	def initialize
		@responses = []
	end

	def add(response)
		if response.is_a? Hash and (response[:type] == 'send_success' or response[:type] == 'send_error' or response[:type] == 'match_push')
			@responses.push response
		end
	end

	def add_send_success(msg, hash_params = nil)
		add_type_msg 'send_success', msg, hash_params
	end

	def add_send_error(msg, hash_params= nil)
		add_type_msg 'send_error', msg, hash_params
	end

	def add_match_push(msg, hash_params = nil)
		add_type_msg 'match_push', msg, hash_params
	end

	def add_type_msg(type, msg, hash_params = nil)
		response = {}
    response[:type] = type
    response[:msg] = msg
		if hash_params.is_a? Hash
      response[:params] = hash_params
    end
		add response
	end

	def each(&block)
        @responses.each(&block)
    end

    def reset
    	@responses = []
    end

end