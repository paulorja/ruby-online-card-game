class GameServer

  attr_accessor :match_finder, :channels, :rooms

  def initialize
    @host = '127.0.0.1'
    @port = 3001
    @match_finder = MatchFinder.new

    @channels = {
      general: EM::Channel.new
    }

    @rooms = []
  end

  def start
    EM.run {
      EM::WebSocket.run(host: @host, port: @port) do |ws|
        ws.onopen { |handshake|
          puts 'Connection open'

          sid = @channels[:general].subscribe { |msg| ws.send msg }
          @channels[:general].push "#{sid} connected to #general"
          
          ws.onmessage { |msg|
            CommandRunner.new(msg, ws, sid, self)
          }

          ws.onclose {
            puts 'Connection closed'
            @channels[:general].unsubscribe(sid)
          }
        }
      end
    }
  end

  def find_room_by_sid(sid)
    @rooms.each do |room|
      return room if room.sid_player_a == sid or room.sid_player_b == sid
    end
    nil
  end

end