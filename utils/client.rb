require 'websocket-client-simple'
require 'json'
require 'colorize'

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
		true if @data['type'] == 'error'
	end
	def success?
		return false unless @is_valid
		true if @data['type'] == 'success'
	end
	def push?
		return false unless @is_valid
		true if @data['type'] == 'push'
	end
end

class DrawMatch
  def self.draw(full_match)
    puts `clear`
    puts '================================='
    puts "============ #{'OPPONENT'.red} ==========="
    puts '================================='
    puts '== HAND => ' + full_match['opponent']['hand'].to_s
    puts '== HERO => ' + full_match['opponent']['board']['hero']
    puts '================================='
    puts "============ #{'YOU'.blue} ================"
    puts '================================='
    puts '== HAND => ' + full_match['player']['hand'].join(', ')
    puts '== HERO => ' + full_match['player']['board']['hero']
    puts '================================='
  end
end

# Client Menu
class Menu
	def self.show(title, array_item, exit = false)
		if title.is_a? String
			puts " === === === #{title} === === === "
		else
			'title need to be a string'
		end
		if array_item.is_a? Array
			array_item.each_with_index do |item, index|
				puts "#{(index+1)} - #{item}"
			end
		end
		if exit
			puts '0 - Sair'
		end
	end
end

# WS
# conexao com o server
class ServerConn
	attr_accessor :ws
	def initialize
		@ws = WebSocket::Client::Simple.connect 'ws://127.0.0.1:3001'

		@ws.on :message do |msg|
			#puts 'Received: '.yellow + msg.data
			response = Response.new(msg.data)
			if response.is_valid
				if response.success? or response.push?
          case response.data['msg']
          when 'full_match'
            DrawMatch.draw response.data['full_match']
          else
            puts response.data['msg']
          end
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
  Menu.show('BEM VINDO', ['Procurar partida online', 'Jogar contra o computador', 'Chat'], true)
	
	cmd = nil
	input = STDIN.gets.strip

	case input
	when '1'
		cmd = Command.new('find_match')
		ws_conn.ws.send cmd.to_json
		loop do
      Menu.show('Partida', ['Passar vez', 'Comprar carta', 'Ver jogo', 'Jogar herói'], true)
			case STDIN.gets.strip
			when '1'
				play_cmd = Command.new('play', {play_msg: 'finish_turn'})
				ws_conn.ws.send play_cmd.to_json
			when '2'
				play_cmd = Command.new('play', {play_msg: 'draw'})
				ws_conn.ws.send play_cmd.to_json
			when '3'
				play_cmd = Command.new('play', {play_msg: 'full_match'})
				ws_conn.ws.send play_cmd.to_json
				when '4'
				Menu.show('Selecione um heroi', %w(arkantos ajax agamenon))
				hero_index = STDIN.gets.strip
      	play_cmd = Command.new('play', {play_msg: 'summon_hero', hero_index: hero_index})
				ws_conn.ws.send play_cmd.to_json
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
	end
		
 	STDIN.gets.strip
end