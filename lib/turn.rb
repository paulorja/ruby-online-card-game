class Turn

	attr_accessor :draw, :summon_hero

	def initialize
		@draw = false
		@summon_hero = false
		@action = false		
	end

	def reset
		@draw = false
		@summon_hero = false
		@action = false		
	end

end
