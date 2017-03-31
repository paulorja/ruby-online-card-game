
require 'colorize'
require 'em-websocket'
require 'require_all'

require_all 'lib'

server = GameServer.new
server.start
