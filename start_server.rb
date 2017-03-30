require 'em-websocket'
require 'require_all'

require_all 'ws'
require_all 'game'

server = GameServer.new
server.start
