class ChatGlobalCmd < Command

	def initialize
	end

	def run
		@server.channels[:general].push "#{@sid} falou: #{@params['msg']}"
	end

end