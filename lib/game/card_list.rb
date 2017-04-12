class CardList

  def initialize
    @card_list = []
  end

  def add(card)
    if card.is_a? Card
      @card_list.push card
    else
      raise 'need to be a card'
    end
  end

  def first
    if size > 0
      @card_list[1]
    else
      nil
    end
  end

  def shuffle
    @card_list = @card_list.shuffle
  end

  def all_cards
    @card_list
  end

  def all_card_names
    all_cards.map(&:class).map(&:to_s).map(&:underscore)
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

  def each(&block)
    @card_list.each(&block)
  end

  def size
    @card_list.size
  end

  protected

  def card_list
    @card_list
  end

end