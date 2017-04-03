class CommandRunner

	def initialize(msg, ws, sid, server)
		begin
			hash_msg = JSON.parse(msg)
			puts hash_msg
			command_name = command_name_to_class_name(hash_msg['command_name'])

			unless class_exists?(command_name)
				raise "#{command_name} class not exists"
			end

			command = Object::const_get(command_name).new
			if command.is_a? Command
				command.ws = ws
				command.sid = sid
				command.server = server
				command.run
			else
				raise "#{command_name} is not a command"
			end
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect  
		end
		
	end

	def class_exists?(class_name)
	  eval("defined?(#{class_name}) && #{class_name}.is_a?(Class)") == true
	end

	def command_name_to_class_name(command_name)
	  command_name.split('_').map(&:capitalize).join('')+'Cmd'
	end

end
