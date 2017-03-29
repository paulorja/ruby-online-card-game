class Board

	attr_accessor :hero, :action, :support

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

	def total_atk
		total = 0
		puts "hero: #{@hero.atk} bonus: #{total_bonus_atk}"
		total = @hero.atk + total_bonus_atk 
	end

	def total_bonus_atk
		total = 0
		total += @action.bonus_atk unless @action.nil?
		total += @support.bonus_atk unless @support.nil?
		total
	end

end