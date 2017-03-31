class CardList

  def initialize
    @card_list = []
  end

  def add(card)
    @card_list.push card
  end

  def shuffle
    @card_list = @card_list.shuffle
  end

  def all_cards
    @card_list.inspect
  end

  def delete_at(index)
    @card_list.delete_at(index)
  end

  def find_by_index(index)
    if @card_list[index].nil?
      false
    else
      @card_list[index]
    end
  end

  def random_card_index
    rand(@card_list.size)
  end

  protected

  def card_list
    @card_list
  end

end