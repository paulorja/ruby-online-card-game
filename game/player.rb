class Player

  attr_accessor :deck, :hand, :board, :opponent

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

		unless hero.is_a? HeroCard
			puts 'hero not found'
			return
		end

		unless hero.is_alive
			puts 'the hero is not alive'
			return
		end

		unless @board.hero.nil?
			puts 'already exists a hero on the board'
			return
		end

		@board.hero = hero
		puts "summon hero  #{hero} complete"
	end

	def play_hand_card(hand_card_index)
		card = @hand.find_by_index(hand_card_index)

		if @board.hero.nil?
			puts 'you dont have a hero'
			return
		end

		unless card.is_a? ActionCard or card.is_a? SupportCard
			puts 'card not found'
			return
		end

		if card.is_a? ActionCard
			play_action_card(card)
		end

		if card.is_a? SupportCard
			play_support_card(card)
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
	end

	def play_support_card(support_card)
	end

	def attack_opponent
		@opponent.board.hero.decrease_hp(@board.total_atk)
	end

end