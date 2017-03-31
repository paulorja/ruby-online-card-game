require 'websocket-client-simple'
require 'json'

class Command
	attr_accessor :command_name, :params
	
	def initialize(command_name, *params)
		@command_name = command_name
		@params = params
	end

	def get_json
		hash_cmd = { command_name: @command_name }
		if @params.is_a? Hash
			hash_cmd.merge(@params)
		end
		JSON.generate(hash_cmd)
	end
end

ws = WebSocket::Client::Simple.connect 'ws://127.0.0.1:3001'

ws.on :message do |msg|
  puts msg.data
end

ws.on :open do
  ws.send Command.new('hello').get_json
end

ws.on :close do |e|
  p e
  exit 1
end

ws.on :error do |e|
  p e
end

loop do
	json_cmd = nil
	case STDIN.gets.strip
	when 'play_card'
		json_cmd = Command.new('PlayCardCmd')
	else
		puts 'invalid command'
	end
		
 	ws.send json_cmd.get_json unless json_cmd.nil?
end