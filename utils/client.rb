require 'websocket-client-simple'
require 'json'

# Command
# monta um comando que vai em json para o servidor
class Command
	attr_accessor :command_name, :params
	
	def initialize(command_name, params = nil)
		@command_name = command_name
		@params = params
	end

	def to_json
		hash_cmd = { command_name: @command_name }
		if @params.is_a? Hash
			hash_cmd = hash_cmd.merge(@params)
		end
		JSON.generate(hash_cmd)
	end
end

# Response
# converte a resposta string json que vem do server para um Hash
class Response
	attr_reader :msg, :data, :is_valid
	def initialize(msg)
		@msg = msg
		begin 
			@data = JSON.parse(msg)
			@is_valid = true
		rescue
			@data = nil
			@is_valid = false
		end
	end
	def error?
		return false unless @is_valid
		return true if @data['type'] == 'error'
	end
	def success?
		return false unless @is_valid
		return true if @data['type'] == 'success'
	end
end

# WS
# conexao com o server
class ServerConn
	attr_accessor :ws
	def initialize
		@ws = WebSocket::Client::Simple.connect 'ws://127.0.0.1:3001'

		@ws.on :message do |msg|
			response = Response.new(msg.data)
			if response.is_valid
				if response.success?
					puts response.data['msg']
				end
				if response.error?
					puts 'ERROR: ' + response.data['msg']
				end
			else
			  	puts "Server: "+msg.data
			end
		end

		@ws.on :open do

		end

		@ws.on :close do |e|
		  p e
		  exit 1
		end

		@ws.on :error do |e|
		  p e
		end
	end
end

ws_conn = ServerConn.new

# VIEW
loop do
	puts '====================='
	puts '======== MENU ======='
	puts '1 - Procurar partida online'
	puts '2 - Jogar contra o computador'
	puts '3 - Chat'
	puts '0 - Sair'
	
	cmd = nil
	input = STDIN.gets.strip

	case input
	when '1'
		cmd = Command.new('find_match')
		ws_conn.ws.send cmd.to_json
		loop do
			puts '======== partida ======='
			puts '1 - Passar vez'
			puts '2 - Comprar carta'
			puts '3 - Ver jogo'
			puts '0 - Sair'
			case STDIN.gets.strip
			when '1'
				play_cmd = Command.new('play', {play_msg: 'finish_turn'})
				ws_conn.ws.send play_cmd.to_json
			when '2'
				play_cmd = Command.new('play', {play_msg: 'draw'})
				ws_conn.ws.send play_cmd.to_json
			when '3'
				play_cmd = Command.new('play', {play_msg: 'full_data'})

			when '0'
				break
			end
		end
	when '2'
		cmd = Command.new('play_vs_bot')
		ws_conn.ws.send cmd.to_json
	when '3'
		puts 'Digite a mensagem: '
		cmd = Command.new('chat_global', {msg: STDIN.gets.strip})
		ws_conn.ws.send cmd.to_json
	when '0'
		break
	else
		puts 'invalid command'
	end
		
 	STDIN.gets.strip
end