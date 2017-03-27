class Player

  attr_accessor :deck, :hand, :board

  def initialize
    @deck = Deck.new
    @hand = Hand.new
    @heroes = Heroes.new
    @board = Board.new
    @turn = Turn.new
    @finish_turn = false
  end

	def draw(number = 1)
  		number.times do |n|
  			@hand.add @deck.top_card
  			@deck.remove_top_card

  			puts "Draw"
		end
	end

	def summon_hero(hero_index)
		hero = @heroes.find_by_index(hero_index)

		unless hero.is_a? HeroCard
			puts 'hero not found'
			return
		end

		unless hero.is_alive
			puts 'the hero is not alive'
			return
		end

		unless @board.get_hero.nil?
			puts 'already exists a hero on the board'
			return
		end

		@board.set_hero(hero)
	end

	def finish_turn
		@finish_turn = true
	end

end