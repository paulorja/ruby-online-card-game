class GameCommand

  def initialize(ws, msg, sid, game_server)
    @ws = ws
    @command = msg.split ' '
    @sid = sid
    @server = game_server

    if @command[0][0] == '/'
      if exist_command? @command[0]
        send(@command[0][1..-1])
      else
        puts "Command #{msg} not found"
      end
    end
  end

  private

  def hello
    @ws.send('Hello')
  end

  def play_card

  end

  def chat
    @command.delete_at(0)
    @server.channels[:general].push " - #{@sid}: #{@command.join(' ')}"
  end

  def find_match
    @server.match_sid(@sid, @ws)
    @ws.send 'Looking for match...'
  end

  def ping_find_match

  end

  def exit_find_match

  end

  def exist_command?(command)
    %w(chat hello find_match play_card).include? command[1..-1]
  end

end