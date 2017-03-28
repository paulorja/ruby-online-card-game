class Board

	def initialize
		@hero = nil
		@action = nil
		@support = nil
	end

	def has_hero
		true unless @hero.nil?
	end

	def has_action
		true unless @action.nil?
	end

	def get_action
		@action
	end

	def set_action(action_card)
		@action = action_card
	end

	def get_hero
		@hero
	end

	def set_hero(hero)
		@hero = hero
	end

end