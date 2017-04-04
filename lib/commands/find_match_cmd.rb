class FindMatchCmd < Command

	def initialize
	end

	def run
		match_sid
    	@ws.send 'Looking for match...'
	end

	def match_sid
	    available_room = find_available_room
	    if available_room.nil?
	      puts 'create room'
	      create_room
	    else
	      puts 'join room'
	      sid_player = available_room.subscribe { |msg| ws.send msg }
	      available_room.join(@sid)
	      available_room.push('A PARTIDA VAI COMECAR')
	      puts 'available room: ' + available_room.inspect
	    end
  	end

	def find_available_room
	    @server.rooms.each do |room|
	      return room if room.sid_player_a.nil? or room.sid_player_b.nil?
	    end
	    nil
  	end

  	def create_room
	    new_room = Room.new
	    new_room.join(@sid)
	    sid_player = new_room.subscribe { |msg| ws.send msg }
	    @server.rooms.push new_room
	    puts 'new room: ' + new_room.inspect
	end

	  
end