class ClientResponses

	def initialize
		@responses = []
	end

	def add(hash)
		if hash.is_a? Hash and (hash[:type] == 'send_success' or hash[:type] == 'send_error' or hash[:type] == 'match_push')
			@responses.push hash
		end
	end

	def add_send_success(msg)
		add_type_msg 'send_success', msg
	end

	def add_send_error(msg)
		add_type_msg 'send_error', msg
	end

	def add_match_push(msg)
		add_type_msg 'match_push', msg
	end

	def add_type_msg(type, msg)
		hash = {}
		if msg.is_a? String
			hash[:type] = type
			hash[:msg] = msg
		elsif hash.is_a? Hash
			hash[:type] = type
			hash.merge(msg)
		else
			return
		end
		add hash
	end

	def each(&block)
        @responses.each(&block)
    end

    def reset
    	@responses = []
    end

end