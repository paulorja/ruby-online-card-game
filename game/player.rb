class Player

  attr_accessor :deck, :hand, :heroes, :board, :opponent

  	def initialize
    	@deck = Deck.new
    	@hand = Hand.new
    	@heroes = Heroes.new
    	@board = Board.new
    	@turn = Turn.new
    	@opponent = nil
  	end

	def draw(number = 1)
  		number.times do |n|
  			@hand.add @deck.top_card
  			@deck.remove_top_card
		end
	end

	def summon_hero(hero_index)
		hero = @heroes.find_by_index(hero_index)

		return 'hero not found' unless hero.is_a? HeroCard
		return 'the hero is not alive' unless hero.is_alive
		return 'already exists a hero on the board' unless @board.hero.nil?

		@board.hero = hero
	end

	def play_hand_card(hand_card_index)
		card = @hand.find_by_index(hand_card_index)

		return 'you dont have a hero' if @board.hero.nil?
		return 'card not found' unless card.is_a? ActionCard or card.is_a? SupportCard

		if card.is_a? ActionCard
			play_action_card(card)
			return
		end

		if card.is_a? SupportCard
			play_support_card(card)
			return
		end
	end

	private

	def play_action_card(action_card)
		unless @board.action.nil?
			puts 'already exists an action card on the board'
			return
		end

		@board.action = action_card
		puts "play action card #{action_card} complete"

		attack_opponent
		@board.action = nil
	end

	def play_support_card(support_card)

	end

	def attack_opponent
		@opponent.board.hero.decrease_hp(@board.total_atk)
		
		unless @opponent.board.hero.is_alive
			@opponent.board.hero = nil
		end
	end

end