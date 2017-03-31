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
            GameCommand.new(ws, msg, sid, self)
            CommandRunner.new(msg)
          }

          ws.onclose {
            puts 'Connection closed'
            @channels[:general].unsubscribe(sid)
          }
        }
      end
    }
  end

  def find_available_room
    @rooms.each do |room|
      return room if room.sid_player_a.nil? or room.sid_player_b.nil?
    end
    nil
  end

  def start_room(sid, ws)
    new_room = Room.new
    new_room.join(sid)
    sid_player = new_room.subscribe { |msg| ws.send msg }
    @rooms.push new_room
    puts 'new room: ' + new_room.inspect
  end

  def match_sid(sid, ws)
    available_room = find_available_room
    if available_room.nil?
      puts 'start room'
      start_room(sid, ws)
    else
      puts 'join room'
      sid_player = available_room.subscribe { |msg| ws.send msg }
      available_room.join(sid)
      available_room.push('A PARTIDA VAI COMECAR')
      puts 'available room: ' + available_room.inspect
    end
  end

end