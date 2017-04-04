require 'websocket-client-simple'
require 'json'

class Command
	attr_accessor :command_name, :params
	
	def initialize(command_name, params)
		@command_name = command_name
		@params = params
	end

	def get_json
		hash_cmd = { command_name: @command_name }
		if @params.is_a? Hash
			hash_cmd = hash_cmd.merge(@params)
		end
		JSON.generate(hash_cmd)
	end
end

ws = WebSocket::Client::Simple.connect 'ws://127.0.0.1:3001'

ws.on :message do |msg|
  puts "Server: "+msg.data
end

ws.on :open do

end

ws.on :close do |e|
  p e
  exit 1
end

ws.on :error do |e|
  p e
end


loop do
	puts '====================='
	puts '======== MENU ======='
	puts '1 - Partida Online'
	puts '2 - Jogar Carta'
	puts '3 - Chat Global'
	puts '4 - Chat Room'

	json_cmd = nil
	input = STDIN.gets.strip

	case input
	when '1'
		json_cmd = Command.new('find_match')
	when '2'
		json_cmd = Command.new('play_card')
	when '3'
		puts 'Digite a mensagem: '
		json_cmd = Command.new('chat_global', {msg: STDIN.gets.strip})
	when '4'
		puts 'Digite a mensagem: '
		json_cmd = Command.new('chat_match', {msg: STDIN.gets.strip})
	else
		puts 'invalid command'
	end
		
 	ws.send json_cmd.get_json unless json_cmd.nil?
 	STDIN.gets.strip
end