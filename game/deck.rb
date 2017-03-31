class Deck < CardList


  def initialize
    super

    add SimpleArmor.new
    add SimpleArmor.new
    add SimpleArmor.new
    add Shield1.new
    add Shield1.new
    add Shield1.new
    add Sword.new
    add Sword.new
    add Sword.new
  end

  def top_card
    @card_list.last
  end

  def remove_top_card
    @card_list.delete(@card_list[-1])
  end

end