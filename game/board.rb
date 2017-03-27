class Board

	def initialize
		@hero = nil
		@action = nil
		@support1 = nil
		@support2 = nil
	end

	def has_hero
		true unless @hero.nil?
	end

	def has_action
		true unless @action.nil?
	end

	def get_hero
		@hero
	end

	def set_hero(hero)
		@hero = hero
	end

end