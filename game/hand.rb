class Hand < CardList

	def initialize
		super
	end

	def first_action_card_index
		@card_list.each_with_index do |card, index|
			if card.is_a? ActionCard
				return index
			end
		end
		nil
	end

end