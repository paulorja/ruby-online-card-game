class HeroCard < Card

	attr_accessor :atk, :def, :hp

  def initialize
  	@alive = true
  	@atk = 0
  	@def = 0
  	@hp = 0
  end

  def is_alive
  	@alive
  end

  def decrease_hp(number)
  	old_hp = @hp
  	@hp -= number
  	puts "decrease #{number} hp of #{self} from #{old_hp} to #{@hp}"
  end

end
