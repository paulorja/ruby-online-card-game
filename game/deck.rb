class Deck < CardList


  def initialize
    super

    add GiantSword.new
    add Sword.new
    add Armor.new
    add Shield.new

    self.shuffle
    puts "Deck shuffle"
  end

  def top_card
    @card_list.last
  end

  def remove_top_card
    @card_list.delete(@card_list[-1])
  end

end