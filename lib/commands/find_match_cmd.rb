class FindMatchCmd < Command

	def initialize
	end

	def run
		@server.match_sid(@sid, @ws)
    	@ws.send 'Looking for match...'
	end

end