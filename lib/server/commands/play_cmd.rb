class PlayCmd < Command

	def initialize
	end

	def run
		room = @server.find_room_by_sid @sid

		unless room.nil?
			client_responses = room.play(@sid, self)

			client_responses.each do |response|
				case response[:type]
				when 'send_success'
					send_success response[:msg]
				when 'send_error'
					send_error response[:msg]
				when 'match_push'
					room.push response[:msg]
				else
					raise 'response not found'
				end
			end
		end
	end

end