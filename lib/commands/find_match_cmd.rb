class FindMatchCmd < Command

	def initialize
	end

	def run
		@server.matches.each do |match|
			if match.sid_player_a == @sid or match.sid_player_b == @sid
				@ws.send 'You already join in a match'
				return
			end
		end

		match_sid
		send_success('looking_for_match')
	end

	def match_sid
	    available_match = find_available_match
	    if available_match.nil?
	      puts 'create match'
	      create_match
	    else
	      puts 'join match'
	      sid_match = available_match.subscribe { |msg| ws.send msg }
	      available_match.join(@sid, sid_match)
	      available_match.push('a partida vai comecar')
	      # start the match
	      available_match.start
	    end
  	end

	def find_available_match
	    @server.matches.each do |match|
	      return match if match.sid_player_a.nil? or match.sid_player_b.nil?
	    end
	    nil
  	end

  	def create_match
	    new_match = Match.new
	    sid_match = new_match.subscribe { |msg| ws.send msg }
	    new_match.join(@sid, sid_match)
	    @server.matches.push new_match
	end

	  
end