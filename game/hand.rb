class Hand < CardList

	def initialize
		super
	end

	def random_card_index
		@card_list[rand(@card_list.size)]
	end

	def first_action_card_index
		@card_list.each do |card|
			return card if card.is_a? ActionCard
		end
		nil
	end

end