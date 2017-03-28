class PlayCommand

	attr_accessor :params, :name

	def initialize(command)
		@params = []
		@name = ""

		command.split(' ').each_with_index do |item, index|
			if index == 0
				@name = item
			else
				params.push item
			end
		end
	end

end