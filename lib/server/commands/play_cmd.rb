class PlayCmd < Command

	def initialize
	end

	def run
		room = @server.find_room_by_sid @sid

		unless room.nil?
			room.play(@sid, self)
		end
	end

end