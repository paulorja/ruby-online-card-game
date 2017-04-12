class FindMatchCmd < Command

	def initialize
	end

	def run
		@server.rooms.each do |room|
			if room.sid_player_a == @sid or room.sid_player_b == @sid
				@ws.send 'You already join in a match'
				return
			end
		end

		match_sid(@sid)
	end

	def match_sid(sid)
	    available_room = find_available_room
	    if available_room.nil?
	      puts 'create match'
	      create_match(sid)
	    else
	      puts 'join match'
	      sid_room = available_room.subscribe { |msg| ws.send msg }
	      available_room.join(sid, sid_room)
	      push 'match_started'
	      # start the match
	      available_room.start_match
	    end
  	end

	def find_available_room
	    @server.rooms.each do |room|
	      return room if room.sid_player_a.nil? or room.sid_player_b.nil?
	    end
	    nil
  	end

  	def create_match(sid)
		send_success('waiting_opponent')
	    new_room = Room.new
	    sid_room = new_room.subscribe { |msg| ws.send msg }
	    new_room.join(sid, sid_room)
	    @server.rooms.push new_room
	end

	  
end