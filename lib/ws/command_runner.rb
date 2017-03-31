class CommandRunner

	def initialize(msg)
		begin
			hash_msg = JSON.parse(msg)
			puts hash_msg
			command_name = hash_msg['command_name']

			unless class_exists?(command_name)
				raise "#{command_name} class not exists"
			end

			command = Object::const_get(command_name).new
			if command.is_a? Command
				command.run
			else
				raise "#{command_name} is not a command"
			end
		rescue Exception => e
			puts e.message
		end
		
	end

	def class_exists?(class_name)
	  eval("defined?(#{class_name}) && #{class_name}.is_a?(Class)") == true
	end

end
