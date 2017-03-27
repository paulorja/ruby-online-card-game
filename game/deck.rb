class Deck

  attr_accessor :cards

  def initialize
    @cards = [
      Arkantos.new, 
      Hercules.new, 
      GiantSword.new,
      Sword.new,
      Armor.new,
      Shield.new
    ]
  end

end
